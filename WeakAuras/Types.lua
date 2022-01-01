if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

local WeakAuras = WeakAuras;
local L = WeakAuras.L;

local LSM = LibStub("LibSharedMedia-3.0");

local wipe, tinsert = wipe, tinsert
local GetNumShapeshiftForms, GetShapeshiftFormInfo = GetNumShapeshiftForms, GetShapeshiftFormInfo

local function WA_GetClassColor(classFilename)
  local color = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[classFilename]
  if color and color.colorStr then
    return color.colorStr
  end

  return "ffffffff"
end

Private.glow_action_types = {
  show = L["Show"],
  hide = L["Hide"]
}

Private.glow_frame_types = {
  UNITFRAME = L["Unit Frame"],
  FRAMESELECTOR = L["Frame Selector"]
}

Private.circular_group_constant_factor_types = {
  RADIUS = L["Radius"],
  SPACING = L["Spacing"]
}

Private.frame_strata_types = {
  [1] = L["Inherited"],
  [2] = "BACKGROUND",
  [3] = "LOW",
  [4] = "MEDIUM",
  [5] = "HIGH",
  [6] = "DIALOG",
  [7] = "FULLSCREEN",
  [8] = "FULLSCREEN_DIALOG",
  [9] = "TOOLTIP"
}

Private.hostility_types = {
  hostile = L["Hostile"],
  friendly = L["Friendly"]
}

Private.character_types = {
  player = L["Player Character"],
  npc = L["Non-player Character"]
}

Private.group_sort_types = {
  ascending = L["Ascending"],
  descending = L["Descending"],
  hybrid = L["Hybrid"],
  none = L["None"],
  custom = L["Custom"]
}

Private.group_hybrid_position_types = {
  hybridFirst = L["Marked First"],
  hybridLast = L["Marked Last"]
}

Private.group_hybrid_sort_types = {
  ascending = L["Ascending"],
  descending = L["Descending"]
}

Private.time_format_types = {
  [0] = L["WeakAuras Built-In (63:42 | 3:07 | 10 | 2.4)"],
  [1] = L["Blizzard (2h | 3m | 10s | 2.4)"],
}

Private.time_precision_types = {
  [1] = "12.3",
  [2] = "12.34",
  [3] = "12.345",
}

Private.precision_types = {
  [0] = "12",
  [1] = "12.3",
  [2] = "12.34",
  [3] = "12.345",
}

Private.big_number_types = {
  ["AbbreviateNumbers"] = L["AbbreviateNumbers (Blizzard)"],
  ["AbbreviateLargeNumbers"] = L["AbbreviateLargeNumbers (Blizzard)"]
}

Private.round_types = {
  floor = L["Floor"],
  ceil = L["Ceil"],
  round = L["Round"]
}

Private.unit_color_types = {
  none = L["None"],
  class = L["Class"]
}

Private.unit_realm_name_types = {
  never = L["Never"],
  star = L["* Suffix"],
  differentServer = L["Only if on a different realm"],
  always = L["Always include realm"]
}

local timeFormatter = {}

local simpleFormatters = {
--[[
  AbbreviateNumbers = function(value, state)
    return (type(value) == "number") and AbbreviateNumbers(value) or value
  end,
  AbbreviateLargeNumbers = function(value, state)
    return (type(value) == "number") and AbbreviateLargeNumbers(Round(value)) or value
  end,
]]
  floor = function(value)
    return (type(value) == "number") and floor(value) or value
  end,
  ceil = function(value)
    return (type(value) == "number") and ceil(value) or value
  end,
  round = function(value)
    return (type(value) == "number") and Round(value) or value
  end,
  time = {
    [0] = function(value)
      if value > 60 then
        return string.format("%i:", math.floor(value / 60)) .. string.format("%02i", value % 60)
      else
        return string.format("%d", value)
      end
    end,
    -- Old Blizzard
    [1] = function(value)
      local fmt, time = SecondsToTimeAbbrev(value)
      -- Remove the space between the value and unit
      return fmt:gsub(" ", ""):format(time)
    end
  }
}

Private.format_types = {
  none = {
    display = L["None"],
    AddOptions = function() end,
    CreateFormatter = function() end
  },
  string = {
    display = L["String"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_abbreviate", {
        type = "toggle",
        name = L["Abbreviate"],
        width = WeakAuras.normalWidth,
        hidden = hidden,
      })
      addOption(symbol .. "_abbreviate_max", {
        type = "range",
        name = L["Max Char "],
        width = WeakAuras.normalWidth,
        min = 1,
        softMax = 20,
        hidden = hidden,
        step = 1,
        disabled = function()
          return not get(symbol .. "_abbreviate")
        end
      })
    end,
    CreateFormatter = function(symbol, get)
      local abbreviate = get(symbol .. "_abbreviate", false)
      local abbreviateMax = get(symbol .. "_abbreviate_max", 8)
      if abbreviate then
        return function(input)
          return WeakAuras.WA_Utf8Sub(input, abbreviateMax)
        end
      end
      return nil
    end
  },
  timed = {
    display = L["Time Format"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_time_format", {
        type = "select",
        name = L["Format"],
        width = WeakAuras.doubleWidth,
        values = Private.time_format_types,
        hidden = hidden
      })

      addOption(symbol .. "_time_dynamic_threshold", {
        type = "range",
        min = 0,
        max = 60,
        step = 1,
        name = L["Increase Precision Below"],
        width = WeakAuras.normalWidth,
        hidden = hidden,
      })

      addOption(symbol .. "_time_precision", {
        type = "select",
        name = L["Precision"],
        width = WeakAuras.normalWidth,
        values = Private.time_precision_types,
        hidden = hidden,
        disabled = function() return get(symbol .. "_time_dynamic_threshold") == 0 end
      })
    end,
    CreateFormatter = function(symbol, get)
      local format = get(symbol .. "_time_format", 0)
      local threshold = get(symbol .. "_time_dynamic_threshold", 60)
      local precision = get(symbol .. "_time_precision", 1)

      local mainFormater = simpleFormatters.time[format]
      if not mainFormater then
        mainFormater = simpleFormatters.time[0]
      end
      local formatter
      if threshold == 0 then
        formatter = function(value, state)
          if type(value) ~= 'number' or value == math.huge then
            return ""
          end
          if value <= 0 then
            return ""
          end
          return mainFormater(value)
        end
      else
        local formatString = "%." .. precision .. "f"
        formatter = function(value, state)
          if type(value) ~= 'number' or value == math.huge then
            return ""
          end
          if value <= 0 then
            return ""
          end
          if value < threshold then
            return string.format(formatString, value)
          else
            return mainFormater(value, state)
          end
        end
      end

      local triggerNum, sym = string.match(symbol, "(.+)%.(.+)")
      sym = sym or symbol
      if sym == "p" or sym == "t" then
        -- Special case %p and %t. Since due to how the formatting
        -- work previously, the time formatter only formats %p and %t
        -- if the progress type is timed!
        return function(value, state)
          if not state or state.progressType ~= "timed" then
            return value
          end
          return formatter(value, state)
        end
      else
        return formatter
      end
    end
  },
--[[
  BigNumber = {
    display = L["Big Number"],
    AddOptions = function(symbol, hidden, addOption)
      addOption(symbol .. "_big_number_format", {
        type = "select",
        name = L["Format"],
        width = WeakAuras.normalWidth,
        values = Private.big_number_types,
        hidden = hidden
      })
    end,
      addOption(symbol .. "_big_number_space", {
        type = "description",
        name = "",
        width = WeakAuras.normalWidth,
        hidden = hidden
      })
    CreateFormatter = function(symbol, get)
      local format = get(symbol .. "_big_number_format", "AbbreviateNumbers")
      if (format == "AbbreviateNumbers") then
        return simpleFormatters.AbbreviateNumbers
      end
      return simpleFormatters.AbbreviateLargeNumbers
    end
  },
]]
  Number = {
    display = L["Number"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_decimal_precision", {
        type = "select",
        name = L["Precision"],
        width = WeakAuras.normalWidth,
        values = Private.precision_types,
        hidden = hidden
      })
      addOption(symbol .. "_round_type", {
        type = "select",
        name = L["Round Mode"],
        width = WeakAuras.normalWidth,
        values = Private.round_types,
        hidden = hidden,
        disabled = function()
          return get(symbol .. "_decimal_precision") ~= 0
        end
      })
    end,
    CreateFormatter = function(symbol, get)
      local precision = get(symbol .. "_decimal_precision", 1)
      if precision == 0 then
        local type = get(symbol .. "_round_type", "floor")
        return simpleFormatters[type]
      else
        local format = "%." .. precision .. "f"
        return function(value)
          return (type(value) == "number") and string.format(format, value) or value
        end
      end
    end
  },
  Unit = {
    display = L["Formats |cFFFF0000%unit|r"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_color", {
        type = "select",
        name = L["Color"],
        width = WeakAuras.normalWidth,
        values = Private.unit_color_types,
        hidden = hidden,
      })
      addOption(symbol .. "_realm_name", {
        type = "select",
        name = L["Realm Name"],
        width = WeakAuras.normalWidth,
        values = Private.unit_realm_name_types,
        hidden = hidden,
      })
      addOption(symbol .. "_abbreviate", {
        type = "toggle",
        name = L["Abbreviate"],
        width = WeakAuras.normalWidth,
        hidden = hidden,
      })
      addOption(symbol .. "_abbreviate_max", {
        type = "range",
        name = L["Max Char "],
        width = WeakAuras.normalWidth,
        min = 1,
        max = 20,
        hidden = hidden,
        step = 1,
        disabled = function()
          return not get(symbol .. "_abbreviate")
        end
      })
    end,
    CreateFormatter = function(symbol, get)
      local color = get(symbol .. "_color", true)
      local realm = get(symbol .. "_realm_name", "never")
      local abbreviate = get(symbol .. "_abbreviate", false)
      local abbreviateMax = get(symbol .. "_abbreviate_max", 8)

      local nameFunc
      local colorFunc
      local abbreviateFunc
      if color == "class" then
        colorFunc = function(unit, text)
          if unit and UnitPlayerControlled(unit) then
            return string.format("|c%s%s|r", WA_GetClassColor(select(2, UnitClass(unit))), text)
          end
          return text
        end
      end

      if realm == "never" then
        nameFunc = function(unit)
          return unit and UnitName(unit)
        end
      elseif realm == "star" then
        nameFunc = function(unit)
          if not unit then
            return ""
          end
          local name, realm = UnitName(unit)
          if realm then
            return name .. "*"
          end
          return name
        end
      elseif realm == "differentServer" then
        nameFunc = function(unit)
          if not unit then
            return ""
          end
          local name, realm = UnitName(unit)
          if realm then
            return name .. "-" .. realm
          end
          return name
        end
      elseif realm == "always" then
        nameFunc = function(unit)
          if not unit then
            return ""
          end
          local name, realm = WeakAuras.UnitNameWithRealm(unit)
          return name .. "-" .. realm
        end
      end

      if abbreviate then
        abbreviateFunc = function(input)
          return WeakAuras.WA_Utf8Sub(input, abbreviateMax)
        end
      end

      -- Do the checks on what is necessary here instead of inside the returned
      -- formatter
      if colorFunc then
        if abbreviateFunc then
          return function(unit)
            local name = abbreviateFunc(nameFunc(unit))
            return colorFunc(unit, name)
          end
        else
          return function(unit)
            local name = nameFunc(unit)
            return colorFunc(unit, name)
          end
        end
      else
        if abbreviateFunc then
          return function(unit)
            local name = nameFunc(unit)
            return abbreviateFunc(name)
          end
        else
          return nameFunc
        end
      end
    end
  },
  guid = {
    display = L["Formats Player's |cFFFF0000%guid|r"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_color", {
        type = "select",
        name = L["Color"],
        width = WeakAuras.normalWidth,
        values = Private.unit_color_types,
        hidden = hidden,
      })
      addOption(symbol .. "_realm_name", {
        type = "select",
        name = L["Realm Name"],
        width = WeakAuras.normalWidth,
        values = Private.unit_realm_name_types,
        hidden = hidden,
      })
      addOption(symbol .. "_abbreviate", {
        type = "toggle",
        name = L["Abbreviate"],
        width = WeakAuras.normalWidth,
        hidden = hidden,
      })
      addOption(symbol .. "_abbreviate_max", {
        type = "range",
        name = L["Max Char "],
        width = WeakAuras.normalWidth,
        min = 1,
        max = 20,
        hidden = hidden,
        disabled = function()
          return not get(symbol .. "_abbreviate")
        end
      })
    end,
    CreateFormatter = function(symbol, get)
      local color = get(symbol .. "_color", true)
      local realm = get(symbol .. "_realm_name", "never")
      local abbreviate = get(symbol .. "_abbreviate", false)
      local abbreviateMax = get(symbol .. "_abbreviate_max", 8)

      local nameFunc
      local colorFunc
      local abbreviateFunc
      if color == "class" then
        colorFunc = function(class, text)
          return string.format("|c%s%s|r", WA_GetClassColor(class), text)
        end
      end

      if realm == "never" then
        nameFunc = function(name, realm)
          return name
        end
      elseif realm == "star" then
        nameFunc = function(name, realm)
          if realm ~= "" then
            return name .. "*"
          end
          return name
        end
      elseif realm == "differentServer" then
        nameFunc = function(name, realm)
          if realm ~= "" then
            return name .. "-" .. realm
          end
          return name
        end
      elseif realm == "always" then
        nameFunc = function(name, realm)
          if realm == "" then
            realm = select(2, WeakAuras.UnitNameWithRealm("player"))
          end
          return name .. "-" .. realm
        end
      end

      if abbreviate then
        abbreviateFunc = function(input)
          return WeakAuras.WA_Utf8Sub(input, abbreviateMax)
        end
      end

      -- Do the checks on what is necessary here instead of inside the returned
      -- formatter
      if colorFunc then
        if abbreviateFunc then
          return function(guid)
            local ok, _, class, _, _, _, name, realm = pcall(GetPlayerInfoByGUID, guid)
            if ok then
              local name = abbreviateFunc(nameFunc(name, realm))
              return colorFunc(class, name)
            end
          end
        else
          return function(guid)
            local ok, _, class, _, _, _, name, realm = pcall(GetPlayerInfoByGUID, guid)
            if ok then
              return colorFunc(class, nameFunc(name, realm))
            end
          end
        end
      else
        if abbreviateFunc then
          return function(guid)
            local ok, _, class, _, _, _, name, realm = pcall(GetPlayerInfoByGUID, guid)
            if ok then
              return abbreviateFunc(nameFunc(name, realm))
            end
          end
        else
          return function(guid)
            local ok, _, class, _, _, _, name, realm = pcall(GetPlayerInfoByGUID, guid)
            if ok then
              return nameFunc(name, realm)
            end
          end
        end
      end
    end
  },
  GCDTime = {
    display = L["Time in GCDs"],
    AddOptions = function(symbol, hidden, addOption, get)
      addOption(symbol .. "_gcd_gcd", {
        type = "toggle",
        name = L["Subtract GCD"],
        width = WeakAuras.normalWidth,
        hidden = hidden
      })
      addOption(symbol .. "_gcd_cast", {
        type = "toggle",
        name = L["Subtract Cast"],
        width = WeakAuras.normalWidth,
        hidden = hidden
      })
      addOption(symbol .. "_gcd_channel", {
        type = "toggle",
        name = L["Subtract Channel"],
        width = WeakAuras.normalWidth,
        hidden = hidden
      })
      addOption(symbol .. "_gcd_hide_zero", {
        type = "toggle",
        name = L["Hide 0 cooldowns"],
        width = WeakAuras.normalWidth,
        hidden = hidden
      })

      addOption(symbol .. "_decimal_precision", {
        type = "select",
        name = L["Precision"],
        width = WeakAuras.normalWidth,
        values = Private.precision_types,
        hidden = hidden
      })
      addOption(symbol .. "_round_type", {
        type = "select",
        name = L["Round Mode"],
        width = WeakAuras.normalWidth,
        values = Private.round_types,
        hidden = hidden,
        disabled = function()
          return get(symbol .. "_decimal_precision") ~= 0
        end
      })
    end,
    CreateFormatter = function(symbol, get)
      local gcd = get(symbol .. "_gcd_gcd", true)
      local cast = get(symbol .. "_gcd_cast", false)
      local channel = get(symbol .. "_gcd_channel", false)
      local hideZero = get(symbol .. "_gcd_hide_zero", false)
      local precision = get(symbol .. "_decimal_precision", 1)

      local numberToStringFunc
      if precision ~= 0 then
        local format = "%." .. precision .. "f"
        numberToStringFunc = function(number)
          return string.format(format, number)
        end
      else
        local type = get(symbol .. "_round_type", "ceil")
        numberToStringFunc = simpleFormatters[type]
      end

      return function(value, state)
        if state.progressType ~= "timed" or type(value) ~= "number" then
          return value
        end

        WeakAuras.WatchGCD()
        local result = value
        local now = GetTime()
        if gcd then
          local gcdDuration, gcdExpirationTime = WeakAuras.GetGCDInfo()
          if gcdDuration ~= 0 then
            result = now + value - gcdExpirationTime
          end
        end

        if cast then
          local _, _, _, _, endTime = UnitCastingInfo("player")
          local castExpirationTIme = endTime and endTime > 0 and (endTime / 1000) or 0
          if castExpirationTIme > 0 then
            result = min(result, now + value - castExpirationTIme)
          end
        end
        if channel then
          local _, _, _, _, endTime = UnitChannelInfo("player")
          local castExpirationTIme = endTime and endTime > 0 and (endTime / 1000) or 0
          if castExpirationTIme > 0 then
            result = min(result, now + value - castExpirationTIme)
          end
        end

        if result <= 0 then
          return hideZero and "" or "0"
        end

        return numberToStringFunc(result / WeakAuras.CalculatedGcdDuration())
      end
    end
  }
}

Private.format_types_display = {}
for k, v in pairs(Private.format_types) do Private.format_types_display[k] = v.display end


Private.sound_channel_types = {
  Master = L["Master"],
  SFX = ENABLE_SOUNDFX,
  Ambience = ENABLE_AMBIENCE,
  Music = ENABLE_MUSIC,
  Dialog = ENABLE_DIALOG
}

Private.sound_condition_types = {
  Play = L["Play"],
  Loop = L["Loop"],
  Stop = L["Stop"]
}

Private.trigger_require_types = {
  any = L["Any Triggers"],
  all = L["All Triggers"],
  custom = L["Custom Function"]
}

Private.trigger_require_types_one = {
  any = L["Trigger 1"],
  custom = L["Custom Function"]
}

Private.trigger_modes = {
  ["first_active"] = -10,
}

Private.debuff_types = {
  HELPFUL = L["Buff"],
  HARMFUL = L["Debuff"]
}

Private.tooltip_count = {
  [1] = L["First"],
  [2] = L["Second"],
  [3] = L["Third"]
}

Private.aura_types = {
  BUFF = L["Buff"],
  DEBUFF = L["Debuff"]
}

Private.debuff_class_types = {
  magic = L["Magic"],
  curse = L["Curse"],
  disease = L["Disease"],
  poison = L["Poison"],
  enrage = L["Enrage"],
  none = L["None"]
}

Private.unit_types = {
  player = L["Player"],
  target = L["Target"],
  focus = L["Focus"],
  group = L["Group"],
  member = L["Specific Unit"],
  pet = L["Pet"],
  multi = L["Multi-target"]
}

Private.unit_types_bufftrigger_2 = {
  player = L["Player"],
  target = L["Target"],
  focus = L["Focus"],
  group = L["Smart Group"],
  raid = L["Raid"],
  party = L["Party"],
  boss = L["Boss"],
  arena = L["Arena"],
  pet = L["Pet"],
  member = L["Specific Unit"],
  multi = L["Multi-target"]
}

Private.actual_unit_types_with_specific = {
  player = L["Player"],
  target = L["Target"],
  focus = L["Focus"],
  pet = L["Pet"],
  member = L["Specific Unit"]
}

Private.actual_unit_types_cast = {
  player = L["Player"],
  target = L["Target"],
  focus = L["Focus"],
  group = L["Smart Group"],
  party = L["Party"],
  raid = L["Raid"],
  boss = L["Boss"],
  arena = L["Arena"],
  pet = L["Pet"],
  member = L["Specific Unit"],
}

Private.actual_unit_types = { -- TODO
  player = L["Player"],
  target = L["Target"],
  focus = L["Focus"],
  pet = L["Pet"]
}

Private.threat_unit_types = {
  target = L["Target"],
  focus = L["Focus"],
  member = L["Specific Unit"],
  none = L["At Least One Enemy"]
}

Private.unit_types_range_check = {
  target = L["Target"],
  focus = L["Focus"],
  pet = L["Pet"],
  member = L["Specific Unit"]
}

Private.unit_threat_situation_types = {
  [-1] = L["Not On Threat Table"],
  [0] = "|cFFB0B0B0"..L["Lower Than Tank"],
  [1] = "|cFFFFFF77"..L["Higher Than Tank"],
  [2] = "|cFFFF9900"..L["Tanking But Not Highest"],
  [3] = "|cFFFF0000"..L["Tanking And Highest"]
}

WeakAuras.class_types = {}
for i, class in ipairs(CLASS_SORT_ORDER) do
  WeakAuras.class_types[class] = string.format("|c%s%s|r", WA_GetClassColor(class), LOCALIZED_CLASS_NAMES_MALE[class])
end

Private.faction_group = {
  Alliance = L["Alliance"],
  Horde = L["Horde"],
  Neutral = L["Neutral"]
}

Private.form_types = {};
local function update_forms()
  wipe(Private.form_types);
  Private.form_types[0] = "0 - "..L["Humanoid"]
  for i = 1, GetNumShapeshiftForms() do
    local _, name = GetShapeshiftFormInfo(i);
    if(name) then
      Private.form_types[i] = i.." - "..name
    end
  end
end
local form_frame = CreateFrame("frame");
form_frame:RegisterEvent("UPDATE_SHAPESHIFT_FORMS")
form_frame:RegisterEvent("PLAYER_LOGIN")
form_frame:SetScript("OnEvent", update_forms);

Private.blend_types = {
  ADD = L["Glow"],
  BLEND = L["Opaque"]
}

Private.slant_mode = {
  INSIDE = L["Keep Inside"],
  EXTEND = L["Extend Outside"]
}

Private.text_check_types = {
  update = L["Every Frame"],
  event = L["Trigger Update"]
}

Private.check_types = {
  update = L["Every Frame (High CPU usage)"],
  event = L["Event(s)"]
}

Private.point_types = {
  BOTTOMLEFT = L["Bottom Left"],
  BOTTOM = L["Bottom"],
  BOTTOMRIGHT = L["Bottom Right"],
  RIGHT = L["Right"],
  TOPRIGHT = L["Top Right"],
  TOP = L["Top"],
  TOPLEFT = L["Top Left"],
  LEFT = L["Left"],
  CENTER = L["Center"]
}

Private.default_types_for_anchor = {}
for k, v in pairs(Private.point_types) do
  Private.default_types_for_anchor[k] = {
    display = v,
    type = "point"
  }
end

Private.default_types_for_anchor["ALL"] = {
  display = L["Whole Area"],
  type = "area"
}

Private.aurabar_anchor_areas = {
  icon = L["Icon"],
  fg = L["Foreground"],
  bg = L["Background"],
  bar = L["Full Bar"],
}

Private.inverse_point_types = {
  BOTTOMLEFT = "TOPRIGHT",
  BOTTOM = "TOP",
  BOTTOMRIGHT = "TOPLEFT",
  RIGHT = "LEFT",
  TOPRIGHT = "BOTTOMLEFT",
  TOP = "BOTTOM",
  TOPLEFT = "BOTTOMRIGHT",
  LEFT = "RIGHT",
  CENTER = "CENTER"
}

Private.anchor_frame_types = {
  SCREEN = L["Screen/Parent Group"],
  MOUSE = L["Mouse Cursor"],
  SELECTFRAME = L["Select Frame"],
  UNITFRAME = L["Unit Frames"],
  CUSTOM = L["Custom"]
}

Private.anchor_frame_types_group = {
  SCREEN = L["Screen/Parent Group"],
  MOUSE = L["Mouse Cursor"],
  SELECTFRAME = L["Select Frame"],
  CUSTOM = L["Custom"]
}

Private.spark_rotation_types = {
  AUTO = L["Automatic Rotation"],
  MANUAL = L["Manual Rotation"]
}

Private.spark_hide_types = {
  NEVER = L["Never"],
  FULL  = L["Full"],
  EMPTY = L["Empty"],
  BOTH  = L["Full/Empty"]
}

Private.tick_placement_modes = {
  AtValue = L["At Value"],
  AtMissingValue = L["At missing Value"],
  AtPercent = L["At Percent"],
  ValueOffset = L["Offset from progress"]
}

Private.containment_types = { -- TODO
  OUTSIDE = L["Outside"],
  INSIDE = L["Inside"]
}

Private.font_flags = {
  None = L["None"],
  MONOCHROME = L["Monochrome"],
  OUTLINE = L["Outline"],
  THICKOUTLINE  = L["Thick Outline"],
  ["MONOCHROME|OUTLINE"] = L["Monochrome Outline"],
  ["MONOCHROME|THICKOUTLINE"] = L["Monochrome Thick Outline"]
}

Private.text_automatic_width = {
  Auto = L["Automatic"],
  Fixed = L["Fixed"]
}

Private.text_word_wrap = {
  WordWrap = L["Wrap"],
  Elide = L["Elide"]
}

Private.category_event_prototype = {}
for name, prototype in pairs(Private.event_prototypes) do
  Private.category_event_prototype[prototype.type] = Private.category_event_prototype[prototype.type] or {}
  Private.category_event_prototype[prototype.type][name] = prototype.name
end

Private.subevent_prefix_types = {
  SWING = L["Swing"],
  RANGE = L["Range"],
  SPELL = L["Spell"],
  SPELL_PERIODIC = L["Periodic Spell"],
  SPELL_BUILDING = L["Spell (Building)"],
  ENVIRONMENTAL = L["Environmental"],
  DAMAGE_SHIELD = L["Damage Shield"],
  DAMAGE_SPLIT = L["Damage Split"],
  DAMAGE_SHIELD_MISSED = L["Damage Shield Missed"],
  PARTY_KILL = L["Party Kill"],
  UNIT_DIED = L["Unit Died"],
  UNIT_DESTROYED = L["Unit Destroyed"],
  UNIT_DISSIPATES = L["Unit Dissipates"],
  ENCHANT_APPLIED = L["Enchant Applied"],
  ENCHANT_REMOVED = L["Enchant Removed"]
}

Private.subevent_actual_prefix_types = {
  SWING = L["Swing"],
  RANGE = L["Range"],
  SPELL = L["Spell"],
  SPELL_PERIODIC = L["Periodic Spell"],
  SPELL_BUILDING = L["Spell (Building)"],
  ENVIRONMENTAL = L["Environmental"]
}

Private.subevent_suffix_types = {
  _DAMAGE = L["Damage"],
  _MISSED = L["Missed"],
  _HEAL = L["Heal"],
  _ENERGIZE = L["Energize"],
  _DRAIN = L["Drain"],
  _LEECH = L["Leech"],
  _INTERRUPT = L["Interrupt"],
  _DISPEL = L["Dispel"],
  _DISPEL_FAILED = L["Dispel Failed"],
  _STOLEN = L["Stolen"],
  _EXTRA_ATTACKS = L["Extra Attacks"],
  _AURA_APPLIED = L["Aura Applied"],
  _AURA_REMOVED = L["Aura Removed"],
  _AURA_APPLIED_DOSE = L["Aura Applied Dose"],
  _AURA_REMOVED_DOSE = L["Aura Removed Dose"],
  _AURA_REFRESH = L["Aura Refresh"],
  _AURA_BROKEN = L["Aura Broken"],
  _AURA_BROKEN_SPELL = L["Aura Broken Spell"],
  _CAST_START = L["Cast Start"],
  _CAST_SUCCESS = L["Cast Success"],
  _CAST_FAILED = L["Cast Failed"],
  _INSTAKILL = L["Instakill"],
  _DURABILITY_DAMAGE = L["Durability Damage"],
  _DURABILITY_DAMAGE_ALL = L["Durability Damage All"],
  _CREATE = L["Create"],
  _SUMMON = L["Summon"],
  _RESURRECT = L["Resurrect"]
}

Private.power_types = {
  [0] = MANA,
  [1] = RAGE,
  [2] = FOCUS,
  [3] = ENERGY,
  [4] = HAPPINESS,
  [6] = RUNIC_POWER,
}

Private.miss_types = {
  ABSORB = L["Absorb"],
  BLOCK = L["Block"],
  DEFLECT = L["Deflect"],
  DODGE = L["Dodge"],
  EVADE = L["Evade"],
  IMMUNE = L["Immune"],
  MISS = L["Miss"],
  PARRY = L["Parry"],
  REFLECT = L["Reflect"],
  RESIST = L["Resist"]
}

Private.environmental_types = {
  Drowning = STRING_ENVIRONMENTAL_DAMAGE_DROWNING,
  Falling = STRING_ENVIRONMENTAL_DAMAGE_FALLING,
  Fatigue = STRING_ENVIRONMENTAL_DAMAGE_FATIGUE,
  Fire = STRING_ENVIRONMENTAL_DAMAGE_FIRE,
  Lava = STRING_ENVIRONMENTAL_DAMAGE_LAVA,
  Slime = STRING_ENVIRONMENTAL_DAMAGE_SLIME
}

Private.combatlog_flags_check_type = {
  Mine = L["Mine"],
  InGroup = L["In Group"],
  NotInGroup = L["Not in Group"]
}

Private.combatlog_flags_check_reaction = {
  Hostile = L["Hostile"],
  Neutral = L["Neutral"],
  Friendly = L["Friendly"]
}

Private.combatlog_flags_check_object_type = {
  Object = L["Object"],
  Guardian = L["Guardian"],
  Pet = L["Pet"],
  NPC = L["NPC"],
  Player = L["Player"]
}

Private.combatlog_raid_mark_check_type = {
  [0] = RAID_TARGET_NONE,
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_1:14|t " .. RAID_TARGET_1, -- Star
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_2:14|t " .. RAID_TARGET_2, -- Circle
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_3:14|t " .. RAID_TARGET_3, -- Diamond
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_4:14|t " .. RAID_TARGET_4, -- Triangle
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_5:14|t " .. RAID_TARGET_5, -- Moon
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_6:14|t " .. RAID_TARGET_6, -- Square
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_7:14|t " .. RAID_TARGET_7, -- Cross
  "|TInterface\\TARGETINGFRAME\\UI-RaidTargetingIcon_8:14|t " .. RAID_TARGET_8, -- Skull
  L["Any"]
}

Private.orientation_types = {
  HORIZONTAL_INVERSE = L["Left to Right"],
  HORIZONTAL = L["Right to Left"],
  VERTICAL = L["Bottom to Top"],
  VERTICAL_INVERSE = L["Top to Bottom"]
}

Private.orientation_with_circle_types = {
  HORIZONTAL_INVERSE = L["Left to Right"],
  HORIZONTAL = L["Right to Left"],
  VERTICAL = L["Bottom to Top"],
  VERTICAL_INVERSE = L["Top to Bottom"],
  CLOCKWISE = L["Clockwise"],
  ANTICLOCKWISE = L["Anticlockwise"]
}

Private.talent_types = {}
for tab = 1, 5 do
  for num_talent = 1, MAX_NUM_TALENTS do
    local talentId = (tab - 1)*MAX_NUM_TALENTS+num_talent
    Private.talent_types[talentId] = L["Tab "]..tab.." - "..num_talent
  end
end

Private.totem_types = {
  [1] = L["Fire"],
  [2] = L["Earth"],
  [3] = L["Water"],
  [4] = L["Air"]
}

Private.texture_types = {
  ["Blizzard Alerts"] = {
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\arcane_missiles"] = "Arcane Missiles",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\arcane_missiles_1"] = "Arcane Missiles 1",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\arcane_missiles_2"] = "Arcane Missiles 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\arcane_missiles_3"] = "Arcane Missiles 3",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\art_of_war"] = "Art of War",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\backlash"] = "Backlash",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\backlash_green"] = "Backlash_Green",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\bandits_guile"] = "Bandits Guile",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\berserk"] = "Berserk",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\blood_boil"] = "Blood Boil",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\blood_surge"] = "Blood Surge",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\brain_freeze"] = "Brain Freeze",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\dark_tiger"] = "Dark Tiger",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\dark_transformation"] = "Dark Transformation",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\daybreak"] = "Daybreak",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\demonic_core"] = "Demonic Core",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\demonic_core_vertical"] = "Demonic Core Vertical",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\denounce"] = "Denounce",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\echo_of_the_elements"] = "Echo of the Elements",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\eclipse_moon"] = "Eclipse Moon",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\eclipse_sun"] = "Eclipse Sun",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\feral_omenofclarity"] = "Feral Omenofclarity",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\focus_fire"] = "Focus Fire",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\frozen_fingers"] = "Frozen Fingers",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\fulmination"] = "Fulmination",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\fury_of_stormrage"] = "Fury of Stormrage",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_01"] = "Generic Arc 1",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_02"] = "Generic Arc 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_03"] = "Generic Arc 3",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_04"] = "Generic Arc 4",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_05"] = "Generic Arc 5",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\genericarc_06"] = "Generic Arc 6",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\generictop_01"] = "Generic Top 1",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\generictop_02"] = "Generic Top 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\grand_crusader"] = "Grand Crusader",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\hand_of_light"] = "Hand of Light",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\high_tide"] = "High Tide",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\hot_streak"] = "Hot Streak",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\imp_empowerment_green"] = "Imp Empowerment Green",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\imp_empowerment"] = "Imp Empowerment",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\impact"] = "Impact",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\killing_machine"] = "Killing Machine",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\lock_and_load"] = "Lock and Load",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\maelstrom_weapon_1"] = "Maelstrom Weapon 1",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\maelstrom_weapon_2"] = "Maelstrom Weapon 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\maelstrom_weapon_3"] = "Maelstrom Weapon 3",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\maelstrom_weapon_4"] = "Maelstrom Weapon 4",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\maelstrom_weapon"] = "Maelstrom Weapon",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\master_marksman"] = "Master Marksman",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\molten_core_green"] = "Molten Core Green",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\molten_core"] = "Molten Core",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_blackoutkick"] = "Monk Blackout Kick",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_ox_2"] = "Monk Ox 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_ox_3"] = "Monk Ox 3",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_ox"] = "Monk Ox",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_serpent"] = "Monk Serpent",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_tigerpalm"] = "Monk Tiger Palm",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\monk_tiger"] = "Monk Tiger",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\natures_grace"] = "Nature's Grace",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\necropolis"] = "Necropolis",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\nightfall"] = "Nightfall",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\predatory_swiftness_green"] = "Predatory Swiftness Green",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\predatory_swiftness"] = "Predatory Swiftness",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\raging_blow"] = "Raging Blow",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\rime"] = "Rime",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\serendipity"] = "Serendipity",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\shadow_word_insanity"] = "Shadow Word Insanity",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\shadow_of_death"] = "Shadow of Death",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\shooting_stars"] = "Shooting Stars",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\slice_and_dice"] = "Slice and Dice",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\spellactivationoverlay_0"] = "Spell Activation Overlay 0",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\sudden_death"] = "Sudden Death",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\sudden_doom"] = "Sudden Doom",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\surge_of_darkness"] = "Surge of Darkness",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\surge_of_light"] = "Surge of Light",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\sword_and_board"] = "Sword and Board",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\thrill_of_the_hunt_1"] = "Thrill of the Hunt 1",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\thrill_of_the_hunt_2"] = "Thrill of the Hunt 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\thrill_of_the_hunt_3"] = "Thrill of the Hunt 3",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\tooth_and_claw"] = "Tooth and Claw",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\ultimatum"] = "Ultimatum",
    ["Interface\\AddOns\\WeakAuras\\Media\\SpellActivationOverlays\\white_tiger"] = "White Tiger",
  },
  ["Icons"] = {
    ["Spells\\Agility_128"] = "Paw",
    ["Spells\\ArrowFeather01"] = "Feathers",
    ["Spells\\Aspect_Beast"] = "Lion",
    ["Spells\\Aspect_Cheetah"] = "Cheetah",
    ["Spells\\Aspect_Hawk"] = "Hawk",
    ["Spells\\Aspect_Monkey"] = "Monkey",
    ["Spells\\Aspect_Snake"] = "Snake",
    ["Spells\\Aspect_Wolf"] = "Wolf",
    ["Spells\\EndlessRage"] = "Rage",
    ["Spells\\Eye"] = "Eye",
    ["Spells\\Eyes"] = "Eyes",
    ["Spells\\Fire_Rune_128"] = "Fire",
    ["Spells\\HolyRuinProtect"] = "Holy Ruin",
    ["Spells\\Intellect_128"] = "Intellect",
    ["Spells\\MoonCrescentGlow2"] = "Crescent",
    ["Spells\\Nature_Rune_128"] = "Leaf",
    ["Spells\\PROTECT_128"] = "Shield",
    ["Spells\\Ice_Rune_128"] = "Snowflake",
    ["Spells\\PoisonSkull1"] = "Poison Skull",
    ["Spells\\InnerFire_Rune_128"] = "Inner Fire",
    ["Spells\\RapidFire_Rune_128"] = "Rapid Fire",
    ["Spells\\Rampage"] = "Rampage",
    ["Spells\\Reticle_128"] = "Reticle",
    ["Spells\\Stamina_128"] = "Bull",
    ["Spells\\Strength_128"] = "Crossed Swords",
    ["Spells\\StunWhirl_reverse"] = "Stun Whirl",
    ["Spells\\T_Star3"] = "Star",
    ["Spells\\Spirit1"] = "Spirit",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\cancel-icon.tga"] = "Cancel Icon",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\cancel-mark.tga"] = "Cancel Mark",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\emoji.tga"] = "Emoji",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\exclamation-mark.tga"] = "Exclamation Mark",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\eyes.tga"] = "Eyes",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\ok-icon.tga"] = "Ok Icon",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\targeting-mark.tga"] = "Targeting Mark",
  },
  ["Runes"] = {
    ["Spells\\starrune"] = "Star Rune",
    ["Spells\\RUNEBC1"] = "Heavy BC Rune",
    ["Spells\\RuneBC2"] = "Light BC Rune",
    ["Spells\\RUNEFROST"] = "Circular Frost Rune",
    ["Spells\\Rune1d_White"] = "Dense Circular Rune",
    ["Spells\\RUNE1D_GLOWLESS"] = "Sparse Circular Rune",
    ["Spells\\Rune1d"] = "Ringed Circular Rune",
    ["Spells\\Rune1c"] = "Filled Circular Rune",
    ["Spells\\RogueRune1"] = "Dual Blades",
    ["Spells\\RogueRune2"] = "Octagonal Skulls",
    ["Spells\\HOLY_RUNE1"] = "Holy Rune",
    ["Spells\\Holy_Rune_128"] = "Holy Cross Rune",
    ["Spells\\DemonRune5backup"] = "Demon Rune",
    ["Spells\\DemonRune6"] = "Demon Rune",
    ["Spells\\DemonRune7"] = "Demon Rune",
    ["Spells\\DemonicRuneSummon01"] = "Demonic Summon",
    ["Spells\\Death_Rune"] = "Death Rune",
    ["Spells\\DarkSummon"] = "Dark Summon",
    ["Spells\\AuraRune256b"] = "Square Aura Rune",
    ["Spells\\AURARUNE256"] = "Ringed Aura Rune",
    ["Spells\\AURARUNE8"] = "Spike-Ringed Aura Rune",
    ["Spells\\AuraRune7"] = "Tri-Circle Ringed Aura Rune",
    ["Spells\\AuraRune5Green"] = "Tri-Circle Aura Rune",
    ["Spells\\AURARUNE_C"] = "Oblong Aura Rune",
    ["Spells\\AURARUNE_B"] = "Sliced Aura Rune",
    ["Spells\\AURARUNE_A"] = "Small Tri-Circle Aura Rune"
  },
  ["PvP Emblems"] = {
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-1"] = "Wheelchair",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-2"] = "Recycle",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-3"] = "Biohazard",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-4"] = "Heart",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-5"] = "Lightning Bolt",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-6"] = "Bone",
    ["Interface\\PVPFrame\\PVP-Banner-Emblem-7"] = "Glove",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-2"] = "Bull",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-3"] = "Bird Claw",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-4"] = "Canary",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-5"] = "Mushroom",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-6"] = "Cherries",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-7"] = "Ninja",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-8"] = "Dog Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-9"] = "Circled Drop",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-10"] = "Circled Glove",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-11"] = "Winged Blade",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-12"] = "Circled Cross",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-13"] = "Dynamite",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-14"] = "Intellect",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-15"] = "Feather",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-16"] = "Present",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-17"] = "Giant Jaws",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-18"] = "Drums",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-19"] = "Panda",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-20"] = "Crossed Clubs",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-21"] = "Skeleton Key",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-22"] = "Heart Potion",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-23"] = "Trophy",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-24"] = "Crossed Mallets",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-25"] = "Circled Cheetah",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-26"] = "Mutated Chicken",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-27"] = "Anvil",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-28"] = "Dwarf Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-29"] = "Brooch",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-30"] = "Spider",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-31"] = "Dual Hawks",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-32"] = "Cleaver",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-33"] = "Spiked Bull",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-34"] = "Fist of Thunder",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-35"] = "Lean Bull",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-36"] = "Mug",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-37"] = "Sliced Circle",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-38"] = "Totem",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-39"] = "Skull and Crossbones",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-40"] = "Voodoo Doll",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-41"] = "Dual Wolves",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-42"] = "Wolf",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-43"] = "Crossed Wrenches",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-44"] = "Saber-toothed Tiger",
    --["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-45"] = "Targeting Eye", -- Duplicate of 53
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-46"] = "Artifact Disc",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-47"] = "Dice",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-48"] = "Fish Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-49"] = "Crossed Axes",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-50"] = "Doughnut",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-51"] = "Human Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-52"] = "Eyeball",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-53"] = "Targeting Eye",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-54"] = "Monkey Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-55"] = "Circle Skull",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-56"] = "Tipped Glass",
    --["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-57"] = "Saber-toothed Tiger", -- Duplicate of 44
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-58"] = "Pile of Weapons",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-59"] = "Mushrooms",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-60"] = "Pounding Mallet",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-61"] = "Winged Mask",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-62"] = "Axe",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-63"] = "Spiked Shield",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-64"] = "The Horns",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-65"] = "Ice Cream Cone",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-66"] = "Ornate Lockbox",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-67"] = "Roasting Marshmallow",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-68"] = "Smiley Bomb",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-69"] = "Fist",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-70"] = "Spirit Wings",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-71"] = "Ornate Pipe",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-72"] = "Scarab",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-73"] = "Glowing Ball",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-74"] = "Circular Rune",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-75"] = "Tree",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-76"] = "Flower Pot",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-77"] = "Night Elf Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-78"] = "Nested Egg",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-79"] = "Helmed Chicken",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-80"] = "Winged Boot",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-81"] = "Skull and Cross-Wrenches",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-82"] = "Cracked Skull",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-83"] = "Rocket",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-84"] = "Wooden Whistle",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-85"] = "Cogwheel",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-86"] = "Lizard Eye",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-87"] = "Baited Hook",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-88"] = "Beast Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-89"] = "Talons",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-90"] = "Rabbit",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-91"] = "4-Toed Pawprint",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-92"] = "Paw",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-93"] = "Mask",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-94"] = "Spiked Helm",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-95"] = "Dog Treat",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-96"] = "Targeted Orc",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-97"] = "Bird Face",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-98"] = "Lollipop",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-99"] = "5-Toed Pawprint",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-100"] = "Frightened Cat",
    ["Interface\\PVPFrame\\Icons\\PVP-Banner-Emblem-101"] = "Eagle Face"
  },
  ["Beams"] = {
    ["Textures\\SPELLCHAINEFFECTS\\Beam_Purple"] = "Purple Beam",
    ["Textures\\SPELLCHAINEFFECTS\\Beam_Red"] = "Red Beam",
    ["Textures\\SPELLCHAINEFFECTS\\Beam_RedDrops"] = "Red Drops Beam",
    ["Textures\\SPELLCHAINEFFECTS\\DrainManaLightning"] = "Drain Mana Lightning",
    ["Textures\\SPELLCHAINEFFECTS\\Ethereal_Ribbon_Spell"] = "Ethereal Ribbon",
    ["Textures\\SPELLCHAINEFFECTS\\Ghost1_Chain"] = "Ghost Chain",
    ["Textures\\SPELLCHAINEFFECTS\\Ghost2purple_Chain"] = "Purple Ghost Chain",
    ["Textures\\SPELLCHAINEFFECTS\\HealBeam"] = "Heal Beam",
    ["Textures\\SPELLCHAINEFFECTS\\Lightning"] = "Lightning",
    ["Textures\\SPELLCHAINEFFECTS\\LightningRed"] = "Red Lightning",
    ["Textures\\SPELLCHAINEFFECTS\\ManaBeam"] = "Mana Beam",
    ["Textures\\SPELLCHAINEFFECTS\\ManaBurnBeam"] = "Mana Burn Beam",
    ["Textures\\SPELLCHAINEFFECTS\\RopeBeam"] = "Rope",
    ["Textures\\SPELLCHAINEFFECTS\\ShockLightning"] = "Shock Lightning",
    ["Textures\\SPELLCHAINEFFECTS\\SoulBeam"] = "Soul Beam",
    ["Spells\\TEXTURES\\Beam_ChainGold"] = "Gold Chain",
    ["Spells\\TEXTURES\\Beam_ChainIron"] = "Iron Chain",
    ["Spells\\TEXTURES\\Beam_FireGreen"] = "Green Fire Beam",
    ["Spells\\TEXTURES\\Beam_FireRed"] = "Red Fire Beam",
    ["Spells\\TEXTURES\\Beam_Purple_02"] = "Straight Purple Beam",
    ["Spells\\TEXTURES\\Beam_Shadow_01"] = "Shadow Beam",
    ["Spells\\TEXTURES\\Beam_SmokeBrown"] = "Brown Smoke Beam",
    ["Spells\\TEXTURES\\Beam_SmokeGrey"] = "Grey Smoke Beam",
    ["Spells\\TEXTURES\\Beam_SpiritLink"] = "Spirit Link Beam",
    ["Spells\\TEXTURES\\Beam_SummonGargoyle"] = "Summon Gargoyle Beam",
    ["Spells\\TEXTURES\\Beam_VineGreen"] = "Green Vine",
    ["Spells\\TEXTURES\\Beam_VineRed"] = "Red Vine",
    ["Spells\\TEXTURES\\Beam_WaterBlue"] = "Blue Water Beam",
    ["Spells\\TEXTURES\\Beam_WaterGreen"] = "Green Water Beam",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\rainbowbar"] = "Rainbow Bar",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\StripedTexture"] = "Striped Bar",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\stripe-bar.tga"] = "Striped Bar 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\stripe-rainbow-bar.tga"] = "Rainbow Bar 2",
  },
  ["Shapes"] = {
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Smooth"] = "Smooth Circle",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Smooth_Border"] = "Smooth Circle with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Squirrel"] = "Spiralled Circle",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Squirrel_Border"] = "Spiralled Circle with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White"] = "Circle",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_White_Border"] = "Circle with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Smooth"] = "Smooth Square",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Smooth_Border"] = "Smooth Square with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Smooth_Border2"] = "Smooth Square with Border 2",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Squirrel"] = "Spiralled Square",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_Squirrel_Border"] = "Spiralled Square with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White"] = "Square",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_White_Border"] = "Square with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_FullWhite"] = "Full White Square",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Triangle45"] = "45° Triangle",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Trapezoid"] = "Trapezoid",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\triangle-border.tga"] = "Triangle with Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\triangle.tga"] = "Triangle",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_Smooth2.tga"] = "Smooth Circle Small",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\circle_border5.tga"] = "Circle Border",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\ring_glow3.tga"] = "Circle Border Glow",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\square_mini.tga"] = "Small Square",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\target_indicator.tga"] = "Target Indicator",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\target_indicator_glow.tga"] = "Target Indicator Glow",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\arrows_target.tga"] = "Arrows Target",

    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_AlphaGradient_In.tga"] = "Circle Alpha Gradient In",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Circle_AlphaGradient_Out.tga"] = "Circle Alpha Gradient Out",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Ring_10px.tga"] = "Ring 10px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Ring_20px.tga"] = "Ring 20px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Ring_30px.tga"] = "Ring 30px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Ring_40px.tga"] = "Ring 40px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\Square_AlphaGradient.tga"] = "Square Alpha Gradient",

    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\square_border_1px.tga"] = "Square Border 1px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\square_border_5px.tga"] = "Square Border 5px",
    ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\square_border_10px.tga"] = "Square Border 10px",
  },
  ["Sparks"] = {
    ["Interface\\CastingBar\\UI-CastingBar-Spark"] = "Blizzard Spark",
    ["Interface\\GLUES\\LoadingBar\\UI-LoadingBar-Spark"] = "Loading Bar Spark",
    ["Creature\\GOBLIN\\SPARK"] = "Goblin Spark",
  },
  [BINDING_HEADER_RAID_TARGET] = {
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_1"] = RAID_TARGET_1,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_2"] = RAID_TARGET_2,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_3"] = RAID_TARGET_3,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_4"] = RAID_TARGET_4,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_5"] = RAID_TARGET_5,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_6"] = RAID_TARGET_6,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_7"] = RAID_TARGET_7,
    ["Interface\\TargetingFrame\\UI-RaidTargetingIcon_8"] = RAID_TARGET_8,
  }
}

local PowerAurasPath = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\"
Private.texture_types["PowerAuras Heads-Up"] = {
  [PowerAurasPath.."Aura1"] = "Runed Text",
  [PowerAurasPath.."Aura2"] = "Runed Text On Ring",
  [PowerAurasPath.."Aura3"] = "Power Waves",
  [PowerAurasPath.."Aura4"] = "Majesty",
  [PowerAurasPath.."Aura5"] = "Runed Ends",
  [PowerAurasPath.."Aura6"] = "Extra Majesty",
  [PowerAurasPath.."Aura7"] = "Triangular Highlights",
  [PowerAurasPath.."Aura11"] = "Oblong Highlights",
  [PowerAurasPath.."Aura16"] = "Thin Crescents",
  [PowerAurasPath.."Aura17"] = "Crescent Highlights",
  [PowerAurasPath.."Aura18"] = "Dense Runed Text",
  [PowerAurasPath.."Aura23"] = "Runed Spiked Ring",
  [PowerAurasPath.."Aura24"] = "Smoke",
  [PowerAurasPath.."Aura28"] = "Flourished Text",
  [PowerAurasPath.."Aura33"] = "Droplet Highlights"
}
Private.texture_types["PowerAuras Icons"] = {
  [PowerAurasPath.."Aura8"] = "Rune",
  [PowerAurasPath.."Aura9"] = "Stylized Ghost",
  [PowerAurasPath.."Aura10"] = "Skull and Crossbones",
  [PowerAurasPath.."Aura12"] = "Snowflake",
  [PowerAurasPath.."Aura13"] = "Flame",
  [PowerAurasPath.."Aura14"] = "Holy Rune",
  [PowerAurasPath.."Aura15"] = "Zig-Zag Exclamation Point",
  [PowerAurasPath.."Aura19"] = "Crossed Swords",
  [PowerAurasPath.."Aura21"] = "Shield",
  [PowerAurasPath.."Aura22"] = "Glow",
  [PowerAurasPath.."Aura25"] = "Cross",
  [PowerAurasPath.."Aura26"] = "Droplet",
  [PowerAurasPath.."Aura27"] = "Alert",
  [PowerAurasPath.."Aura29"] = "Paw",
  [PowerAurasPath.."Aura30"] = "Bull",
  --   [PowerAurasPath.."Aura31"] = "Hieroglyphics Horizontal",
  [PowerAurasPath.."Aura32"] = "Hieroglyphics",
  [PowerAurasPath.."Aura34"] = "Circled Arrow",
  [PowerAurasPath.."Aura35"] = "Short Sword",
  --   [PowerAurasPath.."Aura36"] = "Short Sword Horizontal",
  [PowerAurasPath.."Aura45"] = "Circular Glow",
  [PowerAurasPath.."Aura48"] = "Totem",
  [PowerAurasPath.."Aura49"] = "Dragon Blade",
  [PowerAurasPath.."Aura50"] = "Ornate Design",
  [PowerAurasPath.."Aura51"] = "Inverted Holy Rune",
  [PowerAurasPath.."Aura52"] = "Stylized Skull",
  [PowerAurasPath.."Aura53"] = "Exclamation Point",
  [PowerAurasPath.."Aura54"] = "Nonagon",
  [PowerAurasPath.."Aura68"] = "Wings",
  [PowerAurasPath.."Aura69"] = "Rectangle",
  [PowerAurasPath.."Aura70"] = "Low Mana",
  [PowerAurasPath.."Aura71"] = "Ghostly Eye",
  [PowerAurasPath.."Aura72"] = "Circle",
  [PowerAurasPath.."Aura73"] = "Ring",
  [PowerAurasPath.."Aura74"] = "Square",
  [PowerAurasPath.."Aura75"] = "Square Brackets",
  [PowerAurasPath.."Aura76"] = "Bob-omb",
  [PowerAurasPath.."Aura77"] = "Goldfish",
  [PowerAurasPath.."Aura78"] = "Check",
  [PowerAurasPath.."Aura79"] = "Ghostly Face",
  [PowerAurasPath.."Aura84"] = "Overlapping Boxes",
  --   [PowerAurasPath.."Aura85"] = "Overlapping Boxes 45°",
  --   [PowerAurasPath.."Aura86"] = "Overlapping Boxes 270°",
  [PowerAurasPath.."Aura87"] = "Fairy",
  [PowerAurasPath.."Aura88"] = "Comet",
  [PowerAurasPath.."Aura95"] = "Dual Spiral",
  [PowerAurasPath.."Aura96"] = "Japanese Character",
  [PowerAurasPath.."Aura97"] = "Japanese Character",
  [PowerAurasPath.."Aura98"] = "Japanese Character",
  [PowerAurasPath.."Aura99"] = "Japanese Character",
  [PowerAurasPath.."Aura100"] = "Japanese Character",
  [PowerAurasPath.."Aura101"] = "Ball of Flame",
  [PowerAurasPath.."Aura102"] = "Zig-Zag",
  [PowerAurasPath.."Aura103"] = "Thorny Ring",
  [PowerAurasPath.."Aura110"] = "Hunter's Mark",
  --   [PowerAurasPath.."Aura111"] = "Hunter's Mark Horizontal",
  [PowerAurasPath.."Aura112"] = "Kaleidoscope",
  [PowerAurasPath.."Aura113"] = "Jesus Face",
  [PowerAurasPath.."Aura114"] = "Green Mushroom",
  [PowerAurasPath.."Aura115"] = "Red Mushroom",
  [PowerAurasPath.."Aura116"] = "Fire Flower",
  [PowerAurasPath.."Aura117"] = "Radioactive",
  [PowerAurasPath.."Aura118"] = "X",
  [PowerAurasPath.."Aura119"] = "Flower",
  [PowerAurasPath.."Aura120"] = "Petal",
  [PowerAurasPath.."Aura130"] = "Shoop Da Woop",
  [PowerAurasPath.."Aura131"] = "8-Bit Symbol",
  [PowerAurasPath.."Aura132"] = "Cartoon Skull",
  [PowerAurasPath.."Aura138"] = "Stop",
  [PowerAurasPath.."Aura139"] = "Thumbs Up",
  [PowerAurasPath.."Aura140"] = "Palette",
  [PowerAurasPath.."Aura141"] = "Blue Ring",
  [PowerAurasPath.."Aura142"] = "Ornate Ring",
  [PowerAurasPath.."Aura143"] = "Ghostly Skull"
}
Private.texture_types["PowerAuras Separated"] = {
  [PowerAurasPath.."Aura46"] = "8-Part Ring 1",
  [PowerAurasPath.."Aura47"] = "8-Part Ring 2",
  [PowerAurasPath.."Aura55"] = "Skull on Gear 1",
  [PowerAurasPath.."Aura56"] = "Skull on Gear 2",
  [PowerAurasPath.."Aura57"] = "Skull on Gear 3",
  [PowerAurasPath.."Aura58"] = "Skull on Gear 4",
  [PowerAurasPath.."Aura59"] = "Rune Ring Full",
  [PowerAurasPath.."Aura60"] = "Rune Ring Empty",
  [PowerAurasPath.."Aura61"] = "Rune Ring Left",
  [PowerAurasPath.."Aura62"] = "Rune Ring Right",
  [PowerAurasPath.."Aura63"] = "Spiked Rune Ring Full",
  [PowerAurasPath.."Aura64"] = "Spiked Rune Ring Empty",
  [PowerAurasPath.."Aura65"] = "Spiked Rune Ring Left",
  [PowerAurasPath.."Aura66"] = "Spiked Rune Ring Bottom",
  [PowerAurasPath.."Aura67"] = "Spiked Rune Ring Right",
  [PowerAurasPath.."Aura80"] = "Spiked Helm Background",
  [PowerAurasPath.."Aura81"] = "Spiked Helm Full",
  [PowerAurasPath.."Aura82"] = "Spiked Helm Bottom",
  [PowerAurasPath.."Aura83"] = "Spiked Helm Top",
  [PowerAurasPath.."Aura89"] = "5-Part Ring 1",
  [PowerAurasPath.."Aura90"] = "5-Part Ring 2",
  [PowerAurasPath.."Aura91"] = "5-Part Ring 3",
  [PowerAurasPath.."Aura92"] = "5-Part Ring 4",
  [PowerAurasPath.."Aura93"] = "5-Part Ring 5",
  [PowerAurasPath.."Aura94"] = "5-Part Ring Full",
  [PowerAurasPath.."Aura104"] = "Shield Center",
  [PowerAurasPath.."Aura105"] = "Shield Full",
  [PowerAurasPath.."Aura106"] = "Shield Top Right",
  [PowerAurasPath.."Aura107"] = "Shiled Top Left",
  [PowerAurasPath.."Aura108"] = "Shield Bottom Right",
  [PowerAurasPath.."Aura109"] = "Shield Bottom Left",
  [PowerAurasPath.."Aura121"] = "Vine Top Right Leaf",
  [PowerAurasPath.."Aura122"] = "Vine Left Leaf",
  [PowerAurasPath.."Aura123"] = "Vine Bottom Right Leaf",
  [PowerAurasPath.."Aura124"] = "Vine Stem",
  [PowerAurasPath.."Aura125"] = "Vine Thorns",
  [PowerAurasPath.."Aura126"] = "3-Part Circle 1",
  [PowerAurasPath.."Aura127"] = "3-Part Circle 2",
  [PowerAurasPath.."Aura128"] = "3-Part Circle 3",
  [PowerAurasPath.."Aura129"] = "3-Part Circle Full",
  [PowerAurasPath.."Aura133"] = "Sliced Orb 1",
  [PowerAurasPath.."Aura134"] = "Sliced Orb 2",
  [PowerAurasPath.."Aura135"] = "Sliced Orb 3",
  [PowerAurasPath.."Aura136"] = "Sliced Orb 4",
  [PowerAurasPath.."Aura137"] = "Sliced Orb 5",
  [PowerAurasPath.."Aura144"] = "Taijitu Bottom",
  [PowerAurasPath.."Aura145"] = "Taijitu Top"
}

Private.texture_types["PowerAuras Words"] = {
  [PowerAurasPath.."Aura20"] = "Power",
  [PowerAurasPath.."Aura37"] = "Slow",
  [PowerAurasPath.."Aura38"] = "Stun",
  [PowerAurasPath.."Aura39"] = "Silence",
  [PowerAurasPath.."Aura40"] = "Root",
  [PowerAurasPath.."Aura41"] = "Disorient",
  [PowerAurasPath.."Aura42"] = "Dispel",
  [PowerAurasPath.."Aura43"] = "Danger",
  [PowerAurasPath.."Aura44"] = "Buff",
  [PowerAurasPath.."Aura44"] = "Buff",
  ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\interrupt"] = "Interrupt"
}

Private.operator_types = {
  ["=="] = "=",
  ["~="] = "!=",
  [">"] = ">",
  ["<"] = "<",
  [">="] = ">=",
  ["<="] = "<="
}

Private.equality_operator_types = {
  ["=="] = "=",
  ["~="] = "!="
}

Private.operator_types_without_equal = {
  [">="] = ">=",
  ["<="] = "<="
}

Private.string_operator_types = {
  ["=="] = L["Is Exactly"],
  ["find('%s')"] = L["Contains"],
  ["match('%s')"] = L["Matches (Pattern)"]
}

Private.weapon_types = {
  ["main"] = MAINHANDSLOT,
  ["off"] = SECONDARYHANDSLOT
}

Private.swing_types = {
  ["main"] = MAINHANDSLOT,
  ["off"] = SECONDARYHANDSLOT,
  ["ranged"] = RANGEDSLOT
}

Private.rune_specific_types = {
  [1] = L["Blood Rune #1"],
  [2] = L["Blood Rune #2"],
  [3] = L["Unholy Rune #1"],
  [4] = L["Unholy Rune #2"],
  [5] = L["Frost Rune #1"],
  [6] = L["Frost Rune #2"]
}

Private.custom_trigger_types = {
  ["event"] = L["Event"],
  ["status"] = L["Status"],
  ["stateupdate"] = L["Trigger State Updater (Advanced)"]
}

Private.eventend_types = {
  ["timed"] = L["Timed"],
  ["custom"] = L["Custom"]
}

Private.autoeventend_types = {
  ["auto"] = L["Automatic"],
  ["custom"] = L["Custom"]
}

Private.timedeventend_types = {
  ["timed"] = L["Timed"],
}

Private.justify_types = {
  ["LEFT"] = L["Left"],
  ["CENTER"] = L["Center"],
  ["RIGHT"] = L["Right"]
}

Private.grow_types = {
  ["LEFT"] = L["Left"],
  ["RIGHT"] = L["Right"],
  ["UP"] = L["Up"],
  ["DOWN"] = L["Down"],
  ["HORIZONTAL"] = L["Centered Horizontal"],
  ["VERTICAL"] = L["Centered Vertical"],
  ["CIRCLE"] = L["Counter Clockwise"],
  ["COUNTERCIRCLE"] = L["Clockwise"],
  ["GRID"] = L["Grid"],
  ["CUSTOM"] = L["Custom"],
}

-- horizontal types: R (right), L (left)
-- vertical types: U (up), D (down)
Private.grid_types = {
  RU = L["Right, then Up"],
  UR = L["Up, then Right"],
  LU = L["Left, then Up"],
  UL = L["Up, then Left"],
  RD = L["Right, then Down"],
  DR = L["Down, then Right"],
  LD = L["Left, then Down"],
  DL = L["Down, then Left"],
}

Private.text_rotate_types = {
  ["LEFT"] = L["Left"],
  ["NONE"] = L["None"],
  ["RIGHT"] = L["Right"]
}

Private.align_types = {
  ["LEFT"] = L["Left"],
  ["CENTER"] = L["Center"],
  ["RIGHT"] = L["Right"]
}

Private.rotated_align_types = {
  ["LEFT"] = L["Top"],
  ["CENTER"] = L["Center"],
  ["RIGHT"] = L["Bottom"]
}

Private.icon_side_types = {
  ["LEFT"] = L["Left"],
  ["RIGHT"] = L["Right"]
}

Private.rotated_icon_side_types = {
  ["LEFT"] = L["Top"],
  ["RIGHT"] = L["Bottom"]
}

Private.anim_types = {
  none = L["None"],
  preset = L["Preset"],
  custom = L["Custom"]
}

Private.anim_ease_types = {
  none = L["None"],
  easeIn = L["Ease In"],
  easeOut = L["Ease Out"],
  easeOutIn = L["Ease In and Out"]
}

Private.anim_ease_functions = {
  none = function(percent) return percent end,
  easeIn = function(percent, power)
    return percent ^ power;
  end,
  easeOut = function(percent, power)
    return 1.0 - (1.0 - percent) ^ power;
  end,
  easeOutIn = function(percent, power)
    if percent < .5 then
        return (percent * 2.0) ^ power * .5;
    end
    return 1.0 - ((1.0 - percent) * 2.0) ^ power * .5;
  end
}

Private.anim_translate_types = {
  straightTranslate = L["Normal"],
  circle = L["Circle"],
  spiral = L["Spiral"],
  spiralandpulse = L["Spiral In And Out"],
  shake = L["Shake"],
  bounce = L["Bounce"],
  bounceDecay = L["Bounce with Decay"],
  custom = L["Custom Function"]
}

Private.anim_scale_types = {
  straightScale = L["Normal"],
  pulse = L["Pulse"],
  fauxspin = L["Spin"],
  fauxflip = L["Flip"],
  custom = L["Custom Function"]
}

Private.anim_alpha_types = {
  straight = L["Normal"],
  alphaPulse = L["Pulse"],
  hide = L["Hide"],
  custom = L["Custom Function"]
}

Private.anim_rotate_types = {
  straight = L["Normal"],
  backandforth = L["Back and Forth"],
  wobble = L["Wobble"],
  custom = L["Custom Function"]
}

Private.anim_color_types = {
  straightColor = L["Legacy RGB Gradient"],
  straightHSV = L["Gradient"],
  pulseColor = L["Legacy RGB Gradient Pulse"],
  pulseHSV = L["Gradient Pulse"],
  custom = L["Custom Function"]
}

Private.instance_types = {
  none = L["No Instance"],
  party = L["5 Man Dungeon"],
  ten = L["10 Man Raid"],
  twenty = L["20 Man Raid"],
  twentyfive = L["25 Man Raid"],
  fortyman = L["40 Man Raid"],
  pvp = L["Battleground"],
  arena = L["Arena"]
}

Private.group_types = {
  solo = L["Not in Group"],
  group = L["In Group"],
  raid = L["In Raid"]
}

Private.difficulty_types = {
  none = L["None"],
  normal = PLAYER_DIFFICULTY1,
  heroic = PLAYER_DIFFICULTY2
}

Private.classification_types = {
  worldboss = L["World Boss"],
  rareelite = L["Rare Elite"],
  elite = L["Elite"],
  rare = L["Rare"],
  normal = L["Normal"],
  trivial = L["Trivial (Low Level)"]
}

Private.anim_start_preset_types = {
  slidetop = L["Slide from Top"],
  slideleft = L["Slide from Left"],
  slideright = L["Slide from Right"],
  slidebottom = L["Slide from Bottom"],
  fade = L["Fade In"],
  shrink = L["Grow"],
  grow = L["Shrink"],
  spiral = L["Spiral"],
  bounceDecay = L["Bounce"],
  starShakeDecay = L["Star Shake"],
}

Private.anim_main_preset_types = {
  shake = L["Shake"],
  spin = L["Spin"],
  flip = L["Flip"],
  wobble = L["Wobble"],
  pulse = L["Pulse"],
  alphaPulse = L["Flash"],
  rotateClockwise = L["Rotate Right"],
  rotateCounterClockwise = L["Rotate Left"],
  spiralandpulse = L["Spiral"],
  orbit = L["Orbit"],
  bounce = L["Bounce"]
}

Private.anim_finish_preset_types = {
  slidetop = L["Slide to Top"],
  slideleft = L["Slide to Left"],
  slideright = L["Slide to Right"],
  slidebottom = L["Slide to Bottom"],
  fade = L["Fade Out"],
  shrink = L["Shrink"],
  grow =L["Grow"],
  spiral = L["Spiral"],
  bounceDecay = L["Bounce"],
  starShakeDecay = L["Star Shake"],
};

Private.chat_message_types = {
  CHAT_MSG_BATTLEGROUND = L["Battleground"],
  CHAT_MSG_BG_SYSTEM_NEUTRAL = L["BG-System Neutral"],
  CHAT_MSG_BG_SYSTEM_ALLIANCE = L["BG-System Alliance"],
  CHAT_MSG_BG_SYSTEM_HORDE = L["BG-System Horde"],
  CHAT_MSG_BN_WHISPER = L["Battle.net Whisper"],
  CHAT_MSG_CHANNEL = L["Channel"],
  CHAT_MSG_EMOTE = L["Emote"],
  CHAT_MSG_GUILD = L["Guild"],
  CHAT_MSG_MONSTER_YELL = L["Monster Yell"],
  CHAT_MSG_MONSTER_EMOTE = L["Monster Emote"],
  CHAT_MSG_MONSTER_SAY = L["Monster Say"],
  CHAT_MSG_MONSTER_WHISPER = L["Monster Whisper"],
  CHAT_MSG_MONSTER_PARTY = L["Monster Party"],
  CHAT_MSG_OFFICER = L["Officer"],
  CHAT_MSG_PARTY = L["Party"],
  CHAT_MSG_RAID = L["Raid"],
  CHAT_MSG_RAID_BOSS_EMOTE = L["Boss Emote"],
  CHAT_MSG_RAID_BOSS_WHISPER = L["Boss Whisper"],
  CHAT_MSG_RAID_WARNING = L["Raid Warning"],
  CHAT_MSG_SAY = L["Say"],
  CHAT_MSG_WHISPER = L["Whisper"],
  CHAT_MSG_YELL = L["Yell"],
  CHAT_MSG_SYSTEM = L["System"]
}

Private.send_chat_message_types = {
  WHISPER = L["Whisper"],
  CHANNEL = L["Channel"],
  SAY = L["Say"],
  EMOTE = L["Emote"],
  YELL = L["Yell"],
  PARTY = L["Party"],
  GUILD = L["Guild"],
  OFFICER = L["Officer"],
  RAID = L["Raid"],
  SMARTRAID = L["BG>Raid>Party>Say"],
  RAID_WARNING = L["Raid Warning"],
  BATTLEGROUND = L["Battleground"],
  COMBAT = L["Blizzard Combat Text"],
  PRINT = L["Chat Frame"],
  ERROR = L["Error Frame"]
}

Private.group_aura_name_info_types = {
  aura = L["Aura Name"],
  players = L["Player(s) Affected"],
  nonplayers = L["Player(s) Not Affected"]
}

Private.group_aura_stack_info_types = {
  count = L["Number Affected"],
  stack = L["Aura Stack"]
}

Private.cast_types = {
  cast = L["Cast"],
  channel = L["Channel (Spell)"]
}

-- register sounds
LSM:Register("sound", "Batman Punch", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BatmanPunch.ogg")
LSM:Register("sound", "Bike Horn", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BikeHorn.ogg")
LSM:Register("sound", "Boxing Arena Gong", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BoxingArenaSound.ogg")
LSM:Register("sound", "Bleat", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Bleat.ogg")
LSM:Register("sound", "Cartoon Hop", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonHop.ogg")
LSM:Register("sound", "Cat Meow", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CatMeow2.ogg")
LSM:Register("sound", "Kitten Meow", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\KittenMeow.ogg")
LSM:Register("sound", "Robot Blip", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RobotBlip.ogg")
LSM:Register("sound", "Sharp Punch", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\SharpPunch.ogg")
LSM:Register("sound", "Water Drop", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\WaterDrop.ogg")
LSM:Register("sound", "Air Horn", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\AirHorn.ogg")
LSM:Register("sound", "Applause", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Applause.ogg")
LSM:Register("sound", "Banana Peel Slip", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\BananaPeelSlip.ogg")
LSM:Register("sound", "Blast", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Blast.ogg")
LSM:Register("sound", "Cartoon Voice Baritone", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonVoiceBaritone.ogg")
LSM:Register("sound", "Cartoon Walking", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CartoonWalking.ogg")
LSM:Register("sound", "Cow Mooing", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\CowMooing.ogg")
LSM:Register("sound", "Ringing Phone", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RingingPhone.ogg")
LSM:Register("sound", "Roaring Lion", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RoaringLion.ogg")
LSM:Register("sound", "Shotgun", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Shotgun.ogg")
LSM:Register("sound", "Squish Fart", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\SquishFart.ogg")
LSM:Register("sound", "Temple Bell", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\TempleBellHuge.ogg")
LSM:Register("sound", "Torch", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Torch.ogg")
LSM:Register("sound", "Warning Siren", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\WarningSiren.ogg")
LSM:Register("sound", "Lich King Apocalypse", "Sound\\Creature\\LichKing\\IC_Lich King_Special01.ogg")
-- Sounds from freesound.org, see commits for attributions
LSM:Register("sound", "Sheep Blerping", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\SheepBleat.ogg")
LSM:Register("sound", "Rooster Chicken Call", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RoosterChickenCalls.ogg")
LSM:Register("sound", "Goat Bleeting", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\GoatBleating.ogg")
LSM:Register("sound", "Acoustic Guitar", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\AcousticGuitar.ogg")
LSM:Register("sound", "Synth Chord", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\SynthChord.ogg")
LSM:Register("sound", "Chicken Alarm", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\ChickenAlarm.ogg")
LSM:Register("sound", "Xylophone", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Xylophone.ogg")
LSM:Register("sound", "Drums", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Drums.ogg")
LSM:Register("sound", "Tada Fanfare", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\TadaFanfare.ogg")
LSM:Register("sound", "Squeaky Toy Short", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\SqueakyToyShort.ogg")
LSM:Register("sound", "Error Beep", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\ErrorBeep.ogg")
LSM:Register("sound", "Oh No", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\OhNo.ogg")
LSM:Register("sound", "Double Whoosh", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\DoubleWhoosh.ogg")
LSM:Register("sound", "Brass", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Brass.mp3")
LSM:Register("sound", "Glass", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Glass.mp3")

LSM:Register("sound", "Voice: Adds", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Adds.ogg")
LSM:Register("sound", "Voice: Boss", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Boss.ogg")
LSM:Register("sound", "Voice: Circle", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Circle.ogg")
LSM:Register("sound", "Voice: Cross", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Cross.ogg")
LSM:Register("sound", "Voice: Diamond", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Diamond.ogg")
LSM:Register("sound", "Voice: Don't Release", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\DontRelease.ogg")
LSM:Register("sound", "Voice: Empowered", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Empowered.ogg")
LSM:Register("sound", "Voice: Focus", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Focus.ogg")
LSM:Register("sound", "Voice: Idiot", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Idiot.ogg")
LSM:Register("sound", "Voice: Left", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Left.ogg")
LSM:Register("sound", "Voice: Moon", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Moon.ogg")
LSM:Register("sound", "Voice: Next", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Next.ogg")
LSM:Register("sound", "Voice: Portal", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Portal.ogg")
LSM:Register("sound", "Voice: Protected", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Protected.ogg")
LSM:Register("sound", "Voice: Release", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Release.ogg")
LSM:Register("sound", "Voice: Right", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Right.ogg")
LSM:Register("sound", "Voice: Run Away", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\RunAway.ogg")
LSM:Register("sound", "Voice: Skull", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Skull.ogg")
LSM:Register("sound", "Voice: Spread", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Spread.ogg")
LSM:Register("sound", "Voice: Square", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Square.ogg")
LSM:Register("sound", "Voice: Stack", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Stack.ogg")
LSM:Register("sound", "Voice: Star", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Star.ogg")
LSM:Register("sound", "Voice: Switch", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Switch.ogg")
LSM:Register("sound", "Voice: Taunt", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Taunt.ogg")
LSM:Register("sound", "Voice: Triangle", "Interface\\AddOns\\WeakAuras\\Media\\Sounds\\Triangle.ogg")


local PowerAurasSoundPath = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Sounds\\"
LSM:Register("sound", "Aggro", PowerAurasSoundPath.."aggro.ogg")
LSM:Register("sound", "Arrow Swoosh", PowerAurasSoundPath.."Arrow_swoosh.ogg")
LSM:Register("sound", "Bam", PowerAurasSoundPath.."bam.ogg")
LSM:Register("sound", "Polar Bear", PowerAurasSoundPath.."bear_polar.ogg")
LSM:Register("sound", "Big Kiss", PowerAurasSoundPath.."bigkiss.ogg")
LSM:Register("sound", "Bite", PowerAurasSoundPath.."BITE.ogg")
LSM:Register("sound", "Burp", PowerAurasSoundPath.."burp4.ogg")
LSM:Register("sound", "Cat", PowerAurasSoundPath.."cat2.ogg")
LSM:Register("sound", "Chant Major 2nd", PowerAurasSoundPath.."chant2.ogg")
LSM:Register("sound", "Chant Minor 3rd", PowerAurasSoundPath.."chant4.ogg")
LSM:Register("sound", "Chimes", PowerAurasSoundPath.."chimes.ogg")
LSM:Register("sound", "Cookie Monster", PowerAurasSoundPath.."cookie.ogg")
LSM:Register("sound", "Electrical Spark", PowerAurasSoundPath.."ESPARK1.ogg")
LSM:Register("sound", "Fireball", PowerAurasSoundPath.."Fireball.ogg")
LSM:Register("sound", "Gasp", PowerAurasSoundPath.."Gasp.ogg")
LSM:Register("sound", "Heartbeat", PowerAurasSoundPath.."heartbeat.ogg")
LSM:Register("sound", "Hiccup", PowerAurasSoundPath.."hic3.ogg")
LSM:Register("sound", "Huh?", PowerAurasSoundPath.."huh_1.ogg")
LSM:Register("sound", "Hurricane", PowerAurasSoundPath.."hurricane.ogg")
LSM:Register("sound", "Hyena", PowerAurasSoundPath.."hyena.ogg")
LSM:Register("sound", "Kaching", PowerAurasSoundPath.."kaching.ogg")
LSM:Register("sound", "Moan", PowerAurasSoundPath.."moan.ogg")
LSM:Register("sound", "Panther", PowerAurasSoundPath.."panther1.ogg")
LSM:Register("sound", "Phone", PowerAurasSoundPath.."phone.ogg")
LSM:Register("sound", "Punch", PowerAurasSoundPath.."PUNCH.ogg")
LSM:Register("sound", "Rain", PowerAurasSoundPath.."rainroof.ogg")
LSM:Register("sound", "Rocket", PowerAurasSoundPath.."rocket.ogg")
LSM:Register("sound", "Ship's Whistle", PowerAurasSoundPath.."shipswhistle.ogg")
LSM:Register("sound", "Gunshot", PowerAurasSoundPath.."shot.ogg")
LSM:Register("sound", "Snake Attack", PowerAurasSoundPath.."snakeatt.ogg")
LSM:Register("sound", "Sneeze", PowerAurasSoundPath.."sneeze.ogg")
LSM:Register("sound", "Sonar", PowerAurasSoundPath.."sonar.ogg")
LSM:Register("sound", "Splash", PowerAurasSoundPath.."splash.ogg")
LSM:Register("sound", "Squeaky Toy", PowerAurasSoundPath.."Squeakypig.ogg")
LSM:Register("sound", "Sword Ring", PowerAurasSoundPath.."swordecho.ogg")
LSM:Register("sound", "Throwing Knife", PowerAurasSoundPath.."throwknife.ogg")
LSM:Register("sound", "Thunder", PowerAurasSoundPath.."thunder.ogg")
LSM:Register("sound", "Wicked Male Laugh", PowerAurasSoundPath.."wickedmalelaugh1.ogg")
LSM:Register("sound", "Wilhelm Scream", PowerAurasSoundPath.."wilhelm.ogg")
LSM:Register("sound", "Wicked Female Laugh", PowerAurasSoundPath.."wlaugh.ogg")
LSM:Register("sound", "Wolf Howl", PowerAurasSoundPath.."wolf5.ogg")
LSM:Register("sound", "Yeehaw", PowerAurasSoundPath.."yeehaw.ogg")

Private.sound_types = {
  [" custom"] = " " .. L["Custom"],
  [" KitID"] = " " .. L["Sound by Kit ID"]
}

for name, path in next, LSM:HashTable("sound") do
  Private.sound_types[path] = name
end

LSM.RegisterCallback(WeakAuras, "LibSharedMedia_Registered", function(_, mediatype, key)
  if mediatype == "sound" then
    local path = LSM:Fetch(mediatype, key)
    if path then
      Private.sound_types[path] = key
    end
  end
end)

-- register options font
LSM:Register("font", "Fira Mono Medium", "Interface\\Addons\\WeakAuras\\Media\\Fonts\\FiraMono-Medium.ttf", LSM.LOCALE_BIT_western + LSM.LOCALE_BIT_ruRU)

-- register plain white border
LSM:Register("border", "Square Full White", [[Interface\AddOns\WeakAuras\Media\Textures\Square_FullWhite.tga]])

--
LSM:Register("statusbar", "Clean", [[Interface\AddOns\WeakAuras\Media\Textures\Statusbar_Clean]])
LSM:Register("statusbar", "Stripes", [[Interface\AddOns\WeakAuras\Media\Textures\Statusbar_Stripes]])
LSM:Register("statusbar", "Thick Stripes", [[Interface\AddOns\WeakAuras\Media\Textures\Statusbar_Stripes_Thick]])
LSM:Register("statusbar", "Thin Stripes", [[Interface\AddOns\WeakAuras\Media\Textures\Statusbar_Stripes_Thin]])
LSM:Register("border", "Drop Shadow", [[Interface\AddOns\WeakAuras\Media\Textures\Border_DropShadow]])

Private.duration_types = {
  seconds = L["Seconds"],
  relative = L["Relative"]
}

Private.duration_types_no_choice = {
  seconds = L["Seconds"]
}

Private.gtfo_types = {
  [1] = L["High Damage"],
  [2] = L["Low Damage"],
  [3] = L["Fail Alert"],
  [4] = L["Friendly Fire"]
}

Private.pet_behavior_types = {
  aggressive = PET_MODE_AGGRESSIVE,
  passive = PET_MODE_PASSIVE,
  defensive = PET_MODE_DEFENSIVE
}

Private.cooldown_progress_behavior_types = {
  showOnCooldown = L["On Cooldown"],
  showOnReady = L["Not on Cooldown"],
  showAlways = L["Always"]
}

Private.cooldown_types = {
  auto = L["Auto"],
  charges = L["Charges"],
  cooldown = L["Cooldown"]
}

Private.bufftrigger_progress_behavior_types = {
  showOnActive = L["Buffed/Debuffed"],
  showOnMissing = L["Missing"],
  showAlways= L["Always"]
}

Private.bufftrigger_2_progress_behavior_types = {
  showOnActive = L["Aura(s) Found"],
  showOnMissing = L["Aura(s) Missing"],
  showAlways = L["Always"],
  showOnMatches = L["Match Count"]
}

Private.bufftrigger_2_preferred_match_types = {
  showLowest = L["Least remaining time"],
  showHighest = L["Most remaining time"]
}

Private.bufftrigger_2_per_unit_mode = {
  affected = L["Affected"],
  unaffected = L["Unaffected"],
  all = L["All"]
}

Private.item_slot_types = {
  [0] = AMMOSLOT,
  [1]  = HEADSLOT,
  [2]  = NECKSLOT,
  [3]  = SHOULDERSLOT,
  [5]  = CHESTSLOT,
  [6]  = WAISTSLOT,
  [7]  = LEGSSLOT,
  [8]  = FEETSLOT,
  [9]  = WRISTSLOT,
  [10] = HANDSSLOT,
  [11] = FINGER0SLOT_UNIQUE,
  [12] = FINGER1SLOT_UNIQUE,
  [13] = TRINKET0SLOT_UNIQUE,
  [14] = TRINKET1SLOT_UNIQUE,
  [15] = BACKSLOT,
  [16] = MAINHANDSLOT,
  [17] = SECONDARYHANDSLOT,
  [18] = RANGEDSLOT,
  [19] = TABARDSLOT
}

Private.charges_change_type = {
  GAINED = L["Gained"],
  LOST = L["Lost"],
  CHANGED = L["Changed"]
}

Private.charges_change_condition_type = {
  GAINED = L["Gained"],
  LOST = L["Lost"]
}

Private.combat_event_type = {
  PLAYER_REGEN_ENABLED = L["Leaving"],
  PLAYER_REGEN_DISABLED = L["Entering"]
}

Private.bool_types = {
  [0] = L["False"],
  [1] = L["True"]
}

Private.update_categories = {
  {
    name = "anchor",
    fields = {
      "xOffset",
      "yOffset",
      "selfPoint",
      "anchorPoint",
      "anchorFrameType",
      "anchorFrameFrame",
      "frameStrata",
      "height",
      "width",
      "fontSize",
      "scale",
    },
    default = false,
    label = L["Size & Position"],
  },
  {
    name = "userconfig",
    fields = {"config"},
    default = false,
    label = L["Custom Configuration"],
  },
  {
    name = "name",
    fields = {"id"},
    default = true,
    label = L["Aura Names"],
  },
  {
    name = "display",
    fields = {},
    default = true,
    label = L["Display"],
  },
  {
    name = "trigger",
    fields = {"triggers"},
    default = true,
    label = L["Trigger"],
  },
  {
    name = "conditions",
    fields = {"conditions"},
    default = true,
    label = L["Conditions"],
  },
  {
    name = "load",
    fields = {"load"},
    default = true,
    label = L["Load Conditions"],
  },
  {
    name = "action",
    fields = {"actions"},
    default = true,
    label = L["Actions"],
  },
  {
    name = "animation",
    fields = {"animation"},
    default = true,
    label = L["Animations"],
  },
  {
    name = "authoroptions",
    fields = {"authorOptions"},
    default = true,
    label = L["Author Options"]
  },
  {
    name = "arrangement",
    fields = {
      "grow",
      "space",
      "stagger",
      "sort",
      "hybridPosition",
      "radius",
      "align",
      "rotation",
      "constantFactor",
      "hybridSortMode",
    },
    default = true,
    label = L["Group Arrangement"],
  },
  {
    name = "oldchildren",
    fields = {},
    default = true,
    label = L["Remove Obsolete Auras"],
  },
  {
    name = "newchildren",
    fields = {},
    default = true,
    label = L["Add Missing Auras"],
  },
  {
    name = "metadata",
    fields = {
      "url",
      "desc",
      "version",
    },
    default = true,
    label = L["Meta Data"],
  },
}

-- fields that are handled as special cases when importing
-- mismatch of internal fields is not counted as a difference
Private.internal_fields = {
  uid = true,
  internalVersion = true,
  sortHybridTable = true,
}

-- fields that are not included in exported data
-- these represent information which is only meaningful inside the db,
-- or are represented in other ways in exported
Private.non_transmissable_fields = {
  controlledChildren = true,
  parent = true,
  authorMode = true,
  skipWagoUpdate = true,
  ignoreWagoUpdate = true,
  preferToUpdate = true,
}

WeakAuras.data_stub = {
  -- note: this is the minimal data stub which prevents false positives in diff upon reimporting an aura.
  -- pending a refactor of other code which adds unnecessary fields, it is possible to shrink it
  triggers = {
    {
      trigger = {
        type = "aura2",
        names = {},
        event = "Health",
        subeventPrefix = "SPELL",
        subeventSuffix = "_CAST_START",
        spellIds = {},
        unit = "player",
        debuffType = "HELPFUL",
      },
      untrigger = {},
    },
  },
  load = {
    size = {
      multi = {},
    },
    spec = {
      multi = {},
    },
    class = {
      multi = {},
    },
    talent = {
      multi = {},
    },
  },
  actions = {
    init = {},
    start = {},
    finish = {},
  },
  animation = {
    start = {
      type = "none",
      duration_type = "seconds",
      easeType = "none",
      easeStrength = 3,
    },
    main = {
      type = "none",
      duration_type = "seconds",
      easeType = "none",
      easeStrength = 3,
    },
    finish = {
      type = "none",
      duration_type = "seconds",
      easeType = "none",
      easeStrength = 3,
    },
  },
  conditions = {},
  config = {},
  authorOptions = {},
  information = {},
}

Private.author_option_classes = {
  toggle = "simple",
  input = "simple",
  number = "simple",
  range = "simple",
  color = "simple",
  select = "simple",
  multiselect = "simple",
  description = "noninteractive",
  space = "noninteractive",
  header = "noninteractive",
  group = "group"
}

Private.author_option_types = {
  toggle = L["Toggle"],
  input = L["String"],
  number = L["Number"],
  range = L["Slider"],
  description = L["Description"],
  color = L["Color"],
  select = L["Dropdown Menu"],
  space = L["Space"],
  multiselect = L["Toggle List"],
  header = L["Separator"],
  group = L["Option Group"],
}

Private.author_option_fields = {
  common = {
    type = true,
    name = true,
    useDesc = true,
    desc = true,
    key = true,
    width = true,
  },
  number = {
    min = 0,
    max = 1,
    step = .05,
    default = 0,
  },
  range = {
    min = 0,
    max = 1,
    step = .05,
    default = 0,
  },
  input = {
    default = "",
    useLength = false,
    length = 10,
    multiline = false,
  },
  toggle = {
    default = false,
  },
  description = {
    text = "",
    fontSize = "medium",
  },
  color = {
    default = {1, 1, 1, 1},
  },
  select = {
    values = {"val1"},
    default = 1,
  },
  space = {
    variableWidth = true,
    useHeight = false,
    height = 1,
  },
  multiselect = {
    default = {true},
    values = {"val1"},
  },
  header = {
    useName = false,
    text = "",
    noMerge = false
  },
  group = {
    groupType = "simple",
    useCollapse = true,
    collapse = false,
    limitType = "none",
    size = 10,
    nameSource = 0,
    hideReorder = true,
    entryNames = nil, -- handled as a special case in code
    subOptions = {},
  }
}

Private.array_entry_name_types = {
  [-1] = L["Fixed Names"],
  [0] = L["Entry Order"],
  -- the rest is auto-populated with indices which are valid entry name sources
}

Private.name_source_option_types = {
  -- option types which can be used to generate entry names on arrays
  input = true,
  number = true,
  range = true,
}

Private.group_limit_types = {
  none = L["Unlimited"],
  max = L["Limited"],
  fixed = L["Fixed Size"],
}

Private.group_option_types = {
  simple = L["Simple"],
  array = L["Array"],
}

Private.glow_types = {
  ACShine = L["Autocast Shine"],
  Pixel = L["Pixel Glow"],
  buttonOverlay = L["Action Button Glow"],
}

Private.font_sizes = {
  small = L["Small"],
  medium = L["Medium"],
  large = L["Large"],
}

-- unitIds registerable with RegisterUnitEvent
Private.baseUnitId = {
  ["player"] = true,
  ["target"] = true,
  ["pet"] = true,
  ["focus"] = true,
  ["vehicle"] = true
}

Private.multiUnitId = {
  ["boss"] = true,
  ["arena"] = true,
  ["group"] = true,
  ["party"] = true,
  ["raid"] = true,
}

Private.multiUnitUnits = {
  ["boss"] = {},
  ["arena"] = {},
  ["group"] = {},
  ["party"] = {},
  ["raid"] = {}
}

Private.multiUnitUnits.group["player"] = true
Private.multiUnitUnits.party["player"] = true

for i = 1, 4 do
  Private.baseUnitId["party"..i] = true
  Private.baseUnitId["partypet"..i] = true
  Private.multiUnitUnits.group["party"..i] = true
  Private.multiUnitUnits.party["party"..i] = true
end

for i = 1, MAX_BOSS_FRAMES do
  Private.baseUnitId["boss"..i] = true
  Private.multiUnitUnits.boss["boss"..i] = true
end

for i = 1, 5 do
  Private.baseUnitId["arena"..i] = true
  Private.multiUnitUnits.arena["arena"..i] = true
end

for i = 1, 40 do
  Private.baseUnitId["raid"..i] = true
  Private.baseUnitId["raidpet"..i] = true
  Private.multiUnitUnits.group["raid"..i] = true
  Private.multiUnitUnits.raid["raid"..i] = true
end

Private.dbm_types = {
  [1] = L["Add"],
  [2] = L["AOE"],
  [3] = L["Targeted"],
  [4] = L["Interrupt"],
  [5] = L["Role"],
  [6] = L["Phase"],
  [7] = L["Important"]
}

Private.weapon_enchant_types = {
  showOnActive = L["Enchant Found"],
  showOnMissing = L["Enchant Missing"],
  showAlways = L["Always"],
}
Private.reset_swing_spells = {
  [GetSpellInfo(1464)] = true, -- Slam
  [GetSpellInfo(78)] = true, -- Heroic Strike
  [GetSpellInfo(845)] = true, -- Cleave
  [GetSpellInfo(2973)] = true, -- Raptor Strike
  [GetSpellInfo(6807)] = true, -- Maul
  [GetSpellInfo(20549)] = true, -- War Stomp
  [GetSpellInfo(56815)] = true, -- Rune Strike
}
Private.reset_ranged_swing_spells = {
  [GetSpellInfo(2764)] = true, -- Throw
  [GetSpellInfo(5019)] = true, -- Shoot Wands
  [GetSpellInfo(75)] = true, -- Auto Shot
}

WeakAuras.StopMotion = {}
WeakAuras.StopMotion.texture_types = {
}

WeakAuras.StopMotion.texture_types.Basic = {
  ["Interface\\AddOns\\WeakAuras\\Media\\Textures\\StopMotion"] = "Example",
}

WeakAuras.StopMotion.texture_data = {
}

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAuras\\Media\\Textures\\StopMotion"] = {
  ["count"] = 64,
  ["rows"] = 8,
  ["columns"] = 8
}

  WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\circle"] = {
     ["count"] = 256,
     ["rows"] = 16,
     ["columns"] = 16
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\checkmark"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\redx"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\leftarc"] = {
     ["count"] = 256,
     ["rows"] = 16,
     ["columns"] = 16
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\rightarc"] = {
     ["count"] = 256,
     ["rows"] = 16,
     ["columns"] = 16
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Basic\\fireball"] = {
     ["count"] = 7,
     ["rows"] = 5,
     ["columns"] = 5
  }


WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\AURARUNE8"] = {
     ["count"] = 256,
     ["rows"] = 16,
     ["columns"] = 16
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionv"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionw"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionf"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Runes\\legionword"] = {
     ["count"] = 64,
     ["rows"] = 8,
     ["columns"] = 8
  }

WeakAuras.StopMotion.texture_types.Kaitan = {
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\CellRing"] = "CellRing",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Gadget"] = "Gadget",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Radar"] = "Radar",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\RadarComplex"] = "RadarComplex",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Saber"] = "Saber",
    ["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Waveform"] = "Waveform",
}

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\CellRing"] = {
      ["count"] = 32,
      ["rows"] = 8,
      ["columns"] = 4
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Gadget"] = {
     ["count"] = 32,
     ["rows"] = 8,
     ["columns"] = 4
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Radar"] = {
     ["count"] = 32,
     ["rows"] = 8,
     ["columns"] = 4
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\RadarComplex"] = {
     ["count"] = 32,
     ["rows"] = 8,
     ["columns"] = 4
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Saber"] = {
     ["count"] = 32,
     ["rows"] = 8,
     ["columns"] = 4
  }

WeakAuras.StopMotion.texture_data["Interface\\AddOns\\WeakAurasStopMotion\\Textures\\Kaitan\\Waveform"] = {
     ["count"] = 32,
     ["rows"] = 8,
     ["columns"] = 4
  }


WeakAuras.StopMotion.animation_types = {
  loop = L["Loop"],
  bounce = L["Forward, Reverse Loop"],
  once = L["Forward"],
  progress = L["Progress"]
}

Private.talent_types_specific = {}
Private.talents_ids = {
  DEATHKNIGHT = {{48979,48997,49182,48978,49004,55107,48982,48987,49467,48985,49145,49015,48977,49006,49005,48988,53137,49027,49016,50365,62905,49018,55233,49189,55050,49023,61154,49028}, {49175,49455,49042,55061,49140,49226,50880,49039,51468,51123,49149,49137,49186,49471,49796,55610,49024,49188,50040,49203,50384,65661,54639,51271,49200,49143,50187,49202,49184}, {51745,48962,55129,49036,48963,49588,48965,49013,51459,49158,49146,49219,55620,49194,49220,49223,55666,49224,49208,52143,66799,51052,50391,63560,49032,49222,49217,51099,55090,50117,49206}},
  DRUID = {{16814,57810,16845,35363,16821,16836,16880,57865,16819,16909,16850,33589,5570,57849,33597,16896,33592,24858,48384,33600,48389,33603,48516,50516,33831,48488,48506,48505}, {16934,16858,16947,16998,16929,17002,61336,16942,16966,16972,37116,48409,16940,49377,33872,57878,17003,33853,17007,34297,33851,57873,33859,48483,48492,33917,48532,48432,63503,50334}, {17050,17063,17056,17069,17118,16833,17106,16864,48411,24968,17111,17116,17104,17123,33879,17074,34151,18562,33881,33886,48496,48539,65139,48535,63410,51179,48438}},
  HUNTER = {{19552,19583,35029,19549,19609,24443,19559,53265,19616,19572,19598,19578,19577,19590,34453,19621,34455,19574,34462,53252,34466,53262,34692,53256,56314,53270}, {19407,53620,19426,34482,19421,19485,34950,19454,19434,34948,19464,19416,35100,23989,19461,34475,19507,53234,19506,35104,34485,53228,53215,34490,53221,53241,53209}, {52783,19498,19159,19290,19184,19376,34494,19255,19503,19295,19286,56333,56342,56339,19370,19306,19168,34491,34500,19386,34497,34506,53295,53298,3674,53302,53290,53301}},
  MAGE = {{11210,11222,11237,28574,29441,11213,11247,11242,44397,54646,11252,11255,18462,29447,31569,12043,11232,31574,15058,31571,31579,12042,44394,44378,31584,31589,44404,44400,35578,44425}, {11078,18459,11069,11119,54747,11108,11100,11103,11366,11083,11095,11094,29074,31638,11115,11113,31641,11124,34293,11129,31679,64353,31656,44442,31661,44445,44449,44457}, {11071,11070,31670,11207,11189,29438,11175,11151,12472,11185,16757,11160,11170,11958,11190,31667,55091,11180,44745,11426,31674,31682,44543,44546,31687,44557,44566,44572}},
  PALADIN = {{20205,20224,20237,20257,9453,31821,20210,20234,20254,20244,53660,31822,20216,20359,31825,5923,31833,20473,31828,53551,31837,31842,53671,53569,53556,53563}, {63646,20262,31844,20174,20096,64205,20468,20143,53527,20487,20138,20911,20177,31848,20196,31785,20925,31850,20127,31858,53590,31935,53583,53709,53695,53595}, {20060,20101,25956,20335,20042,9452,20117,20375,26022,9799,32043,31866,20111,31869,20049,31871,53486,20066,31876,31879,53375,53379,35395,53501,53380,53385}},
  PRIEST = {{14522,47586,14523,14747,14749,14531,14521,14751,14748,33167,14520,14750,33201,18551,63574,33186,34908,45234,10060,63504,57470,47535,47507,47509,33206,47516,52795,47540}, {14913,14908,14889,27900,18530,19236,27811,14892,27789,14912,14909,14911,20711,14901,33150,14898,34753,724,33142,64127,33158,63730,63534,34861,47558,47562,47788}, {15270,15337,15259,15318,15275,15260,15392,15273,15407,15274,17322,15257,15487,15286,27839,33213,14910,63625,15473,33221,47569,33191,64044,34914,47580,47573,47585}},
  ROGUE = {{14162,14144,14138,14156,51632,13733,14983,14168,14128,16513,14113,31208,14177,14174,31244,14186,14158,51625,58426,31380,51634,31234,31226,1329,51627,51664,51662}, {13741,13732,13715,14165,13713,13705,13742,14251,13706,13754,13743,13712,18427,13709,13877,13960,30919,31124,31122,13750,31130,5952,35541,51672,32601,51682,51685,51690}, {14179,13958,14057,30892,14076,13975,13981,14278,14171,13983,13976,14079,30894,14185,14082,16511,31221,30902,31211,14183,31228,31216,51692,51698,36554,58414,51708,51713}},
  SHAMAN = {{16039,16035,16038,28996,30160,16040,16164,16089,16086,29062,28999,16041,30664,30672,16578,16166,51483,63370,51466,30675,51474,30706,51480,62097,51490}, {16259,16043,17485,16258,16255,16262,16261,16266,43338,16254,16256,16252,29192,16268,51883,30802,29082,63373,30816,30798,17364,51525,60103,51521,30812,30823,51523,51528,51533}, {16182,16173,16184,29187,16179,16180,16181,55198,16176,16187,16194,29206,16188,30864,16178,30881,16190,51886,51554,30872,30867,51556,974,51560,51562,61295}},
  WARLOCK = {{18827,18174,17810,18179,18213,18182,17804,53754,17783,18288,18218,18094,32381,32385,63108,18223,54037,18271,47195,30060,18220,30054,32477,47198,30108,58435,47201,48181}, {18692,18694,18697,47230,18703,18705,18731,18754,19028,18708,30143,18769,18709,30326,18767,23785,47245,30319,47193,35691,30242,63156,54347,30146,63117,47236,59672}, {17793,17788,18119,63349,17778,18126,17877,17959,18135,17917,17927,34935,17815,18130,30299,17954,17962,30293,18096,30288,54117,47258,30283,47220,47266,50796}},
  WARRIOR = {{12282,16462,12286,12285,12300,12295,12290,12296,16493,12834,12163,56636,12700,12328,12284,12281,20504,12289,46854,29834,12294,46865,12862,64976,35446,46859,29723,29623,29836,46867,46924}, {61216,12321,12320,12324,12322,12329,12323,16487,12318,23584,20502,12317,29590,12292,29888,20500,12319,46908,23881,29721,46910,29759,60970,29801,46913,56927,46917}, {12301,12298,12287,50685,12297,12975,12797,29598,12299,59088,12313,12308,12312,12809,12311,16538,29593,50720,29787,29140,46945,57499,20243,47294,46951,58872,46968}}
}
