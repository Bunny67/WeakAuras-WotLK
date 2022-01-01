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
  [SPELL_POWER_MANA] = MANA,
  [SPELL_POWER_RAGE] = RAGE,
  [SPELL_POWER_FOCUS] = FOCUS,
  [SPELL_POWER_ENERGY] = ENERGY,
  [SPELL_POWER_RUNIC_POWER] = RUNIC_POWER,
  [SPELL_POWER_SOUL_SHARDS] = SOUL_SHARDS,
  [SPELL_POWER_ECLIPSE] = ECLIPSE,
  [SPELL_POWER_HOLY_POWER] = HOLY_POWER,
}

Private.role_types = {
  TANK = INLINE_TANK_ICON.." "..TANK,
  DAMAGER = INLINE_DAMAGER_ICON.." "..DAMAGER,
  HEALER = INLINE_HEALER_ICON.." "..HEALER
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


Private.class_ids = {
  ["WARRIOR"] = 1,
  ["PALADIN"] = 2,
  ["HUNTER"] = 3,
  ["ROGUE"] = 4,
  ["PRIEST"] = 5,
  ["DEATHKNIGHT"] = 6,
  ["SHAMAN"] = 7,
  ["MAGE"] = 8,
  ["WARLOCK"]= 9,
  ["DRUID"] = 11,
}

Private.spec_ids = {
	["MAGE"] = {62, 63, 64},
	["PRIEST"] = {256, 257, 258},
	["ROGUE"] = {259, 260, 261},
	["WARLOCK"] = {265, 266, 267},
	["WARRIOR"] = {71, 72, 73},
	["PALADIN"] = {65, 66, 70},
	["DEATHKNIGHT"] = {250, 251, 252},
	["DRUID"] = {102, 103, 105},
	["HUNTER"] = {253, 254, 255},
	["SHAMAN"] = {262, 263, 264},
}

Private.spec_info = {
	--MAGE
		--arcane
		[62]	= {
			[1]=62,
			[2]="Arcane",
			[3]=[[Manipulates raw Arcane magic, destroying enemies with overwhelming power.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_holy_magicalsentry]],
			[5]="DAMAGER",
			[6]="MAGE",
			[7]="Mage"
		},
		--fire
		[63] = {
			[1]=63,
			[2]="Fire",
			[3]=[[Focuses the pure essence of Fire magic, assaulting enemies with combustive flames.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_fire_firebolt02]],
			[5]="DAMAGER",
			[6]="MAGE",
			[7]="Mage"
		},
		--frost
		[64] = {
			[1]=64,
			[2]="Frost",
			[3]=[[Freezes enemies in their tracks and shatters them with Frost magic.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_frost_frostbolt02]],
			[5]="DAMAGER",
			[6]="MAGE",
			[7]="Mage"
		},

	--PRIEST
		--discipline
		[256] = {
			[1]=256,
			[2]="Discipline",
			[3]=[[Uses magic to shield allies from taking damage as well as heal their wounds.
			
			Preferred Weapon: Staff, Wand, Dagger, Mace]],
			[4]=[[Interface\ICONS\spell_holy_powerwordshield]],
			[5]="HEALER",
			[6]="PRIEST",
			[7]="Priest"
		},
		--holy
		[257] = {
			[1]=257,
			[2]="Holy",
			[3]=[[A versatile healer who can reverse damage on individuals or groups and even heal from beyond the grave.
			
			Preferred Weapon: Staff, Wand, Dagger, Mace]],
			[4]=[[Interface\ICONS\spell_holy_guardianspirit]],
			[5]="HEALER",
			[6]="PRIEST",
			[7]="Priest"
		},
		--shadow priest
		[258] = {
			[1]=258,
			[2]="Shadow",
			[3]=[[Uses sinister Shadow magic and terrifying Void magic to eradicate enemies.
			
			Preferred Weapon: Staff, Wand, Dagger, Mace]],
			[4]=[[Interface\ICONS\spell_shadow_shadowwordpain]],
			[5]="DAMAGER",
			[6]="PRIEST",
			[7]="Priest"
		},

	--ROGUE
		--assassination
		[259] = {
			[1]=259,
			[2]="Assassination",
			[3]=[[A deadly master of poisons who dispatches victims with vicious dagger strikes.
			
			Preferred Weapons: Daggers]],
			[4]=[[Interface\ICONS\ability_rogue_eviscerate]],
			[5]="DAMAGER",
			[6]="ROGUE",
			[7]="Rogue"
		},
		--combat
		[260] = {
			[1]=260,
			[2]="Combat",
			[3]=[[A swashbuckler who uses agility and guile to stand toe-to-toe with enemies.
			
			Preferred Weapons: Daggers]],
			[4]=[[Interface\ICONS\ability_backstab]],
			[5]="DAMAGER",
			[6]="ROGUE",
			[7]="Rogue"
		},
		--subtlety
		[261] = {
			[1]=261,
			[2]="Subtlety",
			[3]=[[A dark stalker who leaps from the shadows to ambush his unsuspecting prey.
			
			Preferred Weapons: Daggers]],
			[4]=[[Interface\ICONS\ability_stealth]],
			[5]="DAMAGER",
			[6]="ROGUE",
			[7]="Rogue"
		},

	--WARLOCK
		--affliction
		[265] = {
			[1]=265,
			[2]="Affliction",
			[3]=[[A master of shadow magic who specializes in drains and damage-over-time spells.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_shadow_deathcoil]],
			[5]="DAMAGER",
			[6]="WARLOCK",
			[7]="Warlock"
		},
		--demo
		[266] = {
			[1]=266,
			[2]="Demonology",
			[3]=[[A commander of demons who twists the souls of his army into devastating power.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_shadow_metamorphosis]],
			[5]="DAMAGER",
			[6]="WARLOCK",
			[7]="Warlock"
		},
		--destro
		[267] = {
			[1]=267,
			[2]="Destruction",
			[3]=[[A master of chaos who calls down fire to burn and demolish enemies.
			
			Preferred Weapon: Staff, Wand, Dagger, Sword]],
			[4]=[[Interface\ICONS\spell_shadow_rainoffire]],
			[5]="DAMAGER",
			[6]="WARLOCK",
			[7]="Warlock"
		},

	--WARRIOR
		--Arms
		[71] = {
			[1]=71,
			[2]="Arms",
			[3]=[[A battle-hardened master of weapons, using mobility and overpowering attacks to strike his opponents down.
			
			Preferred Weapon: Two-Handed Axe, Mace, Sword]],
			[4]=[[Interface\ICONS\ability_warrior_savageblow]],
			[5]="DAMAGER",
			[6]="WARRIOR",
			[7]="Warrior"
		},
		--Fury
		[72] = {
			[1]=72,
			[2]="Fury",
			[3]=[[A furious berserker unleashing a flurry of attacks to carve his opponents to pieces.
			
			Preferred Weapons: Dual Axes, Maces, Swords]],
			[4]=[[Interface\ICONS\ability_warrior_innerrage]],
			[5]="DAMAGER",
			[6]="WARRIOR",
			[7]="Warrior"
		},
		--Protection
		[73] = {
			[1]=73,
			[2]="Protection",
			[3]=[[A stalwart protector who uses a shield to safeguard himself and his allies.
			
			Preferred Weapon: Axe, Mace, Sword, and Shield]],
			[4]=[[Interface\ICONS\ability_warrior_defensivestance]],
			[5]="TANK",
			[6]="WARRIOR",
			[7]="Warrior"
		},

	--PALADIN
		--holy
		[65] = {
			[1]=65,
			[2]="Holy",
			[3]=[[Invokes the power of the Light to heal and protect allies and vanquish evil from the darkest corners of the world.\r\
			
			Preferred Weapon: Sword, Mace, and Shield]],
			[4]=[[Interface\ICONS\spell_holy_holybolt]],
			[5]="HEALER",
			[6]="PALADIN",
			[7]="Paladin"
		},

		--protection
		[66] = {
			[1]=66,
			[2]="Protection",
			[3]=[[Uses Holy magic to shield himself and defend allies from attackers.
			
			Preferred Weapon: Sword, Mace, Axe, and Shield]],
			[4]=[[Interface\ICONS\ability_paladin_shieldofthetemplar]],
			[5]="TANK",
			[6]="PALADIN",
			[7]="Paladin"
		},

		--retribution
		[70] = {
			[1]=70,
			[2]="Retribution",
			[3]=[[A righteous crusader who judges and punishes opponents with weapons and Holy magic.
			
			Preferred Weapon: Two-Handed Sword, Mace, Axe]],
			[4]=[[Interface\ICONS\spell_holy_auraoflight]],
			[5]="DAMAGER",
			[6]="PALADIN",
			[7]="Paladin"
		},

	--DEATH KNIGHT
		--unholy
		[252] = {
			[1]=252,
			[2]="Unholy",
			[3]=[[A master of death and decay, spreading infection and controlling undead minions to do his bidding.
			
			Preferred Weapon: Two-Handed Axe, Mace, Sword]],
			[4]=[[Interface\ICONS\Spell_Deathknight_UnholyPresence]],
			[5]="DAMAGER",
			[6]="DEATHKNIGHT",
			[7]="Death Knight"
		},
		--frost
		[251] = {
			[1]=251,
			[2]="Frost",
			[3]=[[An icy harbinger of doom, channeling runic power and delivering vicious weapon strikes.
			
			Preferred Weapons: Dual Axes, Maces, Swords]],
			[4]=[[Interface\ICONS\Spell_Deathknight_FrostPresence]],
			[5]="DAMAGER",
			[6]="DEATHKNIGHT",
			[7]="Death Knight"
		},
		--blood
		[250] = {
			[1]=250,
			[2]="Blood",
			[3]=[[A dark guardian who manipulates and corrupts life energy to sustain himself in the face of an enemy onslaught.
			
			Preferred Weapon: Two-Handed Axe, Mace, Sword]],
			[4]=[[Interface\ICONS\Spell_Deathknight_BloodPresence]],
			[5]="TANK",
			[6]="DEATHKNIGHT",
			[7]="Death Knight"
		},

	--DRUID
		--balance
		[102] = {
			[1]=102,
			[2]="Balance",
			[3]=[[Can shapeshift into a powerful Moonkin, balancing the power of Arcane and Nature magic to destroy enemies.
			
			Preferred Weapon: Staff, Dagger, Mace]],
			[4]=[[Interface\ICONS\spell_nature_starfall]],
			[5]="DAMAGER",
			[6]="DRUID",
			[7]="Druid"
		},
		--feral
		[103] = {
			[1]=103,
			[2]="Feral",
			[3]=[[Takes on the form of a great cat to deal damage with bleeds and bites.
			
			Preferred Weapon: Staff, Polearm]],
			[4]=[[Interface\Icons\Ability_Racial_BearForm]],
			[5]="DAMAGER",
			[6]="DRUID",
			[7]="Druid"
		},
		--restoration
		[105] = {
			[1]=105,
			[2]="Restoration",
			[3]=[[Channels powerful Nature magic to regenerate and revitalize allies.
			
			Preferred Weapon: Staff, Dagger, Mace]],
			[4]=[[Interface\ICONS\spell_nature_healingtouch]],
			[5]="HEALER",
			[6]="DRUID",
			[7]="Druid"
		},

	--HUNTER
		--beast mastery
		[253] = {
			[1]=253,
			[2]="Beast Mastery",
			[3]=[[A master of the wild who can tame a wide variety of beasts to assist him in combat.
			
			Preferred Weapon: Bow, Crossbow, Gun]],
			[4]=[[Interface\ICONS\ability_hunter_bestialdiscipline]],
			[5]="DAMAGER",
			[6]="HUNTER",
			[7]="Hunter"
		},
		--marksmanship
		[254] = {
			[1]=254,
			[2]="Marksmanship",
			[3]=[[A master sharpshooter who excels in bringing down enemies from afar.
			
			Preferred Weapon: Bow, Crossbow, Gun]],
			[4]=[[Interface\ICONS\ability_hunter_focusedaim]],
			[5]="DAMAGER",
			[6]="HUNTER",
			[7]="Hunter"
		},
		--survival
		[255] = {
			[1]=255,
			[2]="Survival",
			[3]=[[An adaptive ranger who favors using explosives, animal venom, and coordinated attacks with their bonded beast.
			
			Preferred Weapon: Polearm, Staff]],
			[4]=[[Interface\ICONS\ability_hunter_camouflage]],
			[5]="DAMAGER",
			[6]="HUNTER",
			[7]="Hunter"
		},

	--SHAMAN
		--elemental
		[262] = {
			[1]=262,
			[2]="Elemental",
			[3]=[[A spellcaster who harnesses the destructive forces of nature and the elements.
			
			Preferred Weapon: Mace, Dagger, and Shield]],
			[4]=[[Interface\ICONS\spell_nature_lightning]],
			[5]="DAMAGER",
			[6]="SHAMAN",
			[7]="Shaman"
		},
		--enhancement
		[263] = {
			[1]=263,
			[2]="Enhancement",
			[3]=[[A totemic warrior who strikes foes with weapons imbued with elemental power.
			
			Preferred Weapons: Dual Axes, Maces, Fist Weapons]],
			[4]=[[Interface\ICONS\spell_nature_lightningshield]],
			[5]="DAMAGER",
			[6]="SHAMAN",
			[7]="Shaman"
		},
		--restoration
		[264] = {
			[1]=264,
			[2]="Restoration",
			[3]=[[A healer who calls upon ancestral spirits and the cleansing power of water to mend allies' wounds.
			
			Preferred Weapon: Mace, Dagger, and Shield]],
			[4]=[[Interface\ICONS\spell_nature_magicimmunity]],
			[5]="HEALER",
			[6]="SHAMAN",
			[7]="Shaman"
		},
}

Private.GetSpecializationInfoByID = function(specId, ...)
	return unpack(Private.spec_info[specId] or {})
end

Private.GetClassNameByID = function(classID)
  for className, v in pairs(Private.class_ids) do
    if v == classID then
      return className
    end
  end
end

Private.GetSpecializationInfoForClass = function(className, tabIndex)
  local specId = Private.spec_ids[className][tabIndex]
  return Private.GetSpecializationInfoByID(specId)
end

Private.GetSpecializationInfoForClassID = function(classID, tabIndex)
  local className = Private.GetClassNameByID(classID)
  return Private.GetSpecializationInfoForClass(className, tabIndex)
end

WeakAuras.spec_types_specific = {}
for classFileName, classID in pairs(Private.class_ids) do
  WeakAuras.spec_types_specific[classFileName] = {}
  for i=1, 3 do
    local specId, tabName, _, icon = Private.GetSpecializationInfoForClassID(classID, i);
    if tabName then
      tinsert(WeakAuras.spec_types_specific[classFileName], "|T"..(icon or "error")..":0|t "..(tabName or "error"));
    end
  end
end

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
  DEATHKNIGHT = {{48979,49182,48978,94553,49004,81131,85793,49219,49222,49042,53137,81125,49027,50365,52284,48982,55233,62905,81135,49028}, {49455,55061,49226,51468,49039,51983,49137,49024,49149,51123,49188,51271,55610,81327,50040,49203,50384,65661,81330,49184}, {49588,48962,49036,55666,81338,48963,51459,49016,91316,48965,96269,49224,51745,49194,51052,50391,63560,51099,49018,49206}},
  DRUID = {{16880,16814,35363,57810,16845,33592,81061,24858,50516,93398,48389,48488,78675,33597,33831,93401,48506,78788,33603,48505}, {17002,17056,16972,48483,48532,37116,16858,48492,49377,78892,16929,17007,16940,33872,80316,61336,80314,57878,80318,48432,80313,50334}, {78784,16833,17069,17003,78734,48411,17111,48496,48539,17116,17104,17074,33879,92363,34151,48438,88423,33881,51179,33886,33891}},
  HUNTER = {{35029,82682,19590,19559,19578,19621,19572,53256,82726,82692,53262,82748,82898,19574,34460,56314,34692,53252,53270}, {34950,19416,34948,83340,53221,34482,34490,35100,53234,35104,19506,83489,82893,53228,34485,23989,83558,53241,53209}, {56339,52783,19464,19286,19376,19184,53298,34497,19306,56342,34491,83494,56333,82832,19386,53295,53290,53302,87934,3674}},
  MAGE = {{11213,11255,44400,29447,84722,83513,31569,44378,12043,44404,31574,11210,82930,44394,90787,31571,31589,86181,54646,31584,12042}, {29074,11083,11078,11119,18459,31641,11103,86948,11113,44445,11115,11094,11129,44446,86914,84673,31661,31679,34293,11095,44457}, {83049,11151,11170,31670,11190,83156,11175,11185,12472,44543,86259,44561,11958,44546,44745,11426,86303,84726,44572}},
  PALADIN = {{20359,20138,53671,85462,20234,20237,31825,31842,53569,88820,53556,53563,85495,53551,20049,31821,93418,84800,31828,85222}, {63646,20224,87163,53695,20143,20487,84631,20911,53595,84635,20177,53600,75806,26016,20925,85639,70940,53709,31848,31850}, {9799,31866,87174,20174,85457,26022,31876,53486,87168,53385,85285,25956,85126,53375,85803,20066,85117,53380,85446,85696}},
  PRIEST = {{14748,47586,14520,81659,87151,14747,63574,57470,10060,14523,89485,47535,52795,33201,89488,47509,33206,92295,45234,47516,62618}, {14908,33158,18530,19236,88687,14892,63534,34753,724,14898,95649,20711,63730,64127,14751,88627,33142,47558,87430,34861,47788}, {15259,15275,15274,15392,15273,63625,47573,15473,47569,33191,15487,15286,88994,14910,47580,34914,87192,64044,87099,78202,47585}},
  ROGUE = {{79121,14162,14128,14156,31208,13733,79123,51625,14177,16513,31380,14186,14158,58426,58410,14168,51664,79133,79140}, {79007,13732,13705,14165,13743,18427,13754,13712,84617,79077,13741,35541,31124,5952,13750,51682,84652,79095,51690}, {13975,14079,14179,13981,51692,14057,13976,79150,51632,16511,51698,14183,31211,31228,14185,79146,51708,14171,51713}},
  SHAMAN = {{17485,16039,16035,16038,28996,16040,30672,88756,16164,28999,51466,51480,88766,16166,51483,77746,86183,77755,61882}, {16266,77536,16261,30160,16256,16262,86935,16252,17364,51525,63373,16086,77655,51523,30823,30802,51528,77700,51533}, {77829,16179,84846,16180,16173,77794,30881,16176,16188,30867,16187,77130,86959,51556,16190,82984,98008,51562,51554,61295}},
  WARLOCK = {{18827,18182,17810,18179,17804,63108,18223,53754,47195,30054,86121,32385,47198,18094,86664,47201,85099,48181}, {18697,18694,47230,88446,30326,30143,18709,85106,47193,18703,47245,71521,89604,85109,85105,63156,85103,47236,59672}, {17788,17793,17815,85113,17954,17927,18119,47258,17877,91986,30293,34935,91713,47266,30283,30299,47220,80240,50796}},
  WARRIOR = {{84570,84579,80976,12295,29834,12834,12290,56636,12328,16493,12289,86655,85730,29836,84583,64976,29723,46867,85388,46924}, {16487,12322,12320,20502,12321,61216,12323,12319,12292,12317,81913,85288,29801,60970,46910,12329,46908,46913,29888,46917,81099}, {50685,12299,84614,12298,29598,84604,12311,12975,12809,29593,57499,12797,20243,80128,80979,50720,86894,46945,46951,46968}}
}
