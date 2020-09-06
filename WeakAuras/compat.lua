local ipairs = ipairs
local pairs = pairs
local ceil, floor = math.ceil, math.floor
local format = string.format

local GetInstanceInfo = GetInstanceInfo
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers
local UnitClass = UnitClass

function GetClassColoredTextForUnit(unit, text)
	local _, classFilename = UnitClass(unit)
	local color = RAID_CLASS_COLORS[classFilename]
	if color then
		return format("|c%s%s|r", format("ff%.2x%.2x%.2x", color.r * 255, color.g * 255, color.b * 255), text)
	else
		return text
	end
end

function tInvert(tbl)
	local inverted = {};
	for k, v in pairs(tbl) do
		inverted[v] = k;
	end
	return inverted;
end

function Round(value)
	if value < 0 then
		return ceil(value - .5);
	end
	return floor(value + .5);
end

function tIndexOf(tbl, item)
	for i, v in ipairs(tbl) do
		if item == v then
			return i;
		end
	end
end

function IsInGroup()
	return (GetNumRaidMembers() == 0 and GetNumPartyMembers() > 0)
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end

function GetNumSubgroupMembers()
	return GetNumPartyMembers()
end

function GetNumGroupMembers()
	return GetNumRaidMembers()
end

RAID_CLASS_COLORS.HUNTER.colorStr = "ffabd473"
RAID_CLASS_COLORS.WARLOCK.colorStr = "ff8788ee"
RAID_CLASS_COLORS.PRIEST.colorStr = "ffffffff"
RAID_CLASS_COLORS.PALADIN.colorStr = "fff58cba"
RAID_CLASS_COLORS.MAGE.colorStr = "ff3fc7eb"
RAID_CLASS_COLORS.ROGUE.colorStr = "fffff569"
RAID_CLASS_COLORS.DRUID.colorStr = "ffff7d0a"
RAID_CLASS_COLORS.SHAMAN.colorStr = "ff0070de"
RAID_CLASS_COLORS.WARRIOR.colorStr = "ffc79c6e"
RAID_CLASS_COLORS.DEATHKNIGHT.colorStr = "ffc41f3b"