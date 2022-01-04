local ipairs = ipairs
local pairs = pairs
local ceil, floor = math.ceil, math.floor

local GetInstanceInfo = GetInstanceInfo
local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

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
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end

function IsInRaid()
	return GetNumRaidMembers() > 0
end

function GetNumSubgroupMembers()
	return GetNumPartyMembers()
end

function GetNumGroupMembers()
	return IsInRaid() and GetNumRaidMembers() or GetNumPartyMembers()
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

if not SmoothStatusBarMixin then
	function Lerp(startValue, endValue, amount)
		return (1 - amount) * startValue + amount * endValue;
	end

	function Clamp(value, min, max)
		if value > max then
			return max;
		elseif value < min then
			return min;
		end
		return value;
	end

	function Saturate(value)
		return Clamp(value, 0, 1);
	end

	local TARGET_FRAME_PER_SEC = 60;
	function DeltaLerp(startValue, endValue, amount, timeSec)
		return Lerp(startValue, endValue, Saturate(amount * timeSec * TARGET_FRAME_PER_SEC));
	end

	function FrameDeltaLerp(startValue, endValue, amount, elapsed)
		return DeltaLerp(startValue, endValue, amount, elapsed);
	end

	local g_updatingBars = {};

	local function IsCloseEnough(bar, newValue, targetValue)
		local min, max = bar:GetMinMaxValues();
		local range = max - min;
		if range > 0 then
			return math.abs((newValue - targetValue) / range) < .00001;
		end

		return true;
	end

	local function ProcessSmoothStatusBars(self, elapsed)
		for bar, targetValue in pairs(g_updatingBars) do
			local effectiveTargetValue = Clamp(targetValue, bar:GetMinMaxValues());
			local newValue = FrameDeltaLerp(bar:GetValue(), effectiveTargetValue, .25, elapsed);

			if IsCloseEnough(bar, newValue, effectiveTargetValue) then
				g_updatingBars[bar] = nil;
				bar:SetValue(effectiveTargetValue);
			else
				bar:SetValue(newValue);
			end
		end
	end

	CreateFrame("Frame"):SetScript("OnUpdate", ProcessSmoothStatusBars)

	SmoothStatusBarMixin = {};

	function SmoothStatusBarMixin:ResetSmoothedValue(value) --If nil, tries to set to the last target value
		local targetValue = g_updatingBars[self];
		if targetValue then
			g_updatingBars[self] = nil;
			self:SetValue(value or targetValue);
		elseif value then
			self:SetValue(value);
		end
	end

	function SmoothStatusBarMixin:SetSmoothedValue(value)
		g_updatingBars[self] = value;
	end

	function SmoothStatusBarMixin:SetMinMaxSmoothedValue(min, max)
		self:SetMinMaxValues(min, max);

		local targetValue = g_updatingBars[self];
		if targetValue then
			local ratio = 1;
			if max ~= 0 and self.lastSmoothedMax and self.lastSmoothedMax ~= 0 then
				ratio = max / self.lastSmoothedMax;
			end

			g_updatingBars[self] = targetValue * ratio;
		end

		self.lastSmoothedMin = min;
		self.lastSmoothedMax = max;
	end
end