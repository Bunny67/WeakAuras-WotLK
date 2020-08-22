if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

-- Lua APIs
local tinsert, tsort = table.insert, table.sort
local tostring = tostring
local select, pairs, type = select, pairs, type
local ceil, min = ceil, min

-- WoW APIs
local GetTalentInfo = GetTalentInfo
local UnitClass, UnitHealth, UnitHealthMax, UnitName, UnitPower, UnitPowerMax = UnitClass, UnitHealth, UnitHealthMax, UnitName, UnitPower, UnitPowerMax
local GetSpellInfo, GetItemInfo, GetItemCount, GetItemIcon = GetSpellInfo, GetItemInfo, GetItemCount, GetItemIcon
local GetShapeshiftFormInfo, GetShapeshiftForm = GetShapeshiftFormInfo, GetShapeshiftForm
local GetRuneCooldown, UnitCastingInfo, UnitChannelInfo = GetRuneCooldown, UnitCastingInfo, UnitChannelInfo
local UnitDetailedThreatSituation, UnitThreatSituation = UnitDetailedThreatSituation, UnitThreatSituation

local WeakAuras = WeakAuras
local L = WeakAuras.L

local SpellRange = LibStub("SpellRange-1.0")
function WeakAuras.IsSpellInRange(spellId, unit)
  return SpellRange.IsSpellInRange(spellId, unit)
end

local LibRangeCheck = LibStub("LibRangeCheck-2.0")

function WeakAuras.GetRange(unit, checkVisible)
  return LibRangeCheck:GetRange(unit, checkVisible);
end

function WeakAuras.CheckRange(unit, range, operator)
  local min, max = LibRangeCheck:GetRange(unit, true);
  if (type(range) ~= "number") then
    range = tonumber(range);
  end
  if (not range) then
    return
  end
  if (operator == "<=") then
    return (max or 999) <= range;
  else
    return (min or 0) >= range;
  end
end

local RangeCacheStrings = {friend = "", harm = "", misc = ""}
local function RangeCacheUpdate()
  local friend, harm, misc = {}, {}, {}
  local friendString, harmString, miscString

  for range in LibRangeCheck:GetFriendCheckers() do
    tinsert(friend, range)
  end
  tsort(friend)
  for range in LibRangeCheck:GetHarmCheckers() do
    tinsert(harm, range)
  end
  tsort(harm)
  for range in LibRangeCheck:GetMiscCheckers() do
    tinsert(misc, range)
  end
  tsort(misc)

  for _, key in pairs(friend) do
    friendString = (friendString and (friendString .. ", ") or "") .. key
  end
  for _, key in pairs(harm) do
    harmString = (harmString and (harmString .. ", ") or "") .. key
  end
  for _, key in pairs(misc) do
      miscString = (miscString and (miscString .. ", ") or "") .. key
  end
  RangeCacheStrings.friend, RangeCacheStrings.harm, RangeCacheStrings.misc = friendString, harmString, miscString
end

LibRangeCheck:RegisterCallback(LibRangeCheck.CHECKERS_CHANGED, RangeCacheUpdate)

function WeakAuras.UnitDetailedThreatSituation(unit1, unit2)
  local ok, aggro, status, threatpct, rawthreatpct, threatvalue = pcall(UnitDetailedThreatSituation, unit1, unit2)
  if ok then
    return aggro, status, threatpct, rawthreatpct, threatvalue
  end
end

local constants = {
  nameRealmFilterDesc = L[" Filter formats: 'Name', 'Name-Realm', '-Realm'. \n\nSupports multiple entries, separated by commas\n"],
}

WeakAuras.function_strings = {
  count = [[
    return function(count)
      if(count %s %s) then
        return true
      else
        return false
      end
    end
  ]],
  count_fraction = [[
    return function(count, max)
      local fraction = count/max
      if(fraction %s %s) then
        return true
      else
        return false
      end
    end
  ]],
  always = [[
    return function()
      return true
    end
  ]]
};

local hsvFrame = CreateFrame("Colorselect")

-- HSV transition, for a much prettier color transition in many cases
-- see http://www.wowinterface.com/forums/showthread.php?t=48236
function WeakAuras.GetHSVTransition(perc, r1, g1, b1, a1, r2, g2, b2, a2)
  --get hsv color for colorA
  hsvFrame:SetColorRGB(r1, g1, b1)
  local h1, s1, v1 = hsvFrame:GetColorHSV() -- hue, saturation, value
  --get hsv color for colorB
  hsvFrame:SetColorRGB(r2, g2, b2)
  local h2, s2, v2 = hsvFrame:GetColorHSV() -- hue, saturation, value
  local h3 = floor(h1 - (h1 - h2) * perc)
  -- find the shortest arc through the color circle, then interpolate
  local diff = h2 - h1
  if diff < -180 then
    diff = diff + 360
  elseif diff > 180 then
    diff = diff - 360
  end

  h3 = (h1 + perc * diff) % 360
  local s3 = s1 - ( s1 - s2 ) * perc
  local v3 = v1 - ( v1 - v2 ) * perc
  --get the RGB values of the new color
  hsvFrame:SetColorHSV(h3, s3, v3)
  local r, g, b = hsvFrame:GetColorRGB()
  --interpolate alpha
  local a = a1 - ( a1 - a2 ) * perc
  --return the new color
  return r, g, b, a
end


WeakAuras.anim_function_strings = {
  straight = [[
    function(progress, start, delta)
      return start + (progress * delta)
    end
  ]],
  straightTranslate = [[
    function(progress, startX, startY, deltaX, deltaY)
      return startX + (progress * deltaX), startY + (progress * deltaY)
    end
  ]],
  straightScale = [[
    function(progress, startX, startY, scaleX, scaleY)
      return startX + (progress * (scaleX - startX)), startY + (progress * (scaleY - startY))
    end
  ]],
  straightColor = [[
    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
      return r1 + (progress * (r2 - r1)), g1 + (progress * (g2 - g1)), b1 + (progress * (b2 - b1)), a1 + (progress * (a2 - a1))
    end
  ]],
  straightHSV = [[
    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
      return WeakAuras.GetHSVTransition(progress, r1, g1, b1, a1, r2, g2, b2, a2)
    end
  ]],
  circle = [[
    function(progress, startX, startY, deltaX, deltaY)
      local angle = progress * 2 * math.pi
      return startX + (deltaX * math.cos(angle)), startY + (deltaY * math.sin(angle))
    end
  ]],
  circle2 = [[
    function(progress, startX, startY, deltaX, deltaY)
      local angle = progress * 2 * math.pi
      return startX + (deltaX * math.sin(angle)), startY + (deltaY * math.cos(angle))
    end
  ]],
  spiral = [[
    function(progress, startX, startY, deltaX, deltaY)
      local angle = progress * 2 * math.pi
      return startX + (progress * deltaX * math.cos(angle)), startY + (progress * deltaY * math.sin(angle))
    end
  ]],
  spiralandpulse = [[
    function(progress, startX, startY, deltaX, deltaY)
      local angle = (progress + 0.25) * 2 * math.pi
      return startX + (math.cos(angle) * deltaX * math.cos(angle*2)), startY + (math.abs(math.cos(angle)) * deltaY * math.sin(angle*2))
    end
  ]],
  shake = [[
    function(progress, startX, startY, deltaX, deltaY)
      local prog
      if(progress < 0.25) then
        prog = progress * 4
      elseif(progress < .75) then
        prog = 2 - (progress * 4)
      else
        prog = (progress - 1) * 4
      end
      return startX + (prog * deltaX), startY + (prog * deltaY)
    end
  ]],
  starShakeDecay = [[
    function(progress, startX, startY, deltaX, deltaY)
      local spokes = 10
      local fullCircles = 4

      local r = min(abs(deltaX), abs(deltaY))
      local xScale = deltaX / r
      local yScale = deltaY / r

      local deltaAngle = fullCircles *2 / spokes * math.pi
      local p = progress * spokes
      local i1 = floor(p)
      p = p - i1

      local angle1 = i1 * deltaAngle
      local angle2 = angle1 + deltaAngle

      local x1 = r * math.cos(angle1)
      local y1 = r * math.sin(angle1)

      local x2 = r * math.cos(angle2)
      local y2 = r * math.sin(angle2)

      local x, y = p * x2 + (1-p) * x1, p * y2 + (1-p) * y1
      local ease = math.sin(progress * math.pi / 2)
      return ease * x * xScale, ease * y * yScale
    end
  ]],
  bounceDecay = [[
    function(progress, startX, startY, deltaX, deltaY)
      local prog = (progress * 3.5) % 1
      local bounce = math.ceil(progress * 3.5)
      local bounceDistance = math.sin(prog * math.pi) * (bounce / 4)
    return startX + (bounceDistance * deltaX), startY + (bounceDistance * deltaY)
  end
  ]],
  bounce = [[
    function(progress, startX, startY, deltaX, deltaY)
      local bounceDistance = math.sin(progress * math.pi)
      return startX + (bounceDistance * deltaX), startY + (bounceDistance * deltaY)
    end
  ]],
  flash = [[
    function(progress, start, delta)
      local prog
      if(progress < 0.5) then
        prog = progress * 2
      else
        prog = (progress - 1) * 2
      end
      return start + (prog * delta)
    end
  ]],
  pulse = [[
    function(progress, startX, startY, scaleX, scaleY)
      local angle = (progress * 2 * math.pi) - (math.pi / 2)
      return startX + (((math.sin(angle) + 1)/2) * (scaleX - 1)), startY + (((math.sin(angle) + 1)/2) * (scaleY - 1))
    end
  ]],
  alphaPulse = [[
    function(progress, start, delta)
      local angle = (progress * 2 * math.pi) - (math.pi / 2)
      return start + (((math.sin(angle) + 1)/2) * delta)
    end
  ]],
  pulseColor = [[
    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
      local angle = (progress * 2 * math.pi) - (math.pi / 2)
      local newProgress = ((math.sin(angle) + 1)/2);
      return r1 + (newProgress * (r2 - r1)),
           g1 + (newProgress * (g2 - g1)),
           b1 + (newProgress * (b2 - b1)),
           a1 + (newProgress * (a2 - a1))
    end
  ]],
  pulseHSV = [[
    function(progress, r1, g1, b1, a1, r2, g2, b2, a2)
      local angle = (progress * 2 * math.pi) - (math.pi / 2)
      local newProgress = ((math.sin(angle) + 1)/2);
      return WeakAuras.GetHSVTransition(newProgress, r1, g1, b1, a1, r2, g2, b2, a2)
    end
  ]],
  fauxspin = [[
    function(progress, startX, startY, scaleX, scaleY)
      local angle = progress * 2 * math.pi
      return math.cos(angle) * scaleX, startY + (progress * (scaleY - startY))
    end
  ]],
  fauxflip = [[
    function(progress, startX, startY, scaleX, scaleY)
      local angle = progress * 2 * math.pi
      return startX + (progress * (scaleX - startX)), math.cos(angle) * scaleY
    end
  ]],
  backandforth = [[
    function(progress, start, delta)
    local prog
    if(progress < 0.25) then
      prog = progress * 4
      elseif(progress < .75) then
      prog = 2 - (progress * 4)
    else
      prog = (progress - 1) * 4
    end
    return start + (prog * delta)
    end
  ]],
  wobble = [[
    function(progress, start, delta)
    local angle = progress * 2 * math.pi
    return start + math.sin(angle) * delta
    end
  ]],
  hide = [[
    function()
    return 0
    end
  ]]
};

WeakAuras.anim_presets = {
  -- Start and Finish
  slidetop = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 0, y = 50,
    use_alpha = true,
    alpha = 0
  },
  slideleft = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = -50,
    y = 0,
    use_alpha = true,
    alpha = 0
  },
  slideright = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 50,
    y = 0,
    use_alpha = true,
    alpha = 0
  },
  slidebottom = {
    type = "custom",
    duration = 0.25,
    use_translate = true,
    x = 0,
    y = -50,
    use_alpha = true,
    alpha = 0
  },
  fade = {
    type = "custom",
    duration = 0.25,
    use_alpha = true,
    alpha = 0
  },
  grow = {
    type = "custom",
    duration = 0.25,
    use_scale = true,
    scalex = 2,
    scaley = 2,
    use_alpha = true,
    alpha = 0
  },
  shrink = {
    type = "custom",
    duration = 0.25,
    use_scale = true,
    scalex = 0,
    scaley = 0,
    use_alpha = true,
    alpha = 0
  },
  spiral = {
    type = "custom",
    duration = 0.5,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "spiral",
    use_alpha = true,
    alpha = 0
  },
  bounceDecay = {
    type = "custom",
    duration = 1.5,
    use_translate = true,
    x = 50,
    y = 50,
    translateType = "bounceDecay",
    use_alpha = true,
    alpha = 0
  },
  starShakeDecay = {
    type = "custom",
    duration = 1,
    use_translate = true,
    x = 50,
    y = 50,
    translateType = "starShakeDecay",
    use_alpha = true,
    alpha = 0
  },
  -- Main
  shake = {
    type = "custom",
    duration = 0.5,
    use_translate = true,
    x = 10,
    y = 0,
    translateType = "circle2"
  },
  spin = {
    type = "custom",
    duration = 1,
    use_scale = true,
    scalex = 1,
    scaley = 1,
    scaleType = "fauxspin"
  },
  flip = {
    type = "custom",
    duration = 1,
    use_scale = true,
    scalex = 1,
    scaley = 1,
    scaleType = "fauxflip"
  },
  wobble = {
    type = "custom",
    duration = 0.5,
    use_rotate = true,
    rotate = 3,
    rotateType = "wobble"
  },
  pulse = {
    type = "custom",
    duration = 0.75,
    use_scale = true,
    scalex = 1.05,
    scaley = 1.05,
    scaleType = "pulse"
  },
  alphaPulse = {
    type = "custom",
    duration = 0.5,
    use_alpha = true,
    alpha = 0.5,
    alphaType = "alphaPulse"
  },
  rotateClockwise = {
    type = "custom",
    duration = 4,
    use_rotate = true,
    rotate = -360
  },
  rotateCounterClockwise = {
    type = "custom",
    duration = 4,
    use_rotate = true,
    rotate = 360
  },
  spiralandpulse = {
    type = "custom",
    duration = 6,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "spiralandpulse"
  },
  circle = {
    type = "custom",
    duration = 4,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "circle"
  },
  orbit = {
    type = "custom",
    duration = 4,
    use_translate = true,
    x = 100,
    y = 100,
    translateType = "circle",
    use_rotate = true,
    rotate = 360
  },
  bounce = {
    type = "custom",
    duration = 0.6,
    use_translate = true,
    x = 0,
    y = 25,
    translateType = "bounce"
  }
};

function WeakAuras.CheckTalentByIndex(index)
  local tab = ceil(index / MAX_NUM_TALENTS)
  local num_talent = (index - 1) % MAX_NUM_TALENTS + 1
  local _, _, _, _, rank  = GetTalentInfo(tab, num_talent)
  return rank and rank > 0;
end

function WeakAuras.CheckString(ids, currentId)
  if (not ids or not currentId) then
    return false;
  end

  for id in ids:gmatch('([^,]+)') do
    if id:trim() == currentId then
      return true
    end
  end

  return false;
end

function WeakAuras.ValidateNumeric(info, val)
  if val ~= nil and val ~= "" and (not tonumber(val) or tonumber(val) >= 2^31) then
    return false;
  end
  return true
end

function WeakAuras.ValidateNumericOrPercent(info, val)
  if val ~= nil and val ~= "" then
    local percent = string.match(val, "(%d+)%%")
    local number = percent and tonumber(percent) or tonumber(val)
    if(not number or number >= 2^31) then
      return false;
    end
  end
  return true
end

function WeakAuras.CheckChargesDirection(direction, triggerDirection)
  return triggerDirection == "CHANGED"
    or (triggerDirection == "GAINED" and direction > 0)
    or (triggerDirection == "LOST" and direction < 0)
end

function WeakAuras.CheckCombatLogFlags(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  if (flagToCheck == "InGroup") then
    return bit.band(flags, 7) > 0;
  elseif (flagToCheck == "NotInGroup") then
    return bit.band(flags, 7) == 0;
  end
end

function WeakAuras.CheckCombatLogFlagsReaction(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  if (flagToCheck == "Hostile") then
    return bit.band(flags, 64) ~= 0;
  elseif (flagToCheck == "Neutral") then
    return bit.band(flags, 32) ~= 0;
  elseif (flagToCheck == "Friendly") then
    return bit.band(flags, 16) ~= 0;
  end
end

local objectTypeToBit = {
  Object = 16384,
  Guardian = 8192,
  Pet = 4096,
  NPC = 2048,
  Player = 1024,
}

function WeakAuras.CheckCombatLogFlagsObjectType(flags, flagToCheck)
  if type(flags) ~= "number" then return end
  local bitToCheck = objectTypeToBit[flagToCheck]
  if not bitToCheck then return end
  return bit.band(flags, bitToCheck) ~= 0;
end

function WeakAuras.CheckRaidFlags(flags, flagToCheck)
  flagToCheck = tonumber(flagToCheck)
  if not flagToCheck or not flags then return end --bailout
  if flagToCheck == 0 then --no raid mark
    return bit.band(flags, COMBATLOG_OBJECT_RAIDTARGET_MASK) == 0
  elseif flagToCheck == 9 then --any raid mark
    return bit.band(flags, COMBATLOG_OBJECT_RAIDTARGET_MASK) > 0
  else -- specific raid mark
    return bit.band(flags, _G['COMBATLOG_OBJECT_RAIDTARGET'..flagToCheck]) > 0
  end
end

function WeakAuras.GetSpellCritChance()
  local spellCrit = GetSpellCritChance(2)
  for i = 3, MAX_SPELL_SCHOOLS do
    spellCrit = min(spellCrit, GetSpellCritChance(i))
  end
  return spellCrit
end

function WeakAuras.IsSpellKnownForLoad(spell, exact)
  local result = WeakAuras.IsSpellKnown(spell)
  if exact or result then
    return result
  end
  -- Dance through the spellname to the current spell id
  spell = GetSpellInfo(spell)
  if spell then
    return WeakAuras.IsSpellKnown(spell)
  end
end

function WeakAuras.IsSpellKnown(spell, pet)
  if (spell) then
    if tonumber(spell) then
      if (pet) then
        return IsSpellKnown(spell, pet);
      end
      return IsSpellKnown(spell);
    else
      return (GetSpellInfo(spell)) and true or false
    end
  end
  return false
end

function WeakAuras.IsSpellKnownIncludingPet(spell)
  if (not spell) then
    return false;
  end
  if (WeakAuras.IsSpellKnown(spell) or WeakAuras.IsSpellKnown(spell, true)) then
    return true;
  end
end

local function valuesForTalentFunction(trigger)
  return function()
    local single_class;
    -- First check to use if the class load is on multi-select with only one class selected
    if(trigger.use_class == false and trigger.class and trigger.class.multi) then
      local num_classes = 0;
      for class in pairs(trigger.class.multi) do
        single_class = class;
        num_classes = num_classes + 1;
      end
      if(num_classes ~= 1) then
        single_class = nil;
      end
    end
    -- If that is not the case, see if it is on single-select
    if((not single_class) and trigger.use_class and trigger.class and trigger.class.single) then
      single_class = trigger.class.single
    end

    if (trigger.use_class == nil) then -- no class selected, fallback to current class
      single_class = select(2, UnitClass("player"));
    end

    -- If a single specific class was found, load the specific list for it
    if(single_class and WeakAuras.talent_types_specific[single_class]
      and WeakAuras.talent_types_specific[single_class]) then
      return WeakAuras.talent_types_specific[single_class];
    else
      return WeakAuras.talent_types;
    end
  end
end

WeakAuras.load_prototype = {
  args = {
    {
      name = "combat",
      display = L["In Combat"],
      type = "tristate",
      width = WeakAuras.normalWidth,
      init = "arg",
      optional = true,
      events = {"PLAYER_REGEN_DISABLED", "PLAYER_REGEN_ENABLED"}
    },
    {
      name = "never",
      display = L["Never"],
      type = "toggle",
      width = WeakAuras.normalWidth,
      init = "false",
    },
    {
      name = "vehicle",
      display = L["In Vehicle"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"VEHICLE_UPDATE", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE", "UNIT_FLAGS"}
    },
    {
      name = "vehicleUi",
      display = L["Has Vehicle UI"],
      type = "tristate",
      init = "arg",
      width = WeakAuras.normalWidth,
      optional = true,
      events = {"VEHICLE_UPDATE", "UNIT_ENTERED_VEHICLE", "UNIT_EXITED_VEHICLE"}
    },
    {
      name = "ingroup",
      display = L["In Group"],
      type = "multiselect",
      width = WeakAuras.normalWidth,
      init = "arg",
      values = "group_types",
      events = {"PARTY_MEMBERS_CHANGED", "RAID_ROSTER_UPDATE"}
    },
    {
      name = "player",
      hidden = true,
      init = "arg",
      test = "true"
    },
    {
      name = "realm",
      hidden = true,
      init = "arg",
      test = "true"
    },
    {
      name = "namerealm",
      display = L["Player Name/Realm"],
      type = "string",
      test = "nameRealmChecker:Check(player, realm)",
      preamble = "local nameRealmChecker = WeakAuras.ParseNameCheck(%q)",
      desc = constants.nameRealmFilterDesc,
    },
    {
      name = "ignoreNameRealm",
      display = L["|cFFFF0000Not|r Player Name/Realm"],
      type = "string",
      test = "not nameRealmIgnoreChecker:Check(player, realm)",
      preamble = "local nameRealmIgnoreChecker = WeakAuras.ParseNameCheck(%q)",
      desc = constants.nameRealmFilterDesc,
    },
    {
      name = "class",
      display = L["Player Class"],
      type = "multiselect",
      values = "class_types",
      init = "arg"
    },
    {
      name = "talent",
      display = L["Talent selected"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d)",
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"}
    },
    {
      name = "talent2",
      display = L["And Talent selected"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d)",
      enable = function(trigger)
        return trigger.use_talent ~= nil or trigger.use_talent2 ~= nil;
      end,
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"}
    },
    {
      name = "talent3",
      display = L["And Talent selected"],
      type = "multiselect",
      values = valuesForTalentFunction,
      test = "WeakAuras.CheckTalentByIndex(%d)",
      enable = function(trigger)
        return (trigger.use_talent ~= nil and trigger.use_talent2 ~= nil) or trigger.use_talent3 ~= nil;
      end,
      events = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"}
    },
    {
      name = "spellknown",
      display = L["Spell Known"],
      type = "spell",
      test = "WeakAuras.IsSpellKnownForLoad(%s, %s)",
      events = {"SPELLS_CHANGED"},
      showExactOption = true
    },
    {
      name = "faction",
      display = L["Player Faction"],
      type = "multiselect",
      values = "faction_group",
      init = "arg"
    },
    {
      name = "level",
      display = L["Player Level"],
      type = "number",
      init = "arg",
      events = {"PLAYER_LEVEL_UP"}
    },
    {
      name = "zone",
      display = L["Zone Name"],
      type = "string",
      init = "arg",
      test = "WeakAuras.CheckString(%q, zone)",
      events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA", "VEHICLE_UPDATE"},
      desc = L["Supports multiple entries, separated by commas"]
    },
    {
      name = "size",
      display = L["Instance Type"],
      type = "multiselect",
      values = "instance_types",
      init = "arg",
      control = "WeakAurasSortedDropdown",
      events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA"}
    },
    {
      name = "difficulty",
      display = L["Instance Difficulty"],
      type = "multiselect",
      values = "difficulty_types",
      init = "arg",
      events = {"PLAYER_DIFFICULTY_CHANGED", "ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA"}
    },
    {
      name = "itemequiped",
      display = L["Item Equipped"],
      type = "item",
      test = "IsEquippedItem(%s)",
      events = { "UNIT_INVENTORY_CHANGED", "PLAYER_EQUIPMENT_CHANGED"}
    }
  }
};

local function AddUnitChangeInternalEvents(triggerUnit, t)
  if (triggerUnit == nil) then
    return
  end
  if (triggerUnit == "multi") then
    -- Handled by normal events"
  elseif triggerUnit == "pet" then
    WeakAuras.WatchForPetDeath();
    tinsert(t, "PET_UPDATE")
  else
    if WeakAuras.multiUnitUnits[triggerUnit] then
      for unit in pairs(WeakAuras.multiUnitUnits[triggerUnit]) do
        tinsert(t, "UNIT_CHANGED_" .. string.lower(unit))
        WeakAuras.WatchUnitChange(unit)
      end
    else
      tinsert(t, "UNIT_CHANGED_" .. string.lower(triggerUnit))
      WeakAuras.WatchUnitChange(triggerUnit)
    end
  end
end

local function AddUnitEventForEvents(result, unit, event)
  if unit then
    if not result.unit_events then
      result.unit_events = {}
    end
    if not result.unit_events[unit] then
      result.unit_events[unit] = {}
    end
    tinsert(result.unit_events[unit], event)
  else
    if not result.events then
      result.events = {}
    end
    tinsert(result.events, event)
  end
end

local unitHelperFunctions = {
  UnitChangedForceEvents = function(trigger)
    local events = {}
    if WeakAuras.multiUnitUnits[trigger.unit] then
      for unit in pairs(WeakAuras.multiUnitUnits[trigger.unit]) do
        tinsert(events, {"UNIT_CHANGED_" .. unit, unit})
      end
    else
      if trigger.unit then
        tinsert(events, {"UNIT_CHANGED_" .. trigger.unit, trigger.unit})
      end
    end
    return events
  end,

  SpecificUnitCheck = function(trigger)
    if not trigger.use_specific_unit then
      return "local specificUnitCheck = true\n"
    end

    if trigger.unit == nil then
      return "local specificUnitCheck = false\n"
    end

    return string.format([=[
      local specificUnitCheck = UnitIsUnit(%q, unit)
    ]=], trigger.unit or "")
  end
}

WeakAuras.event_prototypes = {
  ["Combo Points"] = {
    type = "status",
    events = {
      ["events"] = {
        "UNIT_COMBO_POINTS",
        "PLAYER_TARGET_CHANGED",
        "PLAYER_FOCUS_CHANGED"
       }
    },
    force_events = "UNIT_COMBO_POINTS",
    name = L["Combo Points"],
    args = {
      {
        name = "combopoints",
        display = L["Combo Points"],
        type = "number",
        init = "GetComboPoints(UnitInVehicle('player') and 'vehicle' or 'player', 'target')"
      }
    },
    durationFunc = function(trigger)
      return GetComboPoints(UnitInVehicle("player") and "vehicle" or "player", "target"), 5, true;
    end,
    stacksFunc = function(trigger)
      return GetComboPoints(UnitInVehicle("player") and "vehicle" or "player", "target");
    end,
    automaticrequired = true
  },
  ["Unit Characteristics"] = {
    type = "status",
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitEventForEvents(result, unit, "UNIT_LEVEL")
      AddUnitEventForEvents(result, unit, "UNIT_FACTION")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      if trigger.use_ignoreDead or trigger.use_ignoreDisconnected then
        AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
      end
      return result;
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitChangeInternalEvents(unit, result)
      if trigger.unitisunit then
        AddUnitChangeInternalEvents(trigger.unitisunit, result)
      end
      return result
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    name = L["Unit Characteristics"],
    init = function(trigger)
      trigger.unit = trigger.unit or "target";
      local ret = [=[
        unit = string.lower(unit)
        local smart = %s
        local extraUnit = %q;
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
      ]=];

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret:format(trigger.unit == "group" and "true" or "false", trigger.unitisunit or "");
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        test = "true",
        store = true
      },
      {
        name = "unitisunit",
        display = L["Unit is Unit"],
        type = "unit",
        init = "UnitIsUnit(unit, extraUnit) == 1 and true or false",
        values = "actual_unit_types_with_specific",
        test = "unitisunit",
        store = true,
        conditionType = "bool",
        desc = function() return L["Can be used for e.g. checking if \"boss1target\" is the same as \"player\"."] end,
        enable = function(trigger) return not WeakAuras.multiUnitUnits[trigger.unit] end
      },
      {
        name = "name",
        display = L["Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        type = "string",
        preamble = "local nameRealmChecker = WeakAuras.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return WeakAuras.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "classification",
        display = L["Classification"],
        type = "multiselect",
        init = "UnitClassification(unit)",
        values = "classification_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "ignoreDead",
        display = L["Ignore Dead"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsDeadOrGhost(unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        name = "hostility",
        display = L["Hostility"],
        type = "select",
        init = "WeakAuras.GetPlayerReaction(unit)",
        values = "hostility_types",
        store = true,
        conditionType = "select",
      },
      {
        name = "character",
        display = L["Character Type"],
        type = "select",
        init = "UnitIsPlayer(unit) and 'player' or 'npc'",
        values = "character_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "level",
        display = L["Level"],
        type = "number",
        init = "UnitLevel(unit)",
        store = true,
        conditionType = "number"
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        store = true,
        conditionType = "string",
        test = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '') == %q",
      },
      {
        name = "attackable",
        display = L["Attackable"],
        type = "tristate",
        init = "UnitCanAttack('player', unit) == 1 and true or false",
        store = true,
        conditionType = "bool"
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    automaticrequired = true
  },
  ["Health"] = {
    type = "status",
    canHaveDuration = true,
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitEventForEvents(result, unit, "UNIT_HEALTH")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      if trigger.use_ignoreDead or trigger.use_ignoreDisconnected then
        AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
      end
      return result
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitChangeInternalEvents(unit, result)
      return result
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    name = L["Health"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = [=[
        unit = string.lower(unit)
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
        local smart = %s
      ]=];

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret:format(trigger.unit == "group" and "true" or "false");
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        test = "true",
        store = true
      },
      {
        name = "health",
        display = L["Health"],
        type = "number",
        init = "UnitHealth(unit)",
        store = true,
        conditionType = "number"
      },
      {
        name = "value",
        hidden = true,
        init = "health",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "UnitHealthMax(unit)",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "percenthealth",
        display = L["Health (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100",
        store = true,
        conditionType = "number"
      },
      {
        name = "name",
        display = L["Unit Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        type = "string",
        preamble = "local nameRealmChecker = WeakAuras.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return WeakAuras.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        store = true,
        conditionType = "string",
        test = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '') == %q",
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "ignoreDead",
        display = L["Ignore Dead"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsDeadOrGhost(unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        name = "name",
        hidden = true,
        init = "UnitName(unit)",
        test = "true"
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    automaticrequired = true
  },
  ["Power"] = {
    type = "status",
    canHaveDuration = true,
    events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitEventForEvents(result, unit, "UNIT_MANA")
      AddUnitEventForEvents(result, unit, "UNIT_RAGE")
      AddUnitEventForEvents(result, unit, "UNIT_FOCUS")
      AddUnitEventForEvents(result, unit, "UNIT_ENERGY")
      AddUnitEventForEvents(result, unit, "UNIT_RUNIC_POWER")
      AddUnitEventForEvents(result, unit, "UNIT_MAXMANA")
      AddUnitEventForEvents(result, unit, "UNIT_MAXRAGE")
      AddUnitEventForEvents(result, unit, "UNIT_MAXFOCUS")
      AddUnitEventForEvents(result, unit, "UNIT_MAXENERGY")
      AddUnitEventForEvents(result, unit, "UNIT_MAXRUNIC_POWER")
      AddUnitEventForEvents(result, unit, "UNIT_DISPLAYPOWER")
      AddUnitEventForEvents(result, unit, "UNIT_HAPPINESS")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")

      if trigger.use_ignoreDead or trigger.use_ignoreDisconnected then
        AddUnitEventForEvents(result, unit, "UNIT_FLAGS")
      end

      return result;
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {}
      AddUnitChangeInternalEvents(unit, result)

      return result
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    name = L["Power"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = [=[
        unit = string.lower(unit)
        local name, realm = WeakAuras.UnitNameWithRealm(unit)
        local smart = %s
        local powerType = %s;
        local unitPowerType = UnitPowerType(unit);
        local powerTypeToCheck = powerType or unitPowerType;
      ]=];
      ret = ret:format(trigger.unit == "group" and "true" or "false", trigger.use_powertype and trigger.powertype or "nil");

      ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)

      return ret
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = "actual_unit_types_cast",
        test = "true",
        store = true
      },
      {
        name = "powertype",
        display = L["Power Type"],
        type = "select",
        values = "power_types",
        init = "unitPowerType",
        test = "true",
        store = true,
        conditionType = "select"
      },
      {
        name = "requirePowerType",
        display = L["Only if Primary"],
        type = "toggle",
        test = "unitPowerType == powerType",
        enable = function(trigger)
          return trigger.use_powertype
        end,
      },
      {
        name = "power",
        display = L["Power"],
        type = "number",
        init = "UnitPower(unit, powerType)",
        store = true,
        conditionType = "number",
      },
      {
        name = "value",
        hidden = true,
        init = "power",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "math.max(1, UnitPowerMax(unit, powerType))",
        store = true,
        test = "true"
      },
      {
        name = "stacks",
        hidden = true,
        init = "power",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        name = "percentpower",
        display = L["Power (%)"],
        type = "number",
        init = "total ~= 0 and (value / total) * 100",
        store = true,
        conditionType = "number"
      },
      {
        name = "name",
        display = L["Unit Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "realm",
        display = L["Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "namerealm",
        display = L["Unit Name/Realm"],
        type = "string",
        preamble = "local nameRealmChecker = WeakAuras.ParseNameCheck(%q)",
        test = "nameRealmChecker:Check(name, realm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return WeakAuras.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.name, state.realm)
        end,
        operator_types = "none",
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        store = true,
        conditionType = "string",
        test = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '') == %q",
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "ignoreDead",
        display = L["Ignore Dead"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "not UnitIsDeadOrGhost(unit)"
      },
      {
        name = "ignoreDisconnected",
        display = L["Ignore Disconnected"],
        type = "toggle",
        width = WeakAuras.doubleWidth,
        enable = function(trigger)
          return trigger.unit == "group" or trigger.unit == "raid" or trigger.unit == "party"
        end,
        init = "UnitIsConnected(unit)"
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and specificUnitCheck"
      }
    },
    automaticrequired = true
  },
  -- Todo: Give useful options to condition based on GUID and flag info
  ["Combat Log"] = {
    type = "event",
    events = {
      ["events"] = {"COMBAT_LOG_EVENT_UNFILTERED"}
    },
    init = function(trigger)
      local ret = [[
        local use_cloneId = %s;
      ]];
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    name = L["Combat Log"],
    canHaveAuto = true,
    statesParameter = "all",
    args = {
      {}, -- timestamp ignored with _ argument
      {}, -- messageType ignored with _ argument (it is checked before the dynamic function)
      {
        name = "sourceGUID",
        init = "arg",
        hidden = "true",
        test = "true",
        store = true,
        display = L["Source GUID"]
      },
      {
        name = "sourceUnit",
        display = L["Source Unit"],
        type = "unit",
        test = "(sourceGUID or '') == (UnitGUID(%q) or '') and sourceGUID",
        values = "actual_unit_types_with_specific",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "ENVIRONMENTAL")
        end,
        store = true,
        conditionType = "select",
        conditionTest = function(state, needle, op)
          return state and state.show and ((state.sourceGUID or '') == (UnitGUID(needle) or '')) == (op == "==")
        end
      },
      {
        name = "sourceName",
        display = L["Source Name"],
        type = "string",
        init = "arg",
        store = true,
        conditionType = "string"
      },
      {
        name = "sourceNpcId",
        display = L["Source NPC Id"],
        type = "string",
        test = "tostring(tonumber(string.sub(sourceGUID or '', 8, 12), 16) or '') == %q",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "ENVIRONMENTAL")
        end,
      },
      {
        name = "sourceFlags",
        display = L["Source In Group"],
        type = "select",
        values = "combatlog_flags_check_type",
        init = "arg",
        store = true,
        test = "WeakAuras.CheckCombatLogFlags(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlags(state.sourceFlags, needle);
        end
      },
      {
        name = "sourceFlags2",
        display = L["Source Reaction"],
        type = "select",
        values = "combatlog_flags_check_reaction",
        test = "WeakAuras.CheckCombatLogFlagsReaction(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlagsReaction(state.sourceFlags, needle);
        end
      },
      {
        name = "sourceFlags3",
        display = L["Source Object Type"],
        type = "select",
        values = "combatlog_flags_check_object_type",
        test = "WeakAuras.CheckCombatLogFlagsObjectType(sourceFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlagsObjectType(state.sourceFlags, needle);
        end
      },
      {
        name = "destGUID",
        init = "arg",
        hidden = "true",
        test = "true",
        store = true,
        display = L["Destination GUID"]
      },
      {
        name = "destUnit",
        display = L["Destination Unit"],
        type = "unit",
        test = "(destGUID or '') == (UnitGUID(%q) or '') and destGUID",
        values = "actual_unit_types_with_specific",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
        store = true,
        conditionType = "select",
        conditionTest = function(state, needle, op)
          return state and state.show and ((state.destGUID or '') == (UnitGUID(needle) or '')) == (op == "==")
        end
      },
      {
        name = "destName",
        display = L["Destination Name"],
        type = "string",
        init = "arg",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
        store = true,
        conditionType = "string"
      },
      {
        name = "destNpcId",
        display = L["Destination NPC Id"],
        type = "string",
        test = "tostring(tonumber(string.sub(destGUID or '', 8, 12), 16) or '') == %q",
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      { -- destName ignore for SPELL_CAST_START
        enable = function(trigger)
          return (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end
      },
      {
        name = "destFlags",
        display = L["Destination In Group"],
        type = "select",
        values = "combatlog_flags_check_type",
        init = "arg",
        store = true,
        test = "WeakAuras.CheckCombatLogFlags(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlags(state.destFlags, needle);
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destFlags2",
        display = L["Destination Reaction"],
        type = "select",
        values = "combatlog_flags_check_reaction",
        test = "WeakAuras.CheckCombatLogFlagsReaction(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlagsReaction(state.destFlags, needle);
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "destFlags3",
        display = L["Destination Object Type"],
        type = "select",
        values = "combatlog_flags_check_object_type",
        test = "WeakAuras.CheckCombatLogFlagsObjectType(destFlags, %q)",
        conditionType = "select",
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckCombatLogFlagsObjectType(state.destFlags, needle);
        end,
        enable = function(trigger)
          return not (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {-- destFlags ignore for SPELL_CAST_START
        enable = function(trigger)
          return (trigger.subeventPrefix == "SPELL" and trigger.subeventSuffix == "_CAST_START");
        end,
      },
      {
        name = "spellId",
        display = L["Spell Id"],
        type = "string",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "spellName",
        display = L["Spell Name"],
        type = "string",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        conditionType = "string"
      },
      {
        enable = function(trigger)
          return trigger.subeventPrefix and (trigger.subeventPrefix:find("SPELL") or trigger.subeventPrefix == "RANGE" or trigger.subeventPrefix:find("DAMAGE"))
        end
      }, -- spellSchool ignored with _ argument
      {
        name = "environmentalType",
        display = L["Environment Type"],
        type = "select",
        init = "arg",
        values = "environmental_types",
        enable = function(trigger)
          return trigger.subeventPrefix == "ENVIRONMENTAL"
        end,
        store = true,
        conditionType = "select"
      },
      {
        name = "missType",
        display = L["Miss Type"],
        type = "select",
        init = "arg",
        values = "miss_types",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_MISSED" or trigger.subeventPrefix == "DAMAGE_SHIELD_MISSED")
        end,
        conditionType = "select",
        store = true
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end
      }, -- extraSpellId ignored with SPELL_INTERRUPT
      {
        name = "extraSpellName",
        display = L["Extra Spell Name"],
        type = "string",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end,
        store = true,
        conditionType = "string"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_INTERRUPT" or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_DISPEL_FAILED" or trigger.subeventSuffix == "_STOLEN" or trigger.subeventSuffix == "_AURA_BROKEN_SPELL")
        end
      }, -- extraSchool ignored with _ argument
      {
        name = "auraType",
        display = L["Aura Type"],
        type = "select",
        init = "arg",
        values = "aura_types",
        store = true,
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix:find("AURA") or trigger.subeventSuffix == "_DISPEL" or trigger.subeventSuffix == "_STOLEN")
        end,
        conditionType = "select"
      },
      {
        name = "amount",
        display = L["Amount"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventSuffix == "_HEAL" or trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH" or trigger.subeventPrefix:find("DAMAGE"))
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "overkill",
        display = L["Overkill"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "overhealing",
        display = L["Overhealing"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventSuffix == "_HEAL"
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end
      }, -- damage school ignored with _ argument
      {
        name = "resisted",
        display = L["Resisted"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "blocked",
        display = L["Blocked"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "absorbed",
        display = L["Absorbed"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT" or trigger.subeventSuffix == "_HEAL")
        end,
        store = true,
        conditionType = "number"
      },
      {
        name = "critical",
        display = L["Critical"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT" or trigger.subeventSuffix == "_HEAL")
        end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "glancing",
        display = L["Glancing"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "crushing",
        display = L["Crushing"],
        type = "tristate",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and trigger.subeventPrefix and (trigger.subeventSuffix == "_DAMAGE" or trigger.subeventPrefix == "DAMAGE_SHIELD" or trigger.subeventPrefix == "DAMAGE_SPLIT")
        end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "number",
        display = L["Number"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_EXTRA_ATTACKS" or trigger.subeventSuffix:find("DOSE"))
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE")
        end
      }, -- unknown argument for _ENERGIZE ignored
      {
        name = "powerType",
        display = L["Power Type"],
        type = "select",
        init = "arg",
        values = "power_types",
        store = true,
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH")
        end,
        conditionType = "select"
      },
      {
        name = "extraAmount",
        display = L["Extra Amount"],
        type = "number",
        init = "arg",
        enable = function(trigger)
          return trigger.subeventSuffix and (trigger.subeventSuffix == "_ENERGIZE" or trigger.subeventSuffix == "_DRAIN" or trigger.subeventSuffix == "_LEECH")
        end,
        store = true,
        conditionType = "number"
      },
      {
        enable = function(trigger)
          return trigger.subeventSuffix == "_CAST_FAILED"
        end
      }, -- failedType ignored with _ argument - theoretically this is not necessary because it is the last argument in the event, but it is added here for completeness
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''"
      },
      {
        hidden = true,
        name = "icon",
        init = "spellId and select(3, GetSpellInfo(spellId)) or 'Interface\\\\Icons\\\\INV_Misc_QuestionMark'",
        store = true,
        test = "true"
      }
    },
    timedrequired = true
  },
  ["Cooldown Progress (Spell)"] = {
    type = "status",
    events = {},
    internal_events = function(trigger, untrigger)
      local events = {
        "SPELL_COOLDOWN_CHANGED",
        "COOLDOWN_REMAINING_CHECK",
        "WA_DELAYED_PLAYER_ENTERING_WORLD"
      };
      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end
      return events;
    end,
    force_events = "SPELL_COOLDOWN_FORCE",
    name = L["Cooldown Progress (Spell)"],
    loadFunc = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      WeakAuras.WatchSpellCooldown(spellName, trigger.use_matchedRune);
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      trigger.realSpellName = spellName; -- Cache
      local ret = [=[
        local spellname = %s
        local ignoreRuneCD = %s
        local showgcd = %s;
        local track = %q
        local startTime, duration, gcdCooldown = WeakAuras.GetSpellCooldown(spellname, ignoreRuneCD, showgcd, track);
        local spellCount = WeakAuras.GetSpellCharges(spellname);
        local stacks = (spellCount and spellCount > 0 and spellCount) or nil;
        local genericShowOn = %s
        local expirationTime = startTime and duration and startTime + duration
        state.spellname = spellname;
      ]=];

      local showOnCheck = "false";
      if (trigger.genericShowOn == "showOnReady") then
        showOnCheck = "startTime and startTime == 0 or gcdCooldown";
      elseif (trigger.genericShowOn == "showOnCooldown") then
        showOnCheck = "startTime and startTime > 0 and not gcdCooldown";
      elseif (trigger.genericShowOn == "showAlways") then
        showOnCheck = "startTime ~= nil";
      end

      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end
      ret = ret:format(spellName,
        (trigger.use_matchedRune and "true" or "false"),
        (trigger.use_showgcd and "true" or "false"),
        (trigger.track or "auto"),
        showOnCheck
      );

      if (not trigger.use_trackcharge or not trigger.trackcharge) then
        ret = ret .. [=[
          if (state.expirationTime ~= expirationTime) then
            state.expirationTime = expirationTime;
            state.changed = true;
          end
          if (state.duration ~= duration) then
            state.duration = duration;
            state.changed = true;
          end
          state.progressType = 'timed';
        ]=];
      else
        local ret2 = [=[
          local trackedCharge = %s
          if (charges < trackedCharge) then
            if (state.value ~= duration) then
              state.value = duration;
              state.changed = true;
            end
            if (state.total ~= duration) then
              state.total = duration;
              state.changed = true;
            end

            state.expirationTime = nil;
            state.duration = nil;
            state.progressType = 'static';
          elseif (charges > trackedCharge) then
            if (state.expirationTime ~= 0) then
              state.expirationTime = 0;
              state.changed = true;
            end
            if (state.duration ~= 0) then
              state.duration = 0;
              state.changed = true;
            end
            state.value = nil;
            state.total = nil;
            state.progressType = 'timed';
          else
            if (state.expirationTime ~= expirationTime) then
              state.expirationTime = expirationTime;
              state.changed = true;
              state.changed = true;
            end
            if (state.duration ~= duration) then
              state.duration = duration;
              state.changed = true;
            end
            state.value = nil;
            state.total = nil;
            state.progressType = 'timed';
          end
        ]=];
        local trackedCharge = tonumber(trigger.trackcharge or 1) or 1;
        ret = ret .. ret2:format(trackedCharge - 1);
      end
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        local ret2 = [[
          local remaining = 0;
          if (expirationTime and expirationTime > 0) then
            remaining = expirationTime - GetTime();
            local remainingCheck = %s;
            if(remaining >= remainingCheck and remaining > 0) then
              WeakAuras.ScheduleScan(expirationTime - remainingCheck);
            end
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0);
      end

      return ret;
    end,
    statesParameter = "one",
    canHaveDuration = "timed",
    args = {
      {
      }, -- Ignore first argument (id)
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        test = "true",
        forceExactOption = true,
      },
      {
        name = "extra Cooldown Progress (Spell)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.track == "charges" then
              text = L["Tracking Charge CDs"]
            elseif trigger.track == "cooldown" then
              text = L["Tracking Only Cooldown"]
            end
            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end

            if trigger.use_matchedRune then
              if text ~= "" then text = text .. "; " end
              text = text ..L["Ignore Rune CDs"]
            end

            if trigger.genericShowOn ~= "showOnReady" and trigger.track ~= "cooldown" then
              if trigger.use_trackcharge and trigger.trackcharge then
                if text ~= "" then text = text .. "; " end
                text = text .. L["Tracking Charge %i"]:format(trigger.trackcharge)
              end
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "track",
        display = L["Track Cooldowns"],
        type = "select",
        values = "cooldown_types",
        collapse = "extra Cooldown Progress (Spell)",
        test = "true",
        required = true,
        default = "auto"
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "matchedRune",
        display = L["Ignore Rune CD"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "trackcharge",
        display = L["Show CD of Charge"],
        type = "number",
        enable = function(trigger)
          return (trigger.genericShowOn ~= "showOnReady") and trigger.track ~= "cooldown"
        end,
        test = "true",
        noOperator = true,
        collapse = "extra Cooldown Progress (Spell)"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end
      },
      {
        name = "charges",
        display = L["Stacks"],
        type = "number",
        store = true,
        conditionType = "number"
      },
      {
        name = "spellCount",
        display = L["Spell Count"],
        type = "number",
        store = true,
        conditionType = "number"
      },
      {
        name = "stacks",
        init = "stacks",
        hidden = true,
        test = "true",
        store = true
      },
      {
        hidden  = true,
        name = "maxCharges",
        store = true,
        display = L["Max Charges"],
        conditionType = "number",
        test = "true",
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime()) == (needle == 1)
        end,
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        name = "spellUsable",
        display = L["Spell Usable"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and ((IsUsableSpell(state.spellname) == 1 and true or false) == (needle == 1))
        end,
        conditionEvents = {
          "SPELL_UPDATE_USABLE",
          "PLAYER_TARGET_CHANGED",
          "UNIT_MANA", "UNIT_RAGE", "UNIT_FOCUS", "UNIT_ENERGY", "UNIT_RUNIC_POWER"
        },
      },
      {
        name = "insufficientResources",
        display = L["Insufficient Resources"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and ((select(2, IsUsableSpell(state.spellname)) == 1 and true or false) == (needle == 1));
        end,
        conditionEvents = {
          "SPELL_UPDATE_USABLE",
          "PLAYER_TARGET_CHANGED",
          "UNIT_MANA", "UNIT_RAGE", "UNIT_FOCUS", "UNIT_ENERGY", "UNIT_RUNIC_POWER"
        }
      },
      {
        name = "spellInRange",
        display = L["Spell in Range"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (UnitExists('target') and state.spellname and WeakAuras.IsSpellInRange(state.spellname, 'target') == needle)
        end,
        conditionEvents = {
          "PLAYER_TARGET_CHANGED",
          "WA_SPELL_RANGECHECK",
        }
      },
      {
        hidden = true,
        test = "genericShowOn"
      }
    },
    nameFunc = function(trigger)
      local name = GetSpellInfo(trigger.realSpellName or 0);
      if(name) then
        return name;
      end
      name = GetSpellInfo(trigger.spellName or 0);
      if (name) then
        return name;
      end
      return "Invalid";
    end,
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.realSpellName or 0);
      if (not icon) then
        icon = select(3, GetSpellInfo(trigger.spellName or 0));
      end
      return icon;
    end,
    hasSpellID = true,
    automaticrequired = true,
  },
  ["Cooldown Ready (Spell)"] = {
    type = "event",
    events = {},
    internal_events = {
      "SPELL_COOLDOWN_READY",
    },
    name = L["Cooldown Ready (Spell)"],
    loadFunc = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      trigger.realSpellName = spellName; -- Cache
      WeakAuras.WatchSpellCooldown(spellName);
    end,
    init = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end

      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end

      local ret = [=[
        local spellname = %s
      ]=]
      return ret:format(spellName);
    end,
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        init = "arg",
        showExactOption = true,
        test = "spellname == spellName"
      }
    },
    nameFunc = function(trigger)
      local name = GetSpellInfo(trigger.realSpellName or 0);
      if(name) then
        return name;
      end
      name = GetSpellInfo(trigger.spellName or 0);
      if (name) then
        return name;
      end
      return "Invalid";
    end,
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.realSpellName or 0);
      if (not icon) then
        icon = select(3, GetSpellInfo(trigger.spellName or 0));
      end
      return icon;
    end,
    hasSpellID = true,
    timedrequired = true
  },
  ["Charges Changed (Spell)"] = {
    type = "event",
    events = {},
    internal_events = {
      "SPELL_CHARGES_CHANGED",
    },
    name = L["Charges Changed (Spell)"],
    loadFunc = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      trigger.realSpellName = spellName; -- Cache
      WeakAuras.WatchSpellCooldown(spellName);
    end,
    init = function(trigger)
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      spellName = string.format("%q", spellName or "");
      return string.format("local spell = %s;\n", spellName);
    end,
    statesParameter = "one",
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        init = "arg",
        showExactOption = true,
        test = "spell == spellName"
      },
      {
        name = "direction",
        required = true,
        display = L["Charge gained/lost"],
        type = "select",
        values = "charges_change_type",
        init = "arg",
        test = "WeakAuras.CheckChargesDirection(direction, %q)",
        store = true,
        conditionType = "select",
        conditionValues = "charges_change_condition_type";
        conditionTest = function(state, needle)
          return state and state.show and WeakAuras.CheckChargesDirection(state.direction, needle)
        end,
      },
      {
        name = "charges",
        display = L["Charges"],
        type = "number",
        init = "arg",
        store = true,
        conditionType = "number"
      }
    },
    nameFunc = function(trigger)
      local name = GetSpellInfo(trigger.realSpellName or 0);
      if(name) then
        return name;
      end
      name = GetSpellInfo(trigger.spellName or 0);
      if (name) then
        return name;
      end
      return "Invalid";
    end,
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.realSpellName or 0);
      if (not icon) then
        icon = select(3, GetSpellInfo(trigger.spellName or 0));
      end
      return icon;
    end,
    hasSpellID = true,
    timedrequired = true
  },
  ["Cooldown Progress (Item)"] = {
    type = "status",
    events = {},
    internal_events = function(trigger, untrigger)
      local events = {
        "ITEM_COOLDOWN_READY",
        "ITEM_COOLDOWN_CHANGED",
        "ITEM_COOLDOWN_STARTED",
        "COOLDOWN_REMAINING_CHECK",
      }
      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end
      return events
    end,
    force_events = "ITEM_COOLDOWN_FORCE",
    name = L["Cooldown Progress (Item)"],
    loadFunc = function(trigger)
      trigger.itemName = trigger.itemName or 0;
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or "[["..trigger.itemName.."]]";
      WeakAuras.WatchItemCooldown(trigger.itemName);
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      trigger.itemName = trigger.itemName or 0;
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or "[["..trigger.itemName.."]]";
      local ret = [=[
        local itemname = %s;
        local showgcd = %s
        local startTime, duration, enabled, gcdCooldown = WeakAuras.GetItemCooldown(itemname, showgcd);
        local genericShowOn = %s
        state.itemname = itemname;
      ]=];
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        local ret2 = [[
          local expirationTime = startTime + duration
          local remaining = expirationTime > 0 and (expirationTime - GetTime()) or 0;
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            WeakAuras.ScheduleScan(expirationTime - remainingCheck);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0);
      end
      return ret:format(itemName,
                        trigger.use_showgcd and "true" or "false",
                        "[[" .. (trigger.genericShowOn or "") .. "]]");
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        test = "true"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end,
        init = "remaining"
      },
      {
        name = "extra Cooldown Progress (Item)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Item)"
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        hidden = true,
        name = "enabled",
        store = true,
        test = "true",
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime() or state.enabled == 0) == (needle == 1)
        end,
      },
      {
        name = "itemInRange",
        display = L["Item in Range"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (UnitExists('target') and IsItemInRange(state.itemname, 'target')) == (needle == 1)
        end,
        conditionEvents = {
          "PLAYER_TARGET_CHANGED",
          "WA_SPELL_RANGECHECK",
        }
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        test = "(genericShowOn == \"showOnReady\" and (startTime == 0 and enabled == 1 or gcdCooldown))" ..
        "or (genericShowOn == \"showOnCooldown\" and (startTime > 0 or enabled == 0) and not gcdCooldown) " ..
        "or (genericShowOn == \"showAlways\")"
      }
    },
    durationFunc = function(trigger)
      local startTime, duration = WeakAuras.GetItemCooldown(type(trigger.itemName) == "number" and trigger.itemName or 0, trigger.use_showgcd);
      startTime = startTime or 0;
      duration = duration or 0;
      return duration, startTime + duration;
    end,
    nameFunc = function(trigger)
      local name = GetItemInfo(trigger.itemName or 0);
      if(name) then
        return name;
      else
        return "Invalid";
      end
    end,
    iconFunc = function(trigger)
      local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(trigger.itemName or 0);
      return icon;
    end,
    hasItemID = true,
    automaticrequired = true,
    automaticAutoHide = false
  },
  ["Cooldown Progress (Equipment Slot)"] = {
    type = "status",
    events = {
      ["unit_events"] = {
        ["player"] = {"UNIT_INVENTORY_CHANGED"}
      }
    },
    internal_events = function(trigger, untrigger)
      local events = {
        "ITEM_SLOT_COOLDOWN_STARTED",
        "ITEM_SLOT_COOLDOWN_CHANGED",
        "COOLDOWN_REMAINING_CHECK",
        "ITEM_SLOT_COOLDOWN_ITEM_CHANGED",
        "ITEM_SLOT_COOLDOWN_READY",
        "WA_DELAYED_PLAYER_ENTERING_WORLD"
      }

      if (trigger.use_showgcd) then
        tinsert(events, "GCD_START");
        tinsert(events, "GCD_CHANGE");
        tinsert(events, "GCD_END");
      end

      return events
    end,
    force_events = "ITEM_COOLDOWN_FORCE",
    name = L["Cooldown Progress (Equipment Slot)"],
    loadFunc = function(trigger)
      WeakAuras.WatchItemSlotCooldown(trigger.itemSlot);
      if (trigger.use_showgcd) then
        WeakAuras.WatchGCD();
      end
    end,
    init = function(trigger)
      local ret = [[
        local showgcd = %s
        local startTime, duration, enable, gcdCooldown = WeakAuras.GetItemSlotCooldown(%s, showgcd);
        local genericShowOn = %s
        local remaining = startTime + duration - GetTime();
      ]];
      if(trigger.use_remaining and trigger.genericShowOn ~= "showOnReady") then
        local ret2 = [[
          local expirationTime = startTime + duration
          local remaining = expirationTime > 0 and (expirationTime - GetTime()) or 0;
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            WeakAuras.ScheduleScan(expirationTime - remainingCheck);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining or 0) or 0);
      end
      return ret:format(trigger.use_showgcd and "true" or "false",
                        trigger.itemSlot or "0",
                        "[[" .. (trigger.genericShowOn or "") .. "]]");
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemSlot",
        required = true,
        display = L["Equipment Slot"],
        type = "select",
        values = "item_slot_types",
        test = "true"
      },
      {
        name = "extra Cooldown Progress (Equipment Slot)",
        display = function(trigger)
          return function()
            local text = "";
            if trigger.use_showgcd then
              if text ~= "" then text = text .. "; " end
              text = text .. L["Show GCD"]
            end
            if text == "" then
              return L["|cFFffcc00Extra Options:|r None"]
            end
            return L["|cFFffcc00Extra Options:|r %s"]:format(text)
          end
        end,
        type = "collapse",
      },
      {
        name = "showgcd",
        display = L["Show Global Cooldown"],
        type = "toggle",
        test = "true",
        collapse = "extra Cooldown Progress (Equipment Slot)"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return (trigger.genericShowOn ~= "showOnReady") end,
        init = "remaining"
      },
      {
        name = "testForCooldown",
        display = L["is useable"],
        type = "toggle",
        test = "enable == 1"
      },
      {
        name = "genericShowOn",
        display =  L["Show"],
        type = "select",
        values = "cooldown_progress_behavior_types",
        test = "true",
        required = true,
        default = "showOnCooldown"
      },
      {
        hidden = true,
        name = "onCooldown",
        test = "true",
        display = L["On Cooldown"],
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (not state.gcdCooldown and state.expirationTime and state.expirationTime > GetTime()) == (needle == 1);
        end,
      },
      {
        hidden = true,
        name = "gcdCooldown",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        test = "(genericShowOn == \"showOnReady\" and (startTime == 0 or gcdCooldown)) " ..
        "or (genericShowOn == \"showOnCooldown\" and startTime > 0 and not gcdCooldown) " ..
        "or (genericShowOn == \"showAlways\")"
      }
    },
    durationFunc = function(trigger)
      local startTime, duration = WeakAuras.GetItemSlotCooldown(trigger.itemSlot or 0, trigger.use_showgcd);
      startTime = startTime or 0;
      duration = duration or 0;
      return duration, startTime + duration;
    end,
    nameFunc = function(trigger)
      local item = GetInventoryItemID("player", trigger.itemSlot or 0);
      if (item) then
        return GetItemInfo(item);
      end
    end,
    stacksFunc = function(trigger)
      local count = GetInventoryItemCount("player", trigger.itemSlot or 0)
      if ((count == 1) and (not GetInventoryItemTexture("player", trigger.itemSlot or 0))) then
        count = 0
      end
      return count
    end,
    iconFunc = function(trigger)
      return GetInventoryItemTexture("player", trigger.itemSlot or 0) or "Interface\\Icons\\INV_Misc_QuestionMark";
    end,
    automaticrequired = true,
  },
  ["Cooldown Ready (Item)"] = {
    type = "event",
    events = {},
    internal_events = {
      "ITEM_COOLDOWN_READY",
    },
    name = L["Cooldown Ready (Item)"],
    loadFunc = function(trigger)
      trigger.itemName = trigger.itemName or 0;
      WeakAuras.WatchItemCooldown(trigger.itemName);
    end,
    init = function(trigger)
      trigger.itemName = trigger.itemName or 0;
    end,
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        init = "arg"
      }
    },
    nameFunc = function(trigger)
      local name = GetItemInfo(trigger.itemName or 0);
      if(name) then
        return name;
      else
        return "Invalid";
      end
    end,
    iconFunc = function(trigger)
      local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(trigger.itemName or 0);
      return icon;
    end,
    hasItemID = true,
    timedrequired = true
  },
  ["Cooldown Ready (Equipment Slot)"] = {
    type = "event",
    events = {},
    internal_events = {
      "ITEM_SLOT_COOLDOWN_READY"
    },
    name = L["Cooldown Ready (Equipment Slot)"],
    loadFunc  = function(trigger)
      WeakAuras.WatchItemSlotCooldown(trigger.itemSlot);
    end,
    init = function(trigger)
    end,
    args = {
      {
        name = "itemSlot",
        required = true,
        display = L["Equipment Slot"],
        type = "select",
        values = "item_slot_types",
        init = "arg"
      }
    },
    nameFunc = function(trigger)
      return "";
    end,
    iconFunc = function(trigger)
      return GetInventoryItemTexture("player", trigger.itemSlot or 0) or "Interface\\Icons\\INV_Misc_QuestionMark";
    end,
    hasItemID = true,
    timedrequired = true
  },
  ["GTFO"] = {
    type = "event",
    events = {
      ["events"] = {"GTFO_DISPLAY"}
    },
    name = L["GTFO Alert"],
    statesParameter = "one",
    args = {
      {
        name = "alertType",
        display = L["Alert Type"],
        type = "select",
        init = "arg",
        values = "gtfo_types",
        store = true,
        conditionType = "select"
      },
    },
    timedrequired = true
  },
  -- DBM events
  ["DBM Announce"] = {
    type = "event",
    events = {},
    internal_events = {
      "DBM_Announce"
    },
    name = L["DBM Announce"],
    init = function(trigger)
      WeakAuras.RegisterDBMCallback("DBM_Announce");
      local ret = "local use_cloneId = %s;"
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    statesParameter = "all",
    canHaveAuto = true,
    args = {
      {
        name = "message",
        init = "arg",
        display = L["Message"],
        type = "longstring",
        store = true,
        conditionType = "string"
      },
      {
        name = "name",
        init = "message",
        hidden = true,
        test = "true",
        store = true,
      },
      {
        name = "icon",
        init = "arg",
        store = true,
        hidden = true,
        test = "true"
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''"
      },
    },
    timedrequired = true
  },
  ["DBM Timer"] = {
    type = "status",
    events = {},
    internal_events = {
      "DBM_TimerStart", "DBM_TimerStop", "DBM_TimerStopAll", "DBM_TimerUpdate", "DBM_TimerForce"
    },
    force_events = "DBM_TimerForce",
    name = L["DBM Timer"],
    canHaveAuto = true,
    canHaveDuration = "timed",
    triggerFunction = function(trigger)
      WeakAuras.RegisterDBMCallback("DBM_TimerStart")
      WeakAuras.RegisterDBMCallback("DBM_TimerStop")
      WeakAuras.RegisterDBMCallback("DBM_TimerUpdate")
      WeakAuras.RegisterDBMCallback("wipe")
      WeakAuras.RegisterDBMCallback("kill")

      local ret = [=[
        return function (states, event, id)
          local triggerId = %q
          local triggerSpellId = %q
          local triggerText = %q
          local triggerTextOperator = %q
          local useClone = %s
          local extendTimer = %s
          local triggerUseRemaining = %s
          local triggerRemaining = %s
          local triggerCount = %q
          local triggerDbmType = %s
          local cloneId = useClone and id or ""
          local state = states[cloneId]

          function copyOrSchedule(bar, cloneId)
            if triggerUseRemaining then
              local remainingTime = bar.expirationTime - GetTime() + extendTimer
              if remainingTime %s triggerRemaining then
                WeakAuras.CopyBarToState(bar, states, cloneId, extendTimer)
              else
                local state = states[cloneId]
                if state and state.show then
                  state.show = false
                  state.changed = true
                end
              end
              if remainingTime >= triggerRemaining then
                WeakAuras.ScheduleDbmCheck(bar.expirationTime - triggerRemaining + extendTimer)
              end
            else
              WeakAuras.CopyBarToState(bar, states, cloneId, extendTimer)
            end
          end

          if useClone then
            if event == "DBM_TimerStart" then
              if WeakAuras.DBMTimerMatches(id, triggerId, triggerText, triggerTextOperator, triggerSpellId, triggerDbmType, triggerCount) then
                local bar = WeakAuras.GetDBMTimerById(id)
                if bar then
                  copyOrSchedule(bar, cloneId)
                end
              end
            elseif event == "DBM_TimerStop" and state then
              local bar_remainingTime = GetTime() - state.expirationTime + (state.extend or 0)
              if state.extend == 0 or bar_remainingTime > 0.2 then
                state.show = false
                state.changed = true
              end
            elseif event == "DBM_TimerUpdate" then
              for id, bar in pairs(WeakAuras.GetAllDBMTimers()) do
                if WeakAuras.DBMTimerMatches(id, triggerId, triggerText, triggerTextOperator, triggerSpellId, triggerDbmType, triggerCount) then
                  copyOrSchedule(bar, id)
                else
                  local state = states[id]
                  if state then
                    local bar_remainingTime = GetTime() - state.expirationTime + (state.extend or 0)
                    if state.extend == 0 or bar_remainingTime > 0.2 then
                      state.show = false
                      state.changed = true
                    end
                  end
                end
              end
            elseif event == "DBM_TimerForce" then
              wipe(states)
              for id, bar in pairs(WeakAuras.GetAllDBMTimers()) do
                if WeakAuras.DBMTimerMatches(id, triggerId, triggerText, triggerTextOperator, triggerSpellId, triggerDbmType, triggerCount) then
                  copyOrSchedule(bar, cloneId)
                end
              end
            end
          else
            if event == "DBM_TimerStart" or event == "DBM_TimerUpdate" then
              if extendTimer ~= 0 then
                if WeakAuras.DBMTimerMatches(id, triggerId, triggerText, triggerTextOperator, triggerSpellId, triggerDbmType, triggerCount) then
                  local bar = WeakAuras.GetDBMTimerById(id)
                  WeakAuras.ScheduleDbmCheck(bar.expirationTime + extendTimer)
                end
              end
            end
            local bar = WeakAuras.GetDBMTimer(triggerId, triggerText, triggerTextOperator, triggerSpellId, extendTimer, triggerDbmType, triggerCount)
            if bar then
              if extendTimer == 0
                or not (state and state.show)
                or (state and state.show and state.expirationTime > (bar.expirationTime + extendTimer))
              then
                copyOrSchedule(bar, cloneId)
              end
            else
              if state and state.show then
                local bar_remainingTime = GetTime() - state.expirationTime + (state.extend or 0)
                if state.extend == 0 or bar_remainingTime > 0.2 then
                  state.show = false
                  state.changed = true
                end
              end
            end
          end
          return true
        end
        ]=]

      return ret:format(
        trigger.use_id and trigger.id or "",
        trigger.use_spellId and trigger.spellId or "",
        trigger.use_message and trigger.message or "",
        trigger.use_message and trigger.message_operator or "",
        trigger.use_cloneId and "true" or "false",
        trigger.use_extend and tonumber(trigger.extend or 0) or 0,
        trigger.use_remaining and "true" or "false",
        trigger.remaining or 0,
        trigger.use_count and trigger.count or "",
        trigger.use_dbmType and trigger.dbmType or "nil",
        trigger.remaining_operator or "<"
      )
    end,
    statesParameter = "full",
    args = {
      {
        name = "id",
        display = L["Timer Id"],
        type = "string",
      },
      {
        name = "spellId",
        display = L["Spell Id"],
        type = "string",
        store = true,
        conditionType = "string"
      },
      {
        name = "message",
        display = L["Message"],
        type = "longstring",
        store = true,
        conditionType = "string"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
      },
      {
        name = "extend",
        display = L["Offset Timer"],
        type = "string",
      },
      {
        name = "count",
        display = L["Count"],
        desc = L["Only if DBM shows it on it's bar"],
        type = "string",
        conditionType = "string",
      },
      {
        name = "dbmType",
        display = L["Type"],
        type = "select",
        values = "dbm_types",
        conditionType = "select",
        test = "true"
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle"
      }
    },
    automaticrequired = true,
    automaticAutoHide = false
  },
  -- BigWigs
  ["BigWigs Message"] = {
    type = "event",
    events = {},
    internal_events = {
      "BigWigs_Message"
    },
    name = L["BigWigs Message"],
    init = function(trigger)
      WeakAuras.RegisterBigWigsCallback("BigWigs_Message");
      local ret = "local use_cloneId = %s;"
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    statesParameter = "all",
    canHaveAuto = true,
    args = {
      {
        name = "addon",
        init = "arg",
        display = L["BigWigs Addon"],
        type = "string"
      },
      {
        name = "spellId",
        init = "arg",
        display = L["Spell Id"],
        type = "longstring"
      },
      {
        name = "text",
        init = "arg",
        display = L["Message"],
        type = "longstring",
        store = true,
        conditionType = "string"
      },
      {
        name = "name",
        init = "text",
        hidden = true,
        test = "true",
        store = true
      },
      {}, -- Importance, might be useful
      {
        name = "icon",
        init = "arg",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''"
      },
    },
    timedrequired = true
  },
  ["BigWigs Timer"] = {
    type = "status",
    events = {},
    internal_events = {
      "BigWigs_StartBar", "BigWigs_StopBar", "BigWigs_Timer_Update",
    },
    force_events = "BigWigs_Timer_Force",
    name = L["BigWigs Timer"],
    canHaveAuto = true,
    canHaveDuration = "timed",
    triggerFunction = function(trigger)
      WeakAuras.RegisterBigWigsTimer()
      local ret = [=[
        return function(states, event, id)
          local triggerSpellId = %q
          local triggerText = %q
          local triggerTextOperator = %q
          local useClone = %s
          local extendTimer = %s
          local triggerUseRemaining = %s
          local triggerRemaining = %s
          local triggerEmphasized = %s
          local triggerCount = %q
          local triggerCast = %s
          local cloneId = useClone and id or ""
          local state = states[cloneId]

          function copyOrSchedule(bar, cloneId)
            if triggerUseRemaining then
              local remainingTime = bar.expirationTime - GetTime() + extendTimer
              if remainingTime %s triggerRemaining then
                WeakAuras.CopyBigWigsTimerToState(bar, states, cloneId, extendTimer)
              else
                local state = states[cloneId]
                if state and state.show then
                  state.show = false
                  state.changed = true
                end
              end
              if remainingTime >= triggerRemaining then
                WeakAuras.ScheduleBigWigsCheck(bar.expirationTime - triggerRemaining + extendTimer)
              end
            else
              WeakAuras.CopyBigWigsTimerToState(bar, states, cloneId, extendTimer)
            end
          end

          if useClone then
            if event == "BigWigs_StartBar" then
              if WeakAuras.BigWigsTimerMatches(id, triggerText, triggerTextOperator, triggerSpellId, triggerEmphasized, triggerCount, triggerCast) then
                local bar = WeakAuras.GetBigWigsTimerById(id)
                if bar then
                  copyOrSchedule(bar, cloneId)
                end
              end
            elseif event == "BigWigs_StopBar" and state then
              local bar_remainingTime = GetTime() - state.expirationTime + (state.extend or 0)
              if state.extend == 0 or bar_remainingTime > 0.2 then
                state.show = false
                state.changed = true
              end
            elseif event == "BigWigs_Timer_Update" then
              for id, bar in pairs(WeakAuras.GetAllBigWigsTimers()) do
                if WeakAuras.BigWigsTimerMatches(id, triggerText, triggerTextOperator, triggerSpellId, triggerEmphasized, triggerCount, triggerCast) then
                  copyOrSchedule(bar, id)
                end
              end
            elseif event == "BigWigs_Timer_Force" then
              wipe(states)
              for id, bar in pairs(WeakAuras.GetAllBigWigsTimers()) do
                if WeakAuras.BigWigsTimerMatches(id, triggerText, triggerTextOperator, triggerSpellId, triggerEmphasized, triggerCount, triggerCast) then
                  copyOrSchedule(bar, id)
                end
              end
            end
          else
            if event == "BigWigs_StartBar" then
              if extendTimer ~= 0 then
                if WeakAuras.BigWigsTimerMatches(id, triggerText, triggerTextOperator, triggerSpellId, triggerEmphasized, triggerCount, triggerCast) then
                  local bar = WeakAuras.GetBigWigsTimerById(id)
                  WeakAuras.ScheduleBigWigsCheck(bar.expirationTime + extendTimer)
                end
              end
            end
            local bar = WeakAuras.GetBigWigsTimer(triggerText, triggerTextOperator, triggerSpellId, extendTimer, triggerEmphasized, triggerCount, triggerCast)
            if bar then
              if extendTimer == 0
                or not (state and state.show)
                or (state and state.show and state.expirationTime > (bar.expirationTime + extendTimer))
              then
                copyOrSchedule(bar, cloneId)
              end
            else
              if state and state.show then
                local bar_remainingTime = GetTime() - state.expirationTime + (state.extend or 0)
                if state.extend == 0 or bar_remainingTime > 0.2 then
                  state.show = false
                  state.changed = true
                end
              end
            end
          end
          return true
        end
      ]=]
      return ret:format(
        trigger.use_spellId and trigger.spellId or "",
        trigger.use_text and trigger.text or "",
        trigger.use_text and trigger.text_operator or "",
        trigger.use_cloneId and "true" or "false",
        trigger.use_extend and tonumber(trigger.extend or 0) or 0,
        trigger.use_remaining and "true" or "false",
        trigger.remaining or 0,
        trigger.use_emphasized == nil and "nil" or trigger.use_emphasized and "true" or "false",
        trigger.use_count and trigger.count or "",
        trigger.use_cast == nil and "nil" or trigger.use_cast and "true" or "false",
        trigger.remaining_operator or "<"
      )
    end,
    statesParameter = "full",
    args = {
      {
        name = "spellId",
        display = L["Spell Id"],
        type = "string",
        conditionType = "string",
      },
      {
        name = "text",
        display = L["Message"],
        type = "longstring",
        store = true,
        conditionType = "string"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
      },
      {
        name = "extend",
        display = L["Offset Timer"],
        type = "string",
      },
      {
        name = "count",
        display = L["Count"],
        desc = L["Only if BigWigs shows it on it's bar"],
        type = "string",
        conditionType = "string",
      },
      {
        name = "emphasized",
        display = L["Emphasized"],
        type = "tristate",
        desc = L["Emphasized option checked in BigWigs's spell options"],
        test = "true",
        init = "false",
        conditionType = "bool"
      },
      {
        name = "cast",
        display = L["Cast Bar"],
        desc = L["Filter messages with format <message>"],
        type = "tristate",
        test = "true",
        init = "false",
        conditionType = "bool"
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "false"
      },
    },
    automaticrequired = true,
  },
  ["Global Cooldown"] = {
    type = "status",
    events = {},
    internal_events = {
      "GCD_START",
      "GCD_CHANGE",
      "GCD_END",
      "GCD_UPDATE",
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    name = L["Global Cooldown"],
    loadFunc = function(trigger)
      WeakAuras.WatchGCD();
    end,
    init = function(trigger)
      local ret = [[
        local inverse = %s;
        local onGCD = WeakAuras.GetGCDInfo();
        local hasSpellName = WeakAuras.GcdSpellName();
      ]];
      return ret:format(trigger.use_inverse and "true" or "false");
    end,
    args = {
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "(inverse and onGCD == 0) or (not inverse and onGCD > 0 and hasSpellName)"
      }
    },
    durationFunc = function(trigger)
      local duration, expirationTime = WeakAuras.GetGCDInfo();
      return duration, expirationTime;
    end,
    nameFunc = function(trigger)
      local _, _, name = WeakAuras.GetGCDInfo();
      return name;
    end,
    iconFunc = function(trigger)
      local _, _, _, icon = WeakAuras.GetGCDInfo();
      return icon;
    end,
    hasSpellID = true,
    automaticrequired = true,
    automaticAutoHide = false
  },
  ["Swing Timer"] = {
    type = "status",
    events = {},
    internal_events = {
      "SWING_TIMER_START",
      "SWING_TIMER_CHANGE",
      "SWING_TIMER_END"
    },
    name = L["Swing Timer"],
    loadFunc = function(trigger)
      WeakAuras.InitSwingTimer();
    end,
    init = function(trigger)
      trigger.hand = trigger.hand or "main";
      local ret = [=[
        local inverse = %s;
        local hand = %q;
        local duration, expirationTime = WeakAuras.GetSwingTimerInfo(hand);
      ]=];
      return ret:format((trigger.use_inverse and "true" or "false"), trigger.hand);
    end,
    args = {
      {
        name = "hand",
        required = true,
        display = L["Weapon"],
        type = "select",
        values = "swing_types",
        test = "true"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "(inverse and duration == 0) or (not inverse and duration > 0)"
      }
    },
    durationFunc = function(trigger)
      local duration, expirationTime = WeakAuras.GetSwingTimerInfo(trigger.hand);
      return duration, expirationTime;
    end,
    nameFunc = function(trigger)
      local _, _, name = WeakAuras.GetSwingTimerInfo(trigger.hand);
      return name;
    end,
    iconFunc = function(trigger)
      local _, _, _, icon = WeakAuras.GetSwingTimerInfo(trigger.hand);
      return icon;
    end,
    automaticrequired = true
  },
  ["Action Usable"] = {
    type = "status",
    events = {
      ["events"] = {
        "SPELL_UPDATE_USABLE",
        "PLAYER_TARGET_CHANGED",
        "RUNE_POWER_UPDATE",
        "RUNE_TYPE_UPDATE",
      },
      ["unit_events"] = {
        ["player"] = { "UNIT_POWER", "UNIT_ENERGY", "UNIT_MANA", "UNIT_RAGE" }
      }
    },
    internal_events = {
      "SPELL_COOLDOWN_CHANGED",
    },
    force_events = "SPELL_UPDATE_USABLE",
    name = L["Action Usable"],
    statesParameter = "one",
    loadFunc = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      trigger.realSpellName = spellName; -- Cache
      WeakAuras.WatchSpellCooldown(spellName);
    end,
    init = function(trigger)
      trigger.spellName = trigger.spellName or 0;
      local spellName;
      if (trigger.use_exact_spellName) then
        spellName = trigger.spellName;
      else
        spellName = type(trigger.spellName) == "number" and GetSpellInfo(trigger.spellName) or trigger.spellName;
      end
      trigger.realSpellName = spellName; -- Cache
      local ret = [=[
        local spellName = %s
        local startTime, duration = WeakAuras.GetSpellCooldown(spellName);
        startTime = startTime or 0
        duration = duration or 0
        local ready = startTime == 0
        local active = IsUsableSpell(spellName) and ready
      ]=]
      if(trigger.use_targetRequired) then
        ret = ret.."active = active and WeakAuras.IsSpellInRange(spellName or '', 'target')\n";
      end
      if(trigger.use_inverse) then
        ret = ret.."active = not active\n";
      end

      if (type(spellName) == "string") then
        spellName = "[[" .. spellName .. "]]";
      end

      return ret:format(spellName)
    end,
    args = {
      {
        name = "spellName",
        display = L["Spell"],
        required = true,
        type = "spell",
        test = "true",
        store = true,
        conditionType = "string"
      },
      -- This parameter uses the IsSpellInRange API function, but it does not check spell range at all
      -- IsSpellInRange returns nil for invalid targets, 0 for out of range, 1 for in range (0 and 1 are both "positive" values)
      {
        name = "targetRequired",
        display = L["Require Valid Target"],
        type = "toggle",
        test = "true"
      },
      {
        name = "charges",
        display = L["Charges"],
        type = "number",
        enable = function(trigger) return not(trigger.use_inverse) end,
        store = true,
        conditionType = "number"
      },
      {
        name = "spellCount",
        display = L["Spell Count"],
        type = "number",
        enable = function(trigger) return not(trigger.use_inverse) end,
        store = true,
        conditionType = "number"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        reloadOptions = true
      },
      {
        name = "spellInRange",
        display = L["Spell in Range"],
        hidden = true,
        test = "true",
        conditionType = "bool",
        conditionTest = function(state, needle)
          return state and state.show and (UnitExists('target') and state.spellName and WeakAuras.IsSpellInRange(state.spellName, 'target') == needle)
        end,
        conditionEvents = {
          "PLAYER_TARGET_CHANGED",
          "WA_SPELL_RANGECHECK",
        }
      },
      {
        hidden = true,
        test = "active"
      }
    },
    nameFunc = function(trigger)
      local name = GetSpellInfo(trigger.realSpellName or 0);
      if(name) then
        return name;
      end
      name = GetSpellInfo(trigger.spellName or 0);
      if (name) then
        return name;
      end
      return "Invalid";
    end,
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.realSpellName or 0);
      if (not icon) then
        icon = select(3, GetSpellInfo(trigger.spellName or 0));
      end
      return icon;
    end,
    stacksFunc = function(trigger)
      local spellCount = WeakAuras.GetSpellCharges(trigger.realSpellName);
      if spellCount and spellCount > 0 then
        return spellCount
      end
    end,
    hasSpellID = true,
    automaticrequired = true
  },
  ["Talent Known"] = {
    type = "status",
    events = function()
      return {
        ["events"] = {"PLAYER_TALENT_UPDATE", "SPELL_UPDATE_USABLE"}
      }
    end,
    force_events = "PLAYER_TALENT_UPDATE",
    name = L["Talent Selected"],
    init = function(trigger)
      local inverse = trigger.use_inverse;
      if (trigger.use_talent) then
        -- Single selection
        local index = trigger.talent and trigger.talent.single;
        local tier = index and ceil(index / MAX_NUM_TALENTS)
        local column = index and ((index - 1) % MAX_NUM_TALENTS + 1)

        local ret = [[
          local tier = %s;
          local column = %s;
          local active, _, rank
          _, _, _, _, rank  = GetTalentInfo(tier, column)
          active = rank > 0
        ]]
        if (inverse) then
          ret = ret .. [[
          active = not (active);
          ]]
        end
        return ret:format(tier or 0, column or 0)
      elseif (trigger.use_talent == false) then
        if (trigger.talent.multi) then
          local ret = [[
            local tier
            local column
            local active = false;
            local activeIcon;
            local activeName;
          ]]
          for index in pairs(trigger.talent.multi) do
            local tier = index and ceil(index / MAX_NUM_TALENTS)
            local column = index and ((index - 1) % MAX_NUM_TALENTS + 1)
            local ret2 = [[
              if (not active) then
                tier = %s
                column = %s
                local name, icon, _, _, rank  = GetTalentInfo(tier, column)
                if rank > 0 then
                  active = true;
                  activeName = name;
                  activeIcon = icon;
                end
              end
            ]]
            ret = ret .. ret2:format(tier, column);
          end
          if (inverse) then
            ret = ret .. [[
            active = not (active);
            ]]
          end
          return ret;
        end
      end
      return "";
    end,
    args = {
      {
        name = "talent",
        display = L["Talent selected"],
        type = "multiselect",
        values = function()
          local class = select(2, UnitClass("player"));
          if WeakAuras.talent_types_specific[class] then
            return WeakAuras.talent_types_specific[class];
          else
            return WeakAuras.talent_types;
          end
        end,
        test = "active",
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        name = "icon",
        init = "activeIcon",
        store = "true",
        test = "true"
      },
      {
        hidden = true,
        name = "name",
        init = "activeName",
        store = "true",
        test = "true"
      },
    },
    automaticrequired = true,
    statesParameter = "one",
    canHaveAuto = true
  },
  ["Totem"] = {
    type = "status",
    events = {
      ["events"] = {
        "PLAYER_TOTEM_UPDATE",
        "PLAYER_ENTERING_WORLD"
      }
    },
    internal_events = {
      "COOLDOWN_REMAINING_CHECK",
    },
    force_events = "PLAYER_ENTERING_WORLD",
    name = L["Totem"],
    statesParameter = "full",
    canHaveAuto = true,
    canHaveDuration = "timed",
    triggerFunction = function(trigger)
      local ret = [[return
      function (states)
        local totemType = %s;
        local triggerTotemName = %q
        local triggerTotemPattern = %q
        local triggerTotemPatternOperator = %q
        local clone = %s
        local inverse = %s
        local remainingCheck = %s

        local function checkActive(remaining)
          return remaining %s remainingCheck;
        end

        if (totemType) then -- Check a specific totem slot
          local _, totemName, startTime, duration, icon = GetTotemInfo(totemType);
          active = (startTime and startTime ~= 0);

          if not WeakAuras.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator) then
            active = false;
          end

          if (inverse) then
            active = not active;
            if (triggerTotemName) then
              icon = select(3, GetSpellInfo(triggerTotemName));
            end
          elseif (active and remainingCheck) then
            local expirationTime = startTime and (startTime + duration) or 0;
            local remainingTime = expirationTime - GetTime()
            if (remainingTime >= remainingCheck) then
              WeakAuras.ScheduleScan(expirationTime - remainingCheck);
            end
            active = checkActive(remainingTime);
          end
          states[""] = states[""] or {}
          local state = states[""];
          state.show = active;
          state.changed = true;
          if (active) then
            state.name = totemName;
            state.totemName = totemName;
            state.progressType = "timed";
            state.duration = duration;
            state.expirationTime = startTime and (startTime + duration);
            state.icon = icon;
          end
        elseif inverse then -- inverse without a specific slot
          local found = false;
          for i = 1, 4 do
            local _, totemName, startTime, duration, icon = GetTotemInfo(i);
            if ((startTime and startTime ~= 0) and
                WeakAuras.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator)
            ) then
              found = true;
            end
          end
          local cloneId = "";
          states[cloneId] = states[cloneId] or {};
          local state = states[cloneId];
          state.show = not found;
          state.changed = true;
          state.name = triggerTotemName;
          state.totemName = triggerTotemName;
          if (triggerTotemName) then
            state.icon = select(3, GetSpellInfo(triggerTotemName));
          end
        else -- check all slots
          for i = 1, 4 do
            local _, totemName, startTime, duration, icon = GetTotemInfo(i);
            active = (startTime and startTime ~= 0);

            if not WeakAuras.CheckTotemName(totemName, triggerTotemName, triggerTotemPattern, triggerTotemPatternOperator) then
              active = false;
            end
            if (active and remainingCheck) then
              local expirationTime = startTime and (startTime + duration) or 0;
              local remainingTime = expirationTime - GetTime()
              if (remainingTime >= remainingCheck) then
                WeakAuras.ScheduleScan(expirationTime - remainingCheck);
              end
              active = checkActive(remainingTime);
            end

            local cloneId = clone and tostring(i) or "";
            states[cloneId] = states[cloneId] or {};
            local state = states[cloneId];
            state.show = active;
            state.changed = true;
            if (active) then
              state.name = totemName;
              state.totemName = totemName;
              state.progressType = "timed";
              state.duration = duration;
              state.expirationTime = startTime and (startTime + duration);
              state.icon = icon;
            end
            if (active and not clone) then
              break;
            end
          end
        end
        return true;
      end
      ]];
      local totemName = tonumber(trigger.totemName) and GetSpellInfo(tonumber(trigger.totemName)) or trigger.totemName;
      ret = ret:format(trigger.use_totemType and tonumber(trigger.totemType) or "nil",
        trigger.use_totemName and totemName or "",
        trigger.use_totemNamePattern and trigger.totemNamePattern or "",
        trigger.use_totemNamePattern and trigger.totemNamePattern_operator or "",
        trigger.use_clones and "true" or "false",
        trigger.use_inverse and "true" or "false",
        trigger.use_remaining and trigger.remaining or "nil",
        trigger.use_remaining and trigger.remaining_operator or "<");
      return ret;
    end,
    args = {
      {
        name = "totemType",
        display = L["Totem Number"],
        type = "select",
        values = "totem_types"
      },
      {
        name = "totemName",
        display = L["Totem Name"],
        type = "string",
        conditionType = "string",
        store = true
      },
      {
        name = "totemNamePattern",
        display = L["Totem Name Pattern Match"],
        type = "longstring",
      },
      {
        name = "clones",
        display = L["Clone per Match"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return not trigger.use_totemType end,
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return not(trigger.use_inverse) end
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return (trigger.use_totemName or trigger.use_totemNamePattern) and not trigger.use_clones end
      }
    },
    automaticrequired = true
  },
  ["Item Count"] = {
    type = "status",
    events = {
      ["events"] = {
        "BAG_UPDATE",
        "BAG_UPDATE_COOLDOWN",
        "PLAYER_ENTERING_WORLD"
      }
    },
    force_events = "BAG_UPDATE",
    name = L["Item Count"],
    init = function(trigger)
      trigger.itemName = trigger.itemName or 0;
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or "[["..trigger.itemName.."]]";
      local ret = [[
        local count = GetItemCount(%s, %s);
      ]];
      return ret:format(itemName, trigger.use_includeBank and "true" or "nil");
    end,
    args = {
      {
        name = "itemName",
        required = true,
        display = L["Item"],
        type = "item",
        test = "true"
      },
      {
        name = "includeBank",
        display = L["Include Bank"],
        type = "toggle",
        test = "true"
      },
      {
        name = "count",
        display = L["Item Count"],
        type = "number"
      }
    },
    durationFunc = function(trigger)
      local count = GetItemCount(trigger.itemName, trigger.use_includeBank);
      return count, 0, true;
    end,
    stacksFunc = function(trigger)
      local count = GetItemCount(trigger.itemName, trigger.use_includeBank);
      return count, 0, true;
    end,
    nameFunc = function(trigger)
      return trigger.itemName;
    end,
    iconFunc = function(trigger)
      return GetItemIcon(trigger.itemName);
    end,
    hasItemID = true,
    automaticrequired = true
  },
  ["Stance/Form/Aura"] = {
    type = "status",
    events = {
      ["events"] = {
        "UPDATE_SHAPESHIFT_FORM",
        "UPDATE_SHAPESHIFT_COOLDOWN"
      }
    },
    internal_events = { "WA_DELAYED_PLAYER_ENTERING_WORLD" },
    force_events = "WA_DELAYED_PLAYER_ENTERING_WORLD",
    name = L["Stance/Form/Aura"],
    init = function(trigger)
      local inverse = trigger.use_inverse;
      local ret = [[
        local form = GetShapeshiftForm()
        local active = false
      ]]
      if trigger.use_form and trigger.form and trigger.form.single then
        -- Single selection
        ret = ret .. [[
          local trigger_form = %d
          active = form == trigger_form
        ]]
        if inverse then
          ret = ret .. [[
            active = not active
          ]]
        end
        return ret:format(trigger.form.single)
      elseif trigger.use_form == false and trigger.form and trigger.form.multi then
        for index in pairs(trigger.form.multi) do
          local ret2 = [[
            if not active then
              local index = %d
              active = form == index
            end
          ]]
          ret = ret .. ret2:format(index)
        end
        if inverse then
          ret = ret .. [[
            active = not active
          ]]
        end
        return ret
      elseif trigger.use_form == nil then
        ret = ret .. [[
          active = true
        ]]
        return ret
      end
    end,
    statesParameter = "one",
    args = {
      {
        name = "form",
        display = L["Form"],
        type = "multiselect",
        values = "form_types",
        test = "active",
        store = true,
        conditionType = "select"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return type(trigger.use_form) == "boolean" end
      },
    },
    nameFunc = function(trigger)
      local _, class = UnitClass("player");
      local name
      if(class == trigger.class) then
        local form = GetShapeshiftForm();
        if form > 0 then
          local _, name = GetShapeshiftFormInfo(form);
        else
          name = "Humanoid";
        end
        return name;
      else
        local types = WeakAuras[class:lower().."_form_types"];
        if(types) then
          return types[GetShapeshiftForm()];
        end
      end
    end,
    iconFunc = function(trigger)
      local icon = "Interface\\Icons\\Spell_Nature_WispSplode"
      local form = GetShapeshiftForm()
      if form and form > 0 then
        icon = GetShapeshiftFormInfo(form);
      end
      return icon or "Interface\\Icons\\Spell_Nature_WispSplode"
    end,
    automaticrequired = true
  },
  ["Weapon Enchant"] = {
    type = "status",
    events = {},
    internal_events = {
      "TENCH_UPDATE",
    },
    force_events = "TENCH_UPDATE",
    name = L["Weapon Enchant"],
    init = function(trigger)
      WeakAuras.TenchInit();

      local ret = [[
        local triggerWeaponType = %q
        local triggerName = %q
        local triggerStack = %s
        local triggerRemaining = %s
        local triggerShowOn = %q
        local _, expirationTime, duration, name, stack

        if triggerWeaponType == "main" then
          expirationTime, duration, name, shortenedName, _, stack = WeakAuras.GetMHTenchInfo()
        else
          expirationTime, duration, name, shortenedName, _, stack = WeakAuras.GetOHTenchInfo()
        end

        local remaining = expirationTime and expirationTime - GetTime()

        local nameCheck = triggerName == "" or name and triggerName == name or shortenedName and triggerName == shortenedName
        local stackCheck = not triggerStack or stack and stack %s triggerStack
        local remainingCheck = not triggerRemaining or remaining and remaining %s triggerRemaining
        local found = expirationTime and nameCheck and stackCheck and remainingCheck

        if(triggerRemaining and remaining and remaining >= triggerRemaining and remaining > 0) then
          WeakAuras.ScheduleScan(expirationTime - triggerRemaining, "TENCH_UPDATE");
        end
      ]];

      return ret:format(trigger.weapon or "main",
      trigger.use_enchant and trigger.enchant or "",
      trigger.use_stack and tonumber(trigger.stack or 0) or "nil",
      trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
      trigger.showOn or "showOnActive",
      trigger.stack_operator or "<",
      trigger.remaining_operator or "<")
    end,
    args = {
      {
        name = "weapon",
        display = L["Weapon"],
        type = "select",
        values = "weapon_types",
        test = "true",
        default = "main",
        required = true
      },
      {
        name = "enchant",
        display = L["Weapon Enchant"],
        desc = L["Enchant Name"],
        type = "string",
        test = "true"
      },
      {
        name = "stack",
        display = L["Stack Count"],
        type = "number",
        test = "true",
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        test = "true"
      },
      {
        name = "showOn",
        display = L["Show On"],
        type = "select",
        values = "weapon_enchant_types",
        test = 'true',
        default = "showOnActive",
        required = true
      },
      {
        hidden = true,
        test = "(triggerShowOn == 'showOnActive' and found) " ..
        "or (triggerShowOn == 'showOnMissing' and not found) "  ..
        "or (triggerShowOn == 'showAlways')"
      }
    },
    durationFunc = function(trigger)
      local expirationTime, duration;
      if(trigger.weapon == "main") then
        expirationTime, duration = WeakAuras.GetMHTenchInfo();
      elseif(trigger.weapon == "off") then
        expirationTime, duration = WeakAuras.GetOHTenchInfo();
      end
      if(expirationTime) then
        return duration, expirationTime;
      else
        return 0, math.huge;
      end
    end,
    nameFunc = function(trigger)
      local _, name;
      if(trigger.weapon == "main") then
        _, _, name = WeakAuras.GetMHTenchInfo();
      elseif(trigger.weapon == "off") then
        _, _, name = WeakAuras.GetOHTenchInfo();
      end
      return name;
    end,
    iconFunc = function(trigger)
      local _, icon;
      if(trigger.weapon == "main") then
        _, _, _, _, icon = WeakAuras.GetMHTenchInfo();
      elseif(trigger.weapon == "off") then
        _, _, _, _, icon = WeakAuras.GetOHTenchInfo();
      end
      return icon;
    end,
    stacksFunc = function(trigger)
      local _, charges;
      if(trigger.weapon == "main") then
        _, _, _, _, _, charges = WeakAuras.GetMHTenchInfo();
      elseif(trigger.weapon == "off") then
        _, _, _, _, _, charges = WeakAuras.GetOHTenchInfo();
      end
      return charges;
    end,
    automaticrequired = true
  },
  ["Chat Message"] = {
    type = "event",
    events = {
      ["events"] = {
        "CHAT_MSG_BATTLEGROUND",
        "CHAT_MSG_BATTLEGROUND_LEADER",
        "CHAT_MSG_BG_SYSTEM_ALLIANCE",
        "CHAT_MSG_BG_SYSTEM_HORDE",
        "CHAT_MSG_BG_SYSTEM_NEUTRAL",
        "CHAT_MSG_BN_WHISPER",
        "CHAT_MSG_CHANNEL",
        "CHAT_MSG_EMOTE",
        "CHAT_MSG_GUILD",
        "CHAT_MSG_MONSTER_EMOTE",
        "CHAT_MSG_MONSTER_PARTY",
        "CHAT_MSG_MONSTER_SAY",
        "CHAT_MSG_MONSTER_WHISPER",
        "CHAT_MSG_MONSTER_YELL",
        "CHAT_MSG_OFFICER",
        "CHAT_MSG_PARTY",
        "CHAT_MSG_PARTY_LEADER",
        "CHAT_MSG_RAID",
        "CHAT_MSG_RAID_LEADER",
        "CHAT_MSG_RAID_BOSS_EMOTE",
        "CHAT_MSG_RAID_BOSS_WHISPER",
        "CHAT_MSG_RAID_WARNING",
        "CHAT_MSG_SAY",
        "CHAT_MSG_WHISPER",
        "CHAT_MSG_YELL",
        "CHAT_MSG_SYSTEM",
        "CHAT_MSG_TEXT_EMOTE"
      }
    },
    name = L["Chat Message"],
    init = function(trigger)
      local ret = [[
        if (event:find('LEADER')) then
          event = event:sub(1, -8);
        end
        if (event == 'CHAT_MSG_TEXT_EMOTE') then
          event = 'CHAT_MSG_EMOTE';
        end
         local use_cloneId = %s;
      ]];
      return ret:format(trigger.use_cloneId and "true" or "false");
    end,
    statesParameter = "all",
    args = {
      {
        name = "messageType",
        display = L["Message Type"],
        type = "select",
        values = "chat_message_types",
        test = "event == %q",
        control = "WeakAurasSortedDropdown"
      },
      {
        name = "message",
        display = L["Message"],
        init = "arg",
        type = "longstring",
        store = true,
        conditionType = "string",
      },
      {
        name = "sourceName",
        display = L["Source Name"],
        init = "arg",
        type = "string",
        store = true,
        conditionType = "string",
      },
      { -- language Name
      },
      { -- Channel Name
      },
      {
        name = "destName",
        display = L["Destination Name"],
        init = "arg",
        type = "string",
        store = true,
        conditionType = "string",
      },
      {
        name = "cloneId",
        display = L["Clone per Event"],
        type = "toggle",
        test = "true",
        init = "use_cloneId and WeakAuras.GetUniqueCloneId() or ''",
        reloadOptions = true
      },
    },
    timedrequired = function(trigger)
      return trigger.use_cloneId
    end
  },
  ["Ready Check"] = {
    type = "event",
    events = {
      ["events"] = {"READY_CHECK"}
    },
    name = L["Ready Check"],
    args = {},
    timedrequired = true
  },
  ["Combat Events"] = {
    type = "event",
    events = {
      ["events"] = {
        "PLAYER_REGEN_ENABLED",
        "PLAYER_REGEN_DISABLED"
      }
    },
    name = L["Entering/Leaving Combat"],
    args = {
      {
        name = "eventtype",
        required = true,
        display = L["Type"],
        type = "select",
        values = "combat_event_type",
        test = "event == %q"
      }
    },
    timedrequired = true
  },
  ["Death Knight Rune"] = {
    type = "status",
    events = {
      ["events"] = {
        "RUNE_POWER_UPDATE",
        "RUNE_TYPE_UPDATE"
      }
    },
    internal_events = {
      "RUNE_COOLDOWN_READY",
      "RUNE_COOLDOWN_CHANGED",
      "RUNE_COOLDOWN_STARTED",
      "COOLDOWN_REMAINING_CHECK",
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "RUNE_COOLDOWN_FORCE",
    name = L["Death Knight Rune"],
    loadFunc = function(trigger)
      trigger.rune = trigger.rune or 0;
      WeakAuras.WatchRuneCooldown(trigger.rune);
    end,
    init = function(trigger)
      trigger.rune = trigger.rune or 0;
      WeakAuras.WatchRuneCooldown(trigger.rune);
      local ret = [[
        local rune = %s;
        local startTime, duration = WeakAuras.GetRuneCooldown(rune);
        local inverse = %s;
        local death = %s;

        local numBloodRunes = 0;
        local numUnholyRunes = 0;
        local numFrostRunes = 0;
        local numDeathRunes = 0;
        for index = 1, 6 do
          local startTime = select(1, GetRuneCooldown(index));
          if startTime == 0 then
            if GetRuneType(index) == 1 then
              numBloodRunes = numBloodRunes  + 1;
            elseif GetRuneType(index) == 2 then
              numUnholyRunes = numUnholyRunes + 1;
            elseif GetRuneType(index) == 3 then
              numFrostRunes = numFrostRunes  + 1;
            elseif GetRuneType(index) == 4 then
              numDeathRunes = numDeathRunes  + 1;
            end
          end
        end

        if %s then
          numBloodRunes  = numBloodRunes  + numDeathRunes;
          numUnholyRunes = numUnholyRunes + numDeathRunes;
          numFrostRunes  = numFrostRunes  + numDeathRunes;
        end
      ]];
      if(trigger.use_remaining and not trigger.use_inverse) then
        local ret2 = [[
          local expirationTime = startTime + duration
          local remaining = expirationTime - GetTime();
          local remainingCheck = %s;
          if(remaining >= remainingCheck and remaining > 0) then
            WeakAuras.ScheduleScan(expirationTime - remainingCheck);
          end
        ]];
        ret = ret..ret2:format(tonumber(trigger.remaining) or 0);
      end
      return ret:format(trigger.rune, (trigger.use_inverse and "true" or "false"), (trigger.use_deathRune == true and "true" or trigger.use_deathRune == false and "false" or "nil"), (trigger.use_includeDeath and "true" or "false"));
    end,
    args = {
      {
        name = "rune",
        display = L["Rune"],
        type = "select",
        values = "rune_specific_types",
        test = [[
          ((inverse and startTime == 0) or (not inverse and startTime > 0))
          and
          ((death == nil) or (death == true and GetRuneType(rune) == 4) or (death == false and GetRuneType(rune) ~= 4))
        ]],
        enable = function(trigger) return not trigger.use_bloodRunes and not trigger.use_unholyRunes and not trigger.use_frostRunes end,
        reloadOptions = true
      },
      {
        name = "deathRune",
        display = L["Death Rune"],
        type = "tristate",
        test = "true",
        enable = function(trigger) return trigger.use_rune end
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return trigger.use_rune and not(trigger.use_inverse) end
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return trigger.use_rune end
      },
      {
        name = "bloodRunes",
        display = L["Blood Runes"],
        type = "number",
        init = "numBloodRunes",
        enable = function(trigger) return not trigger.use_rune end
      },
      {
        name = "unholyRunes",
        display = L["Unholy Runes"],
        type = "number",
        init = "numUnholyRunes",
        enable = function(trigger) return not trigger.use_rune end
      },
      {
        name = "frostRunes",
        display = L["Frost Runes"],
        type = "number",
        init = "numFrostRunes",
        enable = function(trigger) return not trigger.use_rune end
      },
      {
        name = "includeDeath",
        display = L["Include Death Runes"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return trigger.use_bloodRunes or trigger.use_unholyRunes or trigger.use_frostRunes end
      },
    },
    durationFunc = function(trigger)
      if trigger.use_rune then
        local startTime, duration
        if not(trigger.use_inverse) then
          startTime, duration = WeakAuras.GetRuneCooldown(trigger.rune);
        end
        startTime = startTime or 0;
        duration = duration or 0;
        return duration, startTime + duration;
      else
        return 1, 0;
      end
    end,
    nameFunc = function(trigger)
      local runeNames = {
        [1] = L["Blood"],
        [2] = L["Unholy"],
        [3] = L["Frost"],
        [4] = L["Death"]
      };
      return runeNames[GetRuneType(trigger.rune)];
    end,
    iconFunc = function(trigger)
      local runeIcons = {
        [1] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
        [2] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
        [3] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
        [4] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death"
      };
      return runeIcons[GetRuneType(trigger.rune)];
    end,
    automaticrequired = true,
  },
  ["Item Equipped"] = {
    type = "status",
    events = {
      ["events"] = {
        "UNIT_INVENTORY_CHANGED",
        "PLAYER_EQUIPMENT_CHANGED",
      }
    },
    internal_events = { "WA_DELAYED_PLAYER_ENTERING_WORLD", },
    force_events = "UNIT_INVENTORY_CHANGED",
    name = L["Item Equipped"],
    init = function(trigger)
      trigger.itemName = trigger.itemName or 0;
      local itemName = type(trigger.itemName) == "number" and trigger.itemName or "[[" .. trigger.itemName .. "]]";

      local ret = [[
        local inverse = %s;
        local equipped = IsEquippedItem(%s);
      ]];

      return ret:format(trigger.use_inverse and "true" or "false", itemName);
    end,
    args = {
      {
        name = "itemName",
        display = L["Item"],
        type = "item",
        required = true,
        test = "true"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "(inverse and not equipped) or (equipped and not inverse)"
      }
    },
    nameFunc = function(trigger)
      if not trigger.use_inverse then
        local name = GetItemInfo(trigger.itemName);
        return name;
      else
        return nil;
      end
    end,
    iconFunc = function(trigger)
      if not trigger.use_inverse then
        local _, _, _, _, _, _, _, _, _, icon = GetItemInfo(trigger.itemName or 0);
        return icon;
      else
        return nil;
      end
    end,
    hasItemID = true,
    automaticrequired = true
  },
  ["Equipment Set"] = {
    type = "status",
    events = {
      ["events"] = {
        "PLAYER_EQUIPMENT_CHANGED",
        "WEAR_EQUIPMENT_SET",
        "EQUIPMENT_SETS_CHANGED",
        "EQUIPMENT_SWAP_FINISHED",
      }
    },
    internal_events = {"WA_DELAYED_PLAYER_ENTERING_WORLD"},
    force_events = "PLAYER_EQUIPMENT_CHANGED",
    name = L["Equipment Set Equipped"],
    init = function(trigger)
      trigger.itemSetName = trigger.itemSetName or "";
      local itemSetName = type(trigger.itemSetName) == "string" and ("[=[" .. trigger.itemSetName .. "]=]") or "nil";

      local ret = [[
        local useItemSetName = %s;
        local triggerItemSetName = %s;
        local inverse = %s;
        local partial = %s;

      ]];

      return ret:format(trigger.use_itemSetName and "true" or "false", itemSetName, trigger.use_inverse and "true" or "false", trigger.use_partial and "true" or "false");
    end,
    statesParameter = "one",
    args = {
      {
        name = "itemSetName",
        display = L["Equipment Set"],
        type = "string",
        test = "true",
        store = true,
        conditionType = "string",
        init = "WeakAuras.GetEquipmentSetInfo(useItemSetName and triggerItemSetName or nil, partial)"
      },
      {
        name = "partial",
        display = L["Allow partial matches"],
        type = "toggle",
        test = "true"
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "(inverse and itemSetName == nil) or (not inverse and itemSetName)"
      }
    },
    nameFunc = function(trigger)
      return WeakAuras.GetEquipmentSetInfo(trigger.use_itemSetName and trigger.itemSetName or nil, trigger.use_partial);
    end,
    iconFunc = function(trigger)
      local _, icon = WeakAuras.GetEquipmentSetInfo(trigger.use_itemSetName and trigger.itemSetName or nil, trigger.use_partial);
      return icon;
    end,
    durationFunc = function(trigger)
      local _, _, numEquipped, numItems = WeakAuras.GetEquipmentSetInfo(trigger.use_itemSetName and trigger.itemSetName or nil, trigger.use_partial);
      return numEquipped, numItems, true;
    end,
    hasItemID = true,
    automaticrequired = true
  },
  ["Threat Situation"] = {
    type = "status",
    events = function(trigger)
      local result = {}
      if trigger.threatUnit and trigger.threatUnit ~= "none" then
        AddUnitEventForEvents(result, trigger.threatUnit, "UNIT_THREAT_LIST_UPDATE")
      else
        AddUnitEventForEvents(result, "player", "UNIT_THREAT_SITUATION_UPDATE")
      end
      return result
    end,
    internal_events = function(trigger)
      local result = {}
      if trigger.threatUnit and trigger.threatUnit ~= "none" then
        AddUnitChangeInternalEvents(trigger.threatUnit, result)
      end
      return result
    end,
    force_events = "UNIT_THREAT_LIST_UPDATE",
    name = L["Threat Situation"],
    init = function(trigger)
      local ret = [[
        local unit = %s
        local ok = true
        local aggro, status, threatpct, rawthreatpct, threatvalue, threattotal
        if unit then
          aggro, status, threatpct, rawthreatpct, threatvalue = WeakAuras.UnitDetailedThreatSituation('player', unit)
          threattotal = (threatvalue or 0) * 100 / (threatpct ~= 0 and threatpct or 1)
        else
          status = UnitThreatSituation('player')
          aggro = status == 2 or status == 3
          threatpct, rawthreatpct, threatvalue, threattotal = 100, 100, 0, 100
        end
      ]];
      return ret:format(trigger.threatUnit and trigger.threatUnit ~= "none" and "[["..trigger.threatUnit.."]]" or "nil");
    end,
    canHaveDuration = true,
    statesParameter = "one",
    args = {
      {
        name = "threatUnit",
        display = L["Unit"],
        required = true,
        type = "unit",
        values = "threat_unit_types",
        test = "true",
        default = "target"
      },
      {
        name = "status",
        display = L["Status"],
        type = "select",
        values = "unit_threat_situation_types",
        store = true,
        conditionType = "select"
      },
      {
        name = "aggro",
        display = L["Aggro"],
        type = "tristate",
        store = true,
        conditionType = "bool",
      },
      {
        name = "threatpct",
        display = L["Threat Percent"],
        desc = L["Your threat on the mob as a percentage of the amount required to pull aggro. Will pull aggro at 100."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.threatUnit ~= "none" end,
      },
      {
        name = "rawthreatpct",
        display = L["Raw Threat Percent"],
        desc = L["Your threat as a percentage of the tank's current threat."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.threatUnit ~= "none" end,
      },
      {
        name = "threatvalue",
        display = L["Threat Value"],
        desc = L["Your total threat on the mob."],
        type = "number",
        store = true,
        conditionType = "number",
        enable = function(trigger) return trigger.threatUnit ~= "none" end,
      },
      {
        name = "value",
        hidden = true,
        init = "threatvalue",
        store = true,
        test = "true"
      },
      {
        name = "total",
        hidden = true,
        init = "threattotal",
        store = true,
        test = "true"
      },
      {
        name = "progressType",
        hidden = true,
        init = "'static'",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        test = "status ~= nil and ok"
      }
    },
    automaticrequired = true
  },
  ["Crowd Controlled"] = {
    type = "status",
    events = {
      ["unit_events"] = {
        ["player"] = {"UNIT_AURA"}
      }
    },
    force_events = "UNIT_AURA",
    name = L["Crowd Controlled"],
    args = {
      {
        name = "controlled",
        display = L["Crowd Controlled"],
        type = "tristate",
        init = "not HasFullControl()"
      }
    },
    automaticrequired = true
  },
  ["Cast"] = {
    type = "status",
    events = function(trigger)
      local result = {}
      local unit = trigger.unit
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_START")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_DELAYED")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_STOP")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_START")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_UPDATE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_CHANNEL_STOP")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_INTERRUPTIBLE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_NOT_INTERRUPTIBLE")
      AddUnitEventForEvents(result, unit, "UNIT_SPELLCAST_INTERRUPTED")
      AddUnitEventForEvents(result, unit, "UNIT_TARGET")
      AddUnitEventForEvents(result, unit, "UNIT_NAME_UPDATE")
      return result
    end,
    internal_events = function(trigger)
      local unit = trigger.unit
      local result = {"CAST_REMAINING_CHECK"}
      AddUnitChangeInternalEvents(unit, result)
      return result
    end,
    force_events = unitHelperFunctions.UnitChangedForceEvents,
    canHaveAuto = true,
    canHaveDuration = "timed",
    name = L["Cast"],
    init = function(trigger)
      trigger.unit = trigger.unit or "player";
      local ret = [=[
        unit = string.lower(unit)
        local destUnit = unit .. '-target'
        local sourceName, sourceRealm = WeakAuras.UnitNameWithRealm(unit)
        local destName, destRealm = WeakAuras.UnitNameWithRealm(destUnit)
        destName = destName or ""
        destRealm = destRealm or ""
        local smart = %s
        local remainingCheck = %s
        local inverseTrigger = %s

        local show, expirationTime, castType, spell, icon, startTime, endTime, interruptible, remaining, _

        spell, _, _, icon, startTime, endTime, _, _, interruptible = UnitCastingInfo(unit)
        if spell then
          castType = "cast"
        else
          spell, _, _, icon, startTime, endTime, _, interruptible = UnitChannelInfo(unit)
          if spell then
            castType = "channel"
          end
        end
        interruptible = not interruptible
        expirationTime = endTime and endTime > 0 and (endTime / 1000) or 0
        remaining = expirationTime - GetTime()

        if remainingCheck and remaining >= remainingCheck and remaining > 0 then
          WeakAuras.ScheduleCastCheck(expirationTime - remainingCheck, unit)
        end
      ]=];

      ret = ret:format(trigger.unit == "group" and "true" or "false",
                        trigger.use_remaining and tonumber(trigger.remaining or 0) or "nil",
                        trigger.use_inverse and "true" or "false");
     ret = ret .. unitHelperFunctions.SpecificUnitCheck(trigger)
     return ret
    end,
    statesParameter = "unit",
    args = {
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "arg",
        values = function(trigger)
          if trigger.use_inverse then
            return WeakAuras.actual_unit_types_with_specific
          else
            return WeakAuras.actual_unit_types_cast
          end
        end,
        test = "true",
        store = true
      },
      {
        name = "spell",
        display = L["Spell Name"],
        type = "string",
        enable = function(trigger) return not trigger.use_inverse end,
        conditionType = "string",
        store = true,
      },
      {
        name = "spellId",
        display = L["Spell Id"],
        type = "spell",
        enable = function(trigger) return not trigger.use_inverse end,
        conditionType = "number",
        forceExactOption = true,
        test = "GetSpellInfo(%s) == spell",
        store = true,
      },
      {
        name = "castType",
        display = L["Cast Type"],
        type = "select",
        values = "cast_types",
        enable = function(trigger) return not trigger.use_inverse end,
        store = true,
        conditionType = "select"
      },
      {
        name = "interruptible",
        display = L["Interruptible"],
        type = "tristate",
        enable = function(trigger) return not trigger.use_inverse end,
        store = true,
        conditionType = "bool"
      },
      {
        name = "remaining",
        display = L["Remaining Time"],
        type = "number",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "name",
        hidden = true,
        init = "spell",
        test = "true",
        store = true
      },
      {
        name = "icon",
        hidden = true,
        init = "icon or 'Interface\\AddOns\\WeakAuras\\Media\\Textures\\icon'",
        test = "true",
        store = true
      },
      {
        name = "duration",
        hidden = true,
        init = "endTime and startTime and (endTime - startTime)/1000 or 0",
        test = "true",
        store = true
      },
      {
        name = "expirationTime",
        init = "expirationTime",
        hidden = true,
        test = "true",
        store = true
      },
      {
        name = "progressType",
        hidden = true,
        init = "'timed'",
        test = "true",
        store = true
      },
      {
        name = "inverse",
        hidden = true,
        init = "castType == 'cast'",
        test = "true",
        store = true
      },
      {
        name = "autoHide",
        hidden = true,
        init = "true",
        test = "true",
        store = true
      },
      {
        name = "npcId",
        display = L["Npc ID"],
        type = "string",
        store = true,
        conditionType = "string",
        test = "tostring(tonumber(string.sub(UnitGUID(unit) or '', 8, 12), 16) or '') == %q",
        enable = function(trigger)
          return not trigger.use_inverse
        end
      },
      {
        name = "class",
        display = L["Class"],
        type = "select",
        init = "select(2, UnitClass(unit))",
        values = "class_types",
        store = true,
        conditionType = "select",
        enable = function(trigger)
          return not trigger.use_inverse
        end
      },
      {
        name = "sourceUnit",
        init = "unit",
        display = L["Caster"],
        type = "unit",
        values = "actual_unit_types_with_specific",
        conditionType = "unit",
        conditionTest = function(state, unit, op)
          return state and state.show and state.unit and ((UnitIsUnit(state.sourceUnit, unit) == 1 and true or false) == (op == "=="))
        end,
        store = true,
        hidden = true,
        enable = function(trigger) return not trigger.use_inverse end,
        test = "true"
      },
      {
        name = "sourceName",
        display = L["Caster Name"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "sourceRealm",
        display = L["Caster Realm"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "sourceNameRealm",
        display = L["Source Unit Name/Realm"],
        type = "string",
        preamble = "local sourceNameRealmChecker = WeakAuras.ParseNameCheck(%q)",
        test = "sourceNameRealmChecker:Check(sourceName, sourceRealm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return WeakAuras.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.sourceName, state.sourceRealm)
        end,
        operator_types = "none",
        enable = function(trigger) return not trigger.use_inverse end,
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "destUnit",
        display = L["Caster's Target "],
        type = "unit",
        values = "actual_unit_types_with_specific",
        conditionType = "unit",
        conditionTest = function(state, unit, op)
          return state and state.show and state.destUnit and ((UnitIsUnit(state.destUnit, unit) == 1 and true or false) == (op == "=="))
        end,
        store = true,
        enable = function(trigger) return not trigger.use_inverse end,
        test = "UnitIsUnit(destUnit, [[%s]])"
      },
      {
        name = "destName",
        display = L["Name of Caster's Target"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "destRealm",
        display = L["Realm of Caster's Target"],
        type = "string",
        store = true,
        hidden = true,
        test = "true",
        enable = function(trigger) return not trigger.use_inverse end,
      },
      {
        name = "destNameRealm",
        display = L["Name/Realm of Caster's Target"],
        type = "string",
        preamble = "local destNameRealmChecker = WeakAuras.ParseNameCheck(%q)",
        test = "destNameRealmChecker:Check(destName, destRealm)",
        conditionType = "string",
        conditionPreamble = function(input)
          return WeakAuras.ParseNameCheck(input)
        end,
        conditionTest = function(state, needle, op, preamble)
          return preamble:Check(state.destName, state.destRealm)
        end,
        operator_types = "none",
        enable = function(trigger) return not trigger.use_inverse end,
        desc = constants.nameRealmFilterDesc,
      },
      {
        name = "inverse",
        display = L["Inverse"],
        type = "toggle",
        test = "true",
        reloadOptions = true
      },
      {
        hidden = true,
        test = "WeakAuras.UnitExistsFixed(unit, smart) and ((not inverseTrigger and spell) or (inverseTrigger and not spell)) and specificUnitCheck"
      }
    },
    automaticrequired = true,
  },
  ["Character Stats"] = {
    type = "status",
    name = L["Character Stats"],
    events = {
      ["events"] = {
        "COMBAT_RATING_UPDATE",
        "PLAYER_TARGET_CHANGED"
      },
      ["unit_events"] = {
        ["player"] = {"UNIT_STATS"}
      }
    },
    internal_events = function(trigger, untrigger)
      local events = { "WA_DELAYED_PLAYER_ENTERING_WORLD" }
      if trigger.use_moveSpeed then
        tinsert(events, "PLAYER_MOVE_SPEED_UPDATE")
      end
      return events
    end,
    loadFunc = function(trigger)
      if trigger.use_moveSpeed then
        WeakAuras.WatchPlayerMoveSpeed()
      end
    end,
    force_events = "CONDITIONS_CHECK",
    statesParameter = "one",
    args = {
      {
        name = "strength",
        display = L["Strength"],
        type = "number",
        init = "UnitStat('player', 1)",
        store = true,
        conditionType = "number"
      },
      {
        name = "agility",
        display = L["Agility"],
        type = "number",
        init = "UnitStat('player', 2)",
        store = true,
        conditionType = "number"
      },
      {
        name = "stamina",
        display = L["Stamina"],
        type = "number",
        init = "UnitStat('player', 3)",
        store = true,
        conditionType = "number"
      },
      {
        name = "intellect",
        display = L["Intellect"],
        type = "number",
        init = "UnitStat('player', 4)",
        store = true,
        conditionType = "number"
      },
      {
        name = "spirit",
        display = L["Spirit"],
        type = "number",
        init = "UnitStat('player', 5)",
        store = true,
        conditionType = "number"
      },
      {
        name = "meleecriticalrating",
        display = L["Melee Critical Rating"],
        type = "number",
        init = "GetCombatRating(CR_CRIT_MELEE)",
        store = true,
        conditionType = "number",
      },
      {
        name = "rangedcriticalrating",
        display = L["Ranged Critical Rating"],
        type = "number",
        init = "GetCombatRating(CR_CRIT_RANGED)",
        store = true,
        conditionType = "number",
      },
      {
        name = "spellcriticalrating",
        display = L["Spell Critical Rating"],
        type = "number",
        init = "GetCombatRating(CR_CRIT_SPELL)",
        store = true,
        conditionType = "number",
      },
      {
        name = "meleecriticalpercent",
        display = L["Mele Critical (%)"],
        type = "number",
        init = "GetCritChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "rangedcriticalpercent",
        display = L["Ranged Critical (%)"],
        type = "number",
        init = "GetRangedCritChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "spellcriticalpercent",
        display = L["Spell Critical (%)"],
        type = "number",
        init = "WeakAuras.GetSpellCritChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "meleehasterating",
        display = L["Melee Haste Rating"],
        type = "number",
        init = "GetCombatRating(CR_HASTE_MELEE)",
        store = true,
        conditionType = "number"
      },
      {
        name = "rangedhasterating",
        display = L["Ranged Haste Rating"],
        type = "number",
        init = "GetCombatRating(CR_HASTE_RANGED)",
        store = true,
        conditionType = "number"
      },
      {
        name = "spellhasterating",
        display = L["Spell Haste Rating"],
        type = "number",
        init = "GetCombatRating(CR_HASTE_SPELL)",
        store = true,
        conditionType = "number"
      },
      {
        name = "resistancefire",
        display = L["Fire Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 2))",
        store = true,
        conditionType = "number"
      },
      {
        name = "resistancenature",
        display = L["Nature Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 3))",
        store = true,
        conditionType = "number"
      },
      {
        name = "resistancefrost",
        display = L["Frost Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 4))",
        store = true,
        conditionType = "number"
      },
      {
        name = "resistanceshadow",
        display = L["Shadow Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 5))",
        store = true,
        conditionType = "number"
      },
      {
        name = "resistancearcane",
        display = L["Arcane Resistance"],
        type = "number",
        init = "select(2, UnitResistance('player', 6))",
        store = true,
        conditionType = "number"
      },
      {
        name = "moveSpeed",
        display = L["Continously update Movement Speed"],
        type = "boolean",
        test = true,
        width = WeakAuras.doubleWidth
      },
      {
        name = "movespeedpercent",
        display = L["Movement Speed (%)"],
        type = "number",
        init = "GetUnitSpeed('player') / 7 * 100",
        store = true,
        conditionType = "number"
      },
      {
        name = "dodgerating",
        display = L["Dodge Rating"],
        type = "number",
        init = "GetCombatRating(CR_DODGE)",
        store = true,
        conditionType = "number"
      },
      {
        name = "dodgepercent",
        display = L["Dodge (%)"],
        type = "number",
        init = "GetDodgeChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "parryrating",
        display = L["Parry Rating"],
        type = "number",
        init = "GetCombatRating(CR_PARRY)",
        store = true,
        conditionType = "number"
      },
      {
        name = "parrypercent",
        display = L["Parry (%)"],
        type = "number",
        init = "GetParryChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "blockrating",
        display = L["Block Rating"],
        type = "number",
        init = "GetCombatRating(CR_BLOCK)",
        store = true,
        conditionType = "number"
      },
      {
        name = "blockpercent",
        display = L["Block (%)"],
        type = "number",
        init = "GetBlockChance()",
        store = true,
        conditionType = "number"
      },
      {
        name = "armorrating",
        display = L["Armor Rating"],
        type = "number",
        init = "select(2, UnitArmor('player'))",
        store = true,
        conditionType = "number"
      },
      {
        name = "armorpercent",
        display = L["Armor (%)"],
        type = "number",
        init = "PaperDollFrame_GetArmorReduction(select(2, UnitArmor('player')), UnitLevel('player'))",
        store = true,
        conditionType = "number"
      },
    },
    automaticrequired = true
  },
  ["Conditions"] = {
    type = "status",
    events = function(trigger, untrigger)
      local events = {}
      if trigger.use_incombat ~= nil then
        tinsert(events, "PLAYER_REGEN_ENABLED")
        tinsert(events, "PLAYER_REGEN_DISABLED")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_pvpflagged ~= nil or trigger.use_afk ~= nil then
        tinsert(events, "PLAYER_FLAGS_CHANGED")
      end
      if trigger.use_alive ~= nil then
        tinsert(events, "PLAYER_DEAD")
        tinsert(events, "PLAYER_ALIVE")
        tinsert(events, "PLAYER_UNGHOST")
      end
      if trigger.use_resting ~= nil then
        tinsert(events, "PLAYER_UPDATE_RESTING")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_mounted ~= nil then
        tinsert(events, "COMPANION_UPDATE")
        tinsert(events, "PLAYER_ENTERING_WORLD")
        tinsert(events, "MOUNTED_UPDATE")
      end
      local unit_events = {}
      local pet_unit_events = {}
      if trigger.use_vehicle ~= nil then
        tinsert(unit_events, "UNIT_ENTERED_VEHICLE")
        tinsert(unit_events, "UNIT_EXITED_VEHICLE")
        tinsert(events, "PLAYER_ENTERING_WORLD")
      end
      if trigger.use_HasPet ~= nil then
        tinsert(pet_unit_events, "UNIT_HEALTH")
      end
      if trigger.use_ingroup ~= nil then
        tinsert(events, "PARTY_MEMBERS_CHANGED")
        tinsert(events, "RAID_ROSTER_UPDATE")
      end

      if trigger.use_instance_size then
        tinsert(events, "ZONE_CHANGED")
        tinsert(events, "ZONE_CHANGED_INDOORS")
        tinsert(events, "ZONE_CHANGED_NEW_AREA")
      end

      if trigger.use_instance_difficulty then
        tinsert(events, "PLAYER_DIFFICULTY_CHANGED")
        tinsert(events, "ZONE_CHANGED")
        tinsert(events, "ZONE_CHANGED_INDOORS")
        tinsert(events, "ZONE_CHANGED_NEW_AREA")
      end

      return {
        ["events"] = events,
        ["unit_events"] = {
          ["player"] = unit_events,
          ["pet"] = pet_unit_events
        }
      }
    end,
    internal_events = function(trigger, untrigger)
      local events = { "CONDITIONS_CHECK"};

      if (trigger.use_HasPet ~= nil) then
        AddUnitChangeInternalEvents("pet", events)
      end

      return events;
    end,
    force_events = "CONDITIONS_CHECK",
    name = L["Conditions"],
    init = function(trigger)
      if(trigger.use_mounted ~= nil) then
        WeakAuras.WatchForMounts();
      end
      return "";
    end,
    args = {
      {
        name = "alwaystrue",
        display = L["Always active trigger"],
        type = "tristate",
        init = "true"
      },
      {
        name = "incombat",
        display = L["In Combat"],
        type = "tristate",
        init = "UnitAffectingCombat('player')"
      },
      {
        name = "pvpflagged",
        display = L["PvP Flagged"],
        type = "tristate",
        init = "UnitIsPVP('player')",
      },
      {
        name = "alive",
        display = L["Alive"],
        type = "tristate",
        init = "not UnitIsDeadOrGhost('player')"
      },
      {
        name = "vehicle",
        display = L["In Vehicle"],
        type = "tristate",
        init = "UnitInVehicle('player')",
      },
      {
        name = "resting",
        display = L["Resting"],
        type = "tristate",
        init = "IsResting()"
      },
      {
        name = "mounted",
        display = L["Mounted"],
        type = "tristate",
        init = "IsMounted()"
      },
      {
        name = "HasPet",
        display = L["HasPet"],
        type = "tristate",
        init = "UnitExists('pet') and not UnitIsDead('pet')"
      },
      {
        name = "afk",
        display = L["Is Away from Keyboard"],
        type = "tristate",
        init = "UnitIsAFK('player')"
      },
      {
        name = "ingroup",
        display = L["In Group"],
        type = "multiselect",
        values = "group_types",
        init = "WeakAuras.GroupType()",
        events = {"PARTY_MEMBERS_CHANGED", "RAID_ROSTER_UPDATE"}
      },
      {
        name = "instance_size",
        display = L["Instance Type"],
        type = "multiselect",
        values = "instance_types",
        init = "WeakAuras.InstanceType()",
        control = "WeakAurasSortedDropdown",
        events = {"ZONE_CHANGED", "ZONE_CHANGED_INDOORS", "ZONE_CHANGED_NEW_AREA"}
      },
      {
        name = "instance_difficulty",
        display = L["Instance Difficulty"],
        type = "multiselect",
        values = "difficulty_types",
        init = "WeakAuras.InstanceDifficulty()"
      },
    },
    automaticrequired = true
  },

  ["Spell Known"] = {
    type = "status",
    events = {
      ["events"] = {"SPELLS_CHANGED"},
      ["unit_events"] = {
        ["player"] = {"UNIT_PET"}
      }
    },
    internal_events = {
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "SPELLS_CHANGED",
    name = L["Spell Known"],
    init = function(trigger)
      local spellId = trigger.spellId or "";
      local ret = [[
        local spellId = tonumber(%q);
        local usePet = %s;
      ]]
      return ret:format(spellId, trigger.use_petspell and "true" or "false");
    end,
    args = {
      {
        name = "spellId",
        required = true,
        display = L["Spell Id"],
        type = "spell",
        test = "true",
        conditionType = "number",
        forceExactOption = true
      },
      {
        name = "petspell",
        display = L["Pet Spell"],
        type = "toggle",
        test = "true"
      },
      {
        hidden = true,
        test = "spellId and WeakAuras.IsSpellKnown(spellId, usePet)";
      }
    },
    nameFunc = function(trigger)
      return GetSpellInfo(trigger.spellId or 0)
    end,
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.spellId or 0);
      return icon;
    end,
    automaticrequired = true
  },

  ["Pet Behavior"] = {
    type = "status",
    events = function(trigger)
      local result = {};
      if (trigger.use_behavior) then
        tinsert(result, "PET_BAR_UPDATE");
      end
      return {
        ["events"] = result,
        ["unit_events"] = {
          ["player"] = {"UNIT_PET"}
        }
      };
    end,
    internal_events = {
      "WA_DELAYED_PLAYER_ENTERING_WORLD"
    },
    force_events = "WA_DELAYED_PLAYER_ENTERING_WORLD",
    name = L["Pet"],
    init = function(trigger)
      local ret = "local activeIcon\n";
      if (trigger.use_behavior) then
        ret = [[
            local inverse = %s
            local check_behavior = %s
            local name, i, token, active, behavior, _
            for index = 1, NUM_PET_ACTION_SLOTS do
              name, _, i, token, active = GetPetActionInfo(index)
              if active then
                activeIcon = not token and i or _G[i]
                if name == "PET_MODE_AGGRESSIVE" then
                  behavior = "aggressive"
                  break
                elseif name == "PET_MODE_DEFENSIVE" then
                  behavior = "defensive"
                  break
                elseif name == "PET_MODE_PASSIVE" then
                  behavior = "passive"
                  break
                end
              end
            end
        ]]
        ret = ret:format(trigger.use_inverse and "true" or "false", trigger.use_behavior and ('"' .. (trigger.behavior or "") .. '"') or "nil");
      end
      return ret;
    end,
    statesParameter = "one",
    canHaveAuto = true,
    args = {
      {
        name = "behavior",
        display = L["Pet Behavior"],
        type = "select",
        values = "pet_behavior_types",
        test = "UnitExists('pet') and (not check_behavior or (inverse and check_behavior ~= behavior) or (not inverse and check_behavior == behavior))",
      },
      {
        name = "inverse",
        display = L["Inverse Pet Behavior"],
        type = "toggle",
        test = "true",
        enable = function(trigger) return trigger.use_behavior end
      },
      {
        hidden = true,
        name = "icon",
        init = "activeIcon",
        store = "true",
        test = "true"
      },
    },
    automaticrequired = true
  },

  ["Queued Action"] = {
    type = "status",
    events = {
      ["events"] = {"ACTIONBAR_UPDATE_STATE"}
    },
    internal_events = {
      "ACTIONBAR_SLOT_CHANGED",
      "ACTIONBAR_PAGE_CHANGED"
    },
    name = L["Queued Action"],
    loadFunc = function()
      WeakAuras.WatchQueuedAction()
    end,
    init = function(trigger)
      trigger.spellName = trigger.spellName or 0
      local ret = [=[
        local button = WeakAuras.FindSpellActionButtons(%d)
      ]=]
      return ret:format(trigger.spellName)
    end,
    args = {
      {
        name = "spellName",
        required = true,
        display = L["Spell"],
        type = "spell",
        test = "true",
        forceExactOption = true,
      },
      {
        hidden = true,
        test = "button and IsCurrentAction(button)";
      },
    },
    iconFunc = function(trigger)
      local _, _, icon = GetSpellInfo(trigger.spellName or 0);
      return icon;
    end,
    automaticrequired = true
  },

  ["Range Check"] = {
    type = "status",
    events = {
      ["events"] = {"FRAME_UPDATE"}
    },
    name = L["Range Check"],
    init = function(trigger)
      trigger.unit = trigger.unit or "target";
      local ret = [=[
          local unit = %q;
          local min, max = WeakAuras.GetRange(unit, true);
          min = min or 0;
          max = max or 999;
          local triggerResult = true;
      ]=]
      if (trigger.use_range) then
        trigger.range = trigger.range or 8;
        if (trigger.range_operator == "<=") then
          ret = ret .. "triggerResult = max <= " .. tostring(trigger.range) .. "\n";
        else
          ret = ret .. "triggerResult = min >= " .. tostring(trigger.range).. "\n";
        end
      end
      return ret:format(trigger.unit);
    end,
    statesParameter = "one",
    args = {
      {
        name = "note",
        type = "description",
        display = "",
        text = function() return L["Note: This trigger type estimates the range to the hitbox of a unit. The actual range of friendly players is usually 3 yards more than the estimate. Range checking capabilities depend on your current class and known abilities as well as the type of unit being checked. Some of the ranges may also not work with certain NPCs.|n|n|cFFAAFFAAFriendly Units:|r %s|n|cFFFFAAAAHarmful Units:|r %s|n|cFFAAAAFFMiscellanous Units:|r %s"]:format(RangeCacheStrings.friend or "", RangeCacheStrings.harm or "", RangeCacheStrings.misc or "") end
      },
      {
        name = "unit",
        required = true,
        display = L["Unit"],
        type = "unit",
        init = "unit",
        values = "unit_types_range_check",
        test = "true",
        store = true
      },
      {
        hidden = true,
        name = "minRange",
        display = L["Minimum Estimate"],
        type = "number",
        init = "min",
        store = true,
        test = "true"
      },
      {
        hidden = true,
        name = "maxRange",
        display = L["Maximum Estimate"],
        type = "number",
        init = "max",
        store = true,
        test = "true"
      },
      {
        name = "range",
        display = L["Distance"],
        type = "number",
        operator_types = "without_equal",
        test = "triggerResult",
        conditionType = "number",
        conditionTest = function(state, needle, needle2)
          return state and state.show and WeakAuras.CheckRange(state.unit, needle, needle2);
        end,
      },
      {
        hidden = true,
        test = "UnitExists(unit)"
      }
    },
    automaticrequired = true
  },

};

WeakAuras.event_prototypes["DBM Announce"] = nil
WeakAuras.event_prototypes["DBM Timer"] = nil
WeakAuras.event_prototypes["BigWigs Message"] = nil
WeakAuras.event_prototypes["BigWigs Timer"] = nil

WeakAuras.dynamic_texts = {
  ["p"] = {
    get = function(state)
      if not state then return nil end
      if state.progressType == "static" then
        return state.value or nil
      end
      if state.progressType == "timed" then
        if not state.expirationTime or not state.duration then
          return nil
        end
        local remaining  = state.expirationTime - GetTime();
        return remaining >= 0 and remaining or nil
      end
    end,
    func = function(remaining, state, progressPrecision)
      progressPrecision = progressPrecision or 1
      if not state or state.progressType ~= "timed" then
        return remaining
      end
      if type(remaining) ~= "number" then
        return ""
      end

      local remainingStr = "";
      if remaining == math.huge then
        remainingStr = " ";
      elseif remaining > 60 then
        remainingStr = string.format("%i:", math.floor(remaining / 60));
        remaining = remaining % 60;
        remainingStr = remainingStr..string.format("%02i", remaining);
      elseif remaining > 0 then
        if progressPrecision == 4 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.1f", remaining);
        elseif progressPrecision == 5 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.2f", remaining);
        elseif progressPrecision == 6 and remaining <= 3 then
          remainingStr = remainingStr..string.format("%.3f", remaining);
        elseif (progressPrecision == 4 or progressPrecision == 5 or progressPrecision == 6) and remaining > 3 then
          remainingStr = remainingStr..string.format("%d", remaining);
        else
          remainingStr = remainingStr..string.format("%.".. progressPrecision .."f", remaining);
        end
      else
        remainingStr = " ";
      end
      return remainingStr
    end
  },
  ["t"] = {
    get = function(state)
      if not state then return "" end
      if state.progressType == "static" then
        return state.total, false
      end
      if state.progressType == "timed" then
        if not state.duration then
          return nil
        end
        return state.duration, true
      end
    end,
    func = function(duration, state, totalPrecision)
      if not state or state.progressType ~= "timed" then
        return duration
      end
      if type(duration) ~= "number" then
        return ""
      end
      local durationStr = "";
      if math.abs(duration) == math.huge or tostring(duration) == "nan" then
        durationStr = " ";
      elseif duration > 60 then
        durationStr = string.format("%i:", math.floor(duration / 60));
        duration = duration % 60;
        durationStr = durationStr..string.format("%02i", duration);
      elseif duration > 0 then
        if totalPrecision == 4 and duration <= 3 then
          durationStr = durationStr..string.format("%.1f", duration);
        elseif totalPrecision == 5 and duration <= 3 then
          durationStr = durationStr..string.format("%.2f", duration);
        elseif totalPrecision == 6 and duration <= 3 then
          durationStr = durationStr..string.format("%.3f", duration);
        elseif (totalPrecision == 4 or totalPrecision == 5 or totalPrecision == 6) and duration > 3 then
          durationStr = durationStr..string.format("%d", duration);
        else
          durationStr = durationStr..string.format("%."..totalPrecision.."f", duration);
        end
      else
        durationStr = " ";
      end
      return durationStr
    end
  },
  ["n"] = {
    get = function(state)
      if not state then return "" end
      return state.name or state.id or "", true
    end,
    func = function(v)
      return v
    end
  },
  ["i"] = {
    get = function(state)
      if not state then return "" end
      return state.icon or "Interface\\Icons\\INV_Misc_QuestionMark"
    end,
    func = function(v)
      return "|T".. v ..":12:12:0:0:64:64:4:60:4:60|t"
    end
  },
  ["s"] = {
    get = function(state)
      if not state or state.stacks == 0 then return "" end
      return state.stacks
    end,
    func = function(v)
      return v
    end
  }
};
