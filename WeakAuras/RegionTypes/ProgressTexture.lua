if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

local L = WeakAuras.L;

local defaultFont = WeakAuras.defaultFont
local defaultFontSize = WeakAuras.defaultFontSize

-- Credit to CommanderSirow for taking the time to properly craft the ApplyTransform function
-- to the enhance the abilities of Progress Textures.
-- Also Credit to Semlar for explaining how circular progress can be shown

-- NOTES:
--  Most SetValue() changes are quite equal (among compress/non-compress)
--  (There is no GUI button for mirror_v, but mirror_h)
--  New/Used variables
--   region.user_x (0) - User defined center x-shift [-1, 1]
--   region.user_y (0) - User defined center y-shift [-1, 1]
--   region.mirror_v (false) - Mirroring along x-axis [bool]
--   region.mirror_h (false) - Mirroring along y-axis [bool]
--   region.cos_rotation (1) - cos(ANGLE), precalculated cos-function for given ANGLE [-1, 1]
--   region.sin_rotation (0) - sin(ANGLE), precalculated cos-function for given ANGLE [-1, 1]
--   region.scale (1.0) - user defined scaling [1, INF]
--   region.full_rotation (false) - Allow full rotation [bool]


local function ApplyTransform(x, y, region)
  -- 1) Translate texture-coords to user-defined center
  x = x - 0.5
  y = y - 0.5

  -- 2) Shrink texture by 1/sqrt(2)
  x = x * 1.4142
  y = y * 1.4142

  if (region.orientation ~= "CLOCKWISE" and region.orientation ~= "ANTICLOCKWISE") then
    -- Not yet supported for circular progress
    -- 3) Scale texture by user-defined amount
    x = x / region.scale_x
    y = y / region.scale_y

    -- 4) Apply mirroring if defined
    if region.mirror_h then
      x = -x
    end
    if region.mirror_v then
      y = -y
    end
  else
    x = x / region.scale
    y = y / region.scale
  end

  -- 5) Rotate texture by user-defined value
  x, y = region.cos_rotation * x - region.sin_rotation * y, region.sin_rotation * x + region.cos_rotation * y

  -- 6) Translate texture-coords back to (0,0)
  x = x + 0.5
  y = y + 0.5

  if (region.orientation ~= "CLOCKWISE" and region.orientation ~= "ANTICLOCKWISE") then
    x = x + region.user_x
    y = y + region.user_y
  end

  return x, y
end

local function Transform(tx, x, y, angle, aspect) -- Translates texture to x, y and rotates around its center
  local c, s = cos(angle), sin(angle)
  y = y / aspect
  local oy =  0.5 / aspect


  local ULx, ULy = 0.5 + (x - 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x - 0.5) * s) * aspect
  local LLx, LLy = 0.5 + (x - 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x - 0.5) * s) * aspect
  local URx, URy = 0.5 + (x + 0.5) * c - (y - oy) * s, (oy + (y - oy) * c + (x + 0.5) * s) * aspect
  local LRx, LRy = 0.5 + (x + 0.5) * c - (y + oy) * s, (oy + (y + oy) * c + (x + 0.5) * s) * aspect
  tx:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
end

local default = {
  foregroundTexture = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
  backgroundTexture = "Interface\\Addons\\WeakAuras\\PowerAurasMedia\\Auras\\Aura3",
  desaturateBackground = false,
  desaturateForeground = false,
  sameTexture = true,
  compress = false,
  blendMode = "BLEND",
  backgroundOffset = 2,
  width = 200,
  height = 200,
  orientation = "VERTICAL",
  inverse = false,
  alpha = 1.0,
  foregroundColor = {1, 1, 1, 1},
  backgroundColor = {0.5, 0.5, 0.5, 0.5},
  startAngle = 0,
  endAngle = 360,
  user_x = 0,
  user_y = 0,
  crop_x = 0.41,
  crop_y = 0.41,
  crop = 0.41,
  rotation = 0,
  selfPoint = "CENTER",
  anchorPoint = "CENTER",
  anchorFrameType = "SCREEN",
  xOffset = 0,
  yOffset = 0,
  font = defaultFont,
  fontSize = defaultFontSize,
  stickyDuration = false,
  mirror = false,
  frameStrata = 1
};

WeakAuras.regionPrototype.AddAlphaToDefault(default);

WeakAuras.regionPrototype.AddAdjustedDurationToDefault(default);

local screenWidth, screenHeight = math.ceil(GetScreenWidth() / 20) * 20, math.ceil(GetScreenHeight() / 20) * 20;

local properties = {
  desaturateForeground = {
    display = L["Desaturate Foreground"],
    setter = "SetForegroundDesaturated",
    type = "bool",
  },
  desaturateBackground = {
    display = L["Desaturate Background"],
    setter = "SetBackgroundDesaturated",
    type = "bool",
  },
  foregroundColor = {
    display = L["Foreground Color"],
    setter = "Color",
    type = "color"
  },
  backgroundColor = {
    display = L["Background Color"],
    setter = "SetBackgroundColor",
    type = "color"
  },
  width = {
    display = L["Width"],
    setter = "SetRegionWidth",
    type = "number",
    min = 1,
    softMax = screenWidth,
    bigStep = 1,
    default = 32
  },
  height = {
    display = L["Height"],
    setter = "SetRegionHeight",
    type = "number",
    min = 1,
    softMax = screenHeight,
    bigStep = 1,
    default = 32
  },
}

WeakAuras.regionPrototype.AddProperties(properties, default);

local spinnerFunctions = {};

function spinnerFunctions.SetTexture(self, texture)
  for i = 1, 4 do
    self.textures[i]:SetTexture(texture);
  end
  self.wedge:SetTexture(texture);
end

function spinnerFunctions.SetDesaturated(self, desaturate)
  for i = 1, 4 do
    self.textures[i]:SetDesaturated(desaturate);
  end
  self.wedge:SetDesaturated(desaturate);
end

function spinnerFunctions.SetBlendMode(self, blendMode)
  for i = 1, 4 do
    self.textures[i]:SetBlendMode(blendMode);
  end
  self.wedge:SetBlendMode(blendMode);
end

function spinnerFunctions.Show(self)
  for i = 1, 4 do
    self.textures[i]:Show();
  end
  self.wedge:Show();
end

function spinnerFunctions.Hide(self)
  for i = 1, 4 do
    self.textures[i]:Hide();
  end
  self.wedge:Hide();
end

function spinnerFunctions.Color(self, r, g, b, a)
  for i = 1, 4 do
    self.textures[i]:SetVertexColor(r, g, b, a);
  end
  self.wedge:SetVertexColor(r, g, b, a);
end

function spinnerFunctions.SetBackgroundOffset(self, region, offset)
  self.offset = offset;
  self.textures[1]:SetPoint("TOPRIGHT", region, offset, offset)
  self.textures[2]:SetPoint("BOTTOMRIGHT", region, offset, -offset)
  self.textures[3]:SetPoint("BOTTOMLEFT", region, -offset, -offset)
  self.textures[4]:SetPoint("TOPLEFT", region, -offset, offset)
end

function spinnerFunctions:SetHeight(height)
  self.wedge:SetHeight(height);
end

function spinnerFunctions:SetWidth(width)
  self.wedge:SetWidth(width);
end

local function betweenAngles(low, high, needle1, needle2)
  if (low <= needle1 and needle1 <= high
    and low <= needle2 and needle2 <= high) then
    return true;
  end

  needle1 = needle1 + 360;
  needle2 = needle2 + 360;
  if (low <= needle1 and needle1 <= high
    and low <= needle2 and needle2 <= high) then
    return true;
  end
  return false;
end

local function animRotate(object, degrees, anchor, regionRotate, aspect)
  if (not anchor) then
    anchor = "CENTER";
  end

  object.degrees = degrees;
  object.regionRotate = regionRotate;
  object.aspect = aspect;

  -- Something to rotate
  -- Create AnimationGroup and rotation animation
  if (not object.animationGroup) then
    object.animationGroup = object:CreateAnimationGroup();
    object.animationGroup:SetLooping("REPEAT")
  end

  object.animationGroup.rotate = object.animationGroup.rotate or object.animationGroup:CreateAnimation("rotation");

  local rotate = object.animationGroup.rotate;
  rotate:SetOrigin(anchor, 0, 0);
  rotate:SetDegrees(degrees);
  rotate:SetDuration( 0 );
  rotate:SetEndDelay(15); -- 2147483647
  Transform(object, -0.5, -0.5, -degrees + regionRotate, aspect)
  object.animationGroup:Play();
end

function spinnerFunctions.SetProgress(self, region, startAngle, endAngle, progress, clockwise)
  local pAngle = (endAngle - startAngle) * progress + startAngle;

  -- Show/hide necessary textures if we need to
  for i = 1, 4 do
    local quadrantAngle1;
    local quadrantAngle2;

    if (clockwise) then
      quadrantAngle2 = i * 90;
      quadrantAngle1 = quadrantAngle2 - 90;
    else
      quadrantAngle2 = (5 - i) * 90;
      quadrantAngle1 = quadrantAngle2 - 90;
    end

    if clockwise then
      if betweenAngles(startAngle, pAngle, quadrantAngle1, quadrantAngle2) then
        self.textures[i]:Show()
      else
        self.textures[i]:Hide()
      end
    else
      if betweenAngles(startAngle, pAngle, quadrantAngle1, quadrantAngle2) then
        self.textures[i]:Show()
      else
        self.textures[i]:Hide()
      end
    end
  end

  -- Move scrollframe/wedge to the proper quadrant
  local quadrant = floor(pAngle % 360 / 90) + 1;
  if (not clockwise) then
    quadrant = 5 - quadrant;
  end
  self.scrollframe:Hide();
  self.scrollframe:SetAllPoints(self.textures[quadrant])
  self.scrollframe:Show();

  local ULx, ULy = ApplyTransform(0, 0, region)
  local LLx, LLy = ApplyTransform(0, 1, region)
  local URx, URy = ApplyTransform(1, 0, region)
  local LRx, LRy = ApplyTransform(1, 1, region)

  local Lx, Ly = ApplyTransform(0, 0.5, region)
  local Tx, Ty = ApplyTransform(0.5, 0, region)
  local Bx, By = ApplyTransform(0.5, 1, region)
  local Rx, Ry = ApplyTransform(1, 0.5, region)
  local Cx, Cy = ApplyTransform(0.5, 0.5, region)

  self.textures[1]:SetTexCoord(Tx, Ty, Cx, Cy, URx, URy, Rx, Ry);
  self.textures[2]:SetTexCoord(Cx, Cy, Bx, By, Rx, Ry, LRx, LRy);
  self.textures[3]:SetTexCoord(Lx, Ly, LLx, LLy, Cx, Cy, Bx, By);
  self.textures[4]:SetTexCoord(ULx, ULy, Lx, Ly, Tx, Ty, Cx, Cy);

  local degree = pAngle;
  if not clockwise then degree = -degree + 90 end

  animRotate(self.wedge, -degree, "BOTTOMRIGHT", region.rotation, region.aspect);
end

local function createSpinner(parent, layer, frameLevel)
  -- For circular progress
  local scrollframe = CreateFrame("ScrollFrame", nil, parent)
  scrollframe:SetPoint("BOTTOMLEFT", parent, "CENTER")
  scrollframe:SetPoint("TOPRIGHT")
  scrollframe:SetFrameLevel(frameLevel);

  local scrollchild = CreateFrame("Frame", nil, scrollframe)
  scrollframe:SetScrollChild(scrollchild)
  scrollchild:SetAllPoints(scrollframe)
  scrollchild:SetFrameLevel(frameLevel);

  -- Wedge thing
  local wedge = scrollchild:CreateTexture(nil, layer)
  wedge:SetPoint("BOTTOMRIGHT", parent, "CENTER")

  -- Top Right
  local trTexture = parent:CreateTexture(nil, layer)
  trTexture:SetPoint("BOTTOMLEFT", parent, "CENTER")
  trTexture:SetPoint("TOPRIGHT")
  trTexture:SetTexCoord(0.5, 1, 0, 0.5)

  -- Bottom Right
  local brTexture = parent:CreateTexture(nil, layer)
  brTexture:SetPoint("TOPLEFT", parent, "CENTER")
  brTexture:SetPoint("BOTTOMRIGHT")
  brTexture:SetTexCoord(0.5, 1, 0.5, 1)

  -- Bottom Left
  local blTexture = parent:CreateTexture(nil, layer)
  blTexture:SetPoint("TOPRIGHT", parent, "CENTER")
  blTexture:SetPoint("BOTTOMLEFT")
  blTexture:SetTexCoord(0, 0.5, 0.5, 1)

  -- Top Left
  local tlTexture = parent:CreateTexture(nil, layer)
  tlTexture:SetPoint("BOTTOMRIGHT", parent, "CENTER")
  tlTexture:SetPoint("TOPLEFT")
  tlTexture:SetTexCoord(0, 0.5, 0, 0.5)

  -- /4|1\ -- Clockwise texture arrangement
  -- \3|2/ --

  local spinner = {};

  spinner.scrollframe = scrollframe
  spinner.wedge = wedge
  spinner.textures = {trTexture, brTexture, blTexture, tlTexture}

  for k, v in pairs(spinnerFunctions) do
    spinner[k] = v;
  end

  return spinner;
end

-- Make available for the thumbnail display
WeakAuras.createSpinner = createSpinner;

local function create(parent)
  local font = "GameFontHighlight";

  local region = CreateFrame("FRAME", nil, parent);
  region:SetMovable(true);
  region:SetResizable(true);
  region:SetMinResize(1, 1);

  local background = region:CreateTexture(nil, "BACKGROUND");
  region.background = background;

  -- For horizontal/vertical progress
  local foreground = region:CreateTexture(nil, "ARTWORK");
  region.foreground = foreground;

  region.foregroundSpinner = createSpinner(region, "ARTWORK", parent:GetFrameLevel() + 2);
  region.backgroundSpinner = createSpinner(region, "BACKGROUND", parent:GetFrameLevel() + 1);

  region.values = {};

  region.duration = 0;
  region.expirationTime = math.huge;

  WeakAuras.regionPrototype.create(region);

  region.AnchorSubRegion = WeakAuras.regionPrototype.AnchorSubRegion

  return region;
end

local function TimerTick(self)
  local adjustMin = self.adjustedMin or self.adjustedMinRel or 0;
  local duration = self.state.duration
  self:SetTime( (duration ~= 0 and (self.adjustedMax or self.adjustedMaxRel) or duration) - adjustMin, self.state.expirationTime - adjustMin, self.state.inverse);
end

local function modify(parent, region, data)
  WeakAuras.regionPrototype.modify(parent, region, data);

  local background, foreground = region.background, region.foreground;
  local foregroundSpinner, backgroundSpinner = region.foregroundSpinner, region.backgroundSpinner;

  region:SetWidth(data.width);
  region:SetHeight(data.height);
  region.width = data.width;
  region.height = data.height;
  region.scalex = 1;
  region.scaley = 1;
  region.aspect =  data.width / data.height;
  foreground:SetWidth(data.width);
  foreground:SetHeight(data.height);
  local scaleWedge =  1 / 1.4142 * (1 + (data.crop or 0.41));
  foregroundSpinner:SetWidth(data.width * scaleWedge);
  foregroundSpinner:SetHeight(data.height * scaleWedge);
  backgroundSpinner:SetWidth((data.width + data.backgroundOffset * 2) * scaleWedge);
  backgroundSpinner:SetHeight((data.height + data.backgroundOffset * 2) * scaleWedge);

  region:ClearAllPoints();
  WeakAuras.AnchorFrame(data, region, parent)
  region:SetAlpha(data.alpha);

  background:SetTexture(data.sameTexture and data.foregroundTexture or data.backgroundTexture);
  background:SetDesaturated(data.desaturateBackground)
  background:SetVertexColor(data.backgroundColor[1], data.backgroundColor[2], data.backgroundColor[3], data.backgroundColor[4]);
  background:SetBlendMode(data.blendMode);

  backgroundSpinner:SetTexture(data.sameTexture and data.foregroundTexture or data.backgroundTexture);
  backgroundSpinner:SetDesaturated(data.desaturateBackground)
  backgroundSpinner:Color(data.backgroundColor[1], data.backgroundColor[2], data.backgroundColor[3], data.backgroundColor[4]);
  backgroundSpinner:SetBlendMode(data.blendMode);

  foreground:SetTexture(data.foregroundTexture);
  foreground:SetDesaturated(data.desaturateForeground)
  foreground:SetBlendMode(data.blendMode);

  foregroundSpinner:SetTexture(data.foregroundTexture);
  foregroundSpinner:SetDesaturated(data.desaturateForeground);
  foregroundSpinner:SetBlendMode(data.blendMode);

  background:ClearAllPoints();
  foreground:ClearAllPoints();
  background:SetPoint("BOTTOMLEFT", region, "BOTTOMLEFT", -1 * data.backgroundOffset, -1 * data.backgroundOffset);
  background:SetPoint("TOPRIGHT", region, "TOPRIGHT", data.backgroundOffset, data.backgroundOffset);
  backgroundSpinner:SetBackgroundOffset(region, data.backgroundOffset);

  region.mirror_h = data.mirror;
  region.scale_x = 1 + (data.crop_x or 0.41);
  region.scale_y = 1 + (data.crop_y or 0.41);
  region.scale = 1 + (data.crop or 0.41);
  region.rotation = data.rotation or 0;
  region.cos_rotation = cos(region.rotation);
  region.sin_rotation = sin(region.rotation);
  region.user_x = -1 * (data.user_x or 0);
  region.user_y = data.user_y or 0;

  region.startAngle = data.startAngle or 0;
  region.endAngle = data.endAngle or 360;

  local function orientHorizontal()
    foreground:ClearAllPoints();
    foreground:SetPoint("LEFT", region, "LEFT");
    region.orientation = "HORIZONTAL_INVERSE";
    if(data.compress) then
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx, ULy = ApplyTransform(0, 0, region)
        local LLx, LLy = ApplyTransform(0, 1, region)
        local URx, URy = ApplyTransform(1, 0, region)
        local LRx, LRy = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetWidth(region:GetWidth() * progress);
        background:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
      end
    else
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx , ULy  = ApplyTransform(0, 0, region)
        local LLx , LLy  = ApplyTransform(0, 1, region)
        local URx , URy  = ApplyTransform(progress, 0, region)
        local URx_, URy_ = ApplyTransform(1, 0, region)
        local LRx , LRy  = ApplyTransform(progress, 1, region)
        local LRx_, LRy_ = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx , URy , LRx , LRy );
        foreground:SetWidth(region:GetWidth() * progress);
        background:SetTexCoord(ULx, ULy, LLx, LLy, URx_, URy_, LRx_, LRy_);
      end
    end
  end
  local function orientHorizontalInverse()
    foreground:ClearAllPoints();
    foreground:SetPoint("RIGHT", region, "RIGHT");
    region.orientation = "HORIZONTAL";
    if(data.compress) then
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx, ULy = ApplyTransform(0, 0, region)
        local LLx, LLy = ApplyTransform(0, 1, region)
        local URx, URy = ApplyTransform(1, 0, region)
        local LRx, LRy = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetWidth(region:GetWidth() * progress);
        background:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
      end
    else
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx , ULy  = ApplyTransform(1-progress, 0, region)
        local ULx_, ULy_ = ApplyTransform(0, 0, region)
        local LLx , LLy  = ApplyTransform(1-progress, 1, region)
        local LLx_, LLy_ = ApplyTransform(0, 1, region)
        local URx , URy  = ApplyTransform(1, 0, region)
        local LRx , LRy  = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx , ULy , LLx , LLy , URx, URy, LRx, LRy);
        foreground:SetWidth(region:GetWidth() * progress);
        background:SetTexCoord(ULx_, ULy_, LLx_, LLy_, URx, URy, LRx, LRy);
      end
    end
  end
  local function orientVertical()
    foreground:ClearAllPoints();
    foreground:SetPoint("BOTTOM", region, "BOTTOM");
    region.orientation = "VERTICAL_INVERSE";
    if(data.compress) then
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx, ULy = ApplyTransform(0, 0, region)
        local LLx, LLy = ApplyTransform(0, 1, region)
        local URx, URy = ApplyTransform(1, 0, region)
        local LRx, LRy = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetHeight(region:GetHeight() * progress);
        background:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
      end
    else
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx , ULy  = ApplyTransform(0, 1 - progress, region)
        local ULx_, ULy_ = ApplyTransform(0, 0, region)
        local LLx , LLy  = ApplyTransform(0, 1, region)
        local URx , URy  = ApplyTransform(1, 1 - progress, region)
        local URx_, URy_ = ApplyTransform(1, 0, region)
        local LRx , LRy  = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetHeight(region:GetHeight() * progress);
        background:SetTexCoord(ULx_, ULy_, LLx, LLy, URx_, URy_, LRx, LRy);
      end
    end
  end
  local function orientVerticalInverse()
    foreground:ClearAllPoints();
    foreground:SetPoint("TOP", region, "TOP");
    region.orientation = "VERTICAL";
    if(data.compress) then
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx, ULy = ApplyTransform(0, 0, region)
        local LLx, LLy = ApplyTransform(0, 1, region)
        local URx, URy = ApplyTransform(1, 0, region)
        local LRx, LRy = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetHeight(region:GetHeight() * progress);
        background:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
      end
    else
      function region:SetValueOnTexture(progress)
        region.progress = progress;

        local ULx , ULy  = ApplyTransform(0, 0, region)
        local LLx , LLy  = ApplyTransform(0, progress, region)
        local LLx_, LLy_ = ApplyTransform(0, 1, region)
        local URx , URy  = ApplyTransform(1, 0, region)
        local LRx , LRy  = ApplyTransform(1, progress, region)
        local LRx_, LRy_ = ApplyTransform(1, 1, region)

        foreground:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy);
        foreground:SetHeight(region:GetHeight() * progress);
        background:SetTexCoord(ULx, ULy, LLx_, LLy_, URx, URy, LRx_, LRy_);
      end
    end
  end

  local function orientCircular(clockwise)
    local startAngle = region.startAngle % 360; -- Convert 360 to 0
    local endAngle = region.endAngle % 360;

    if (data.inverse) then
      clockwise = not clockwise;
      startAngle = 360 - startAngle;
      endAngle = 360 - endAngle;
    end
    if (endAngle <= startAngle) then
      endAngle = endAngle + 360;
    end

    -- start is now 0-359, end 1-719, but at most 360 difference

    region.orientation = clockwise and "CLOCKWISE" or "ANTICLOCKWISE";

    backgroundSpinner:SetProgress(region, startAngle, endAngle, 1, clockwise);

    function region:SetValueOnTexture(progress)
      progress = progress or 0;
      region.progress = progress;
      if (progress < 0) then
        progress = 0;
      end

      if (progress > 1) then
        progress = 1;
      end
      foregroundSpinner:SetProgress(region, startAngle, endAngle, progress, clockwise);
    end
  end

  local function showCircularProgress()
    foreground:Hide();
    background:Hide();
    foregroundSpinner:Show();
    backgroundSpinner:Show();
  end

  local function hideCircularProgress()
    foreground:Show();
    background:Show();
    foregroundSpinner:Hide();
    backgroundSpinner:Hide();
  end

  if(data.orientation == "HORIZONTAL_INVERSE") then
    hideCircularProgress();
    orientHorizontalInverse();
  elseif(data.orientation == "HORIZONTAL") then
    hideCircularProgress();
    orientHorizontal();
  elseif(data.orientation == "VERTICAL_INVERSE") then
    hideCircularProgress();
    orientVerticalInverse();
  elseif(data.orientation == "VERTICAL") then
    hideCircularProgress();
    orientVertical();
  elseif(data.orientation == "CLOCKWISE") then
    showCircularProgress();
    orientCircular(true);
  elseif(data.orientation == "ANTICLOCKWISE") then
    showCircularProgress();
    orientCircular(false);
  end

  region:SetValueOnTexture(0.667);

  function region:Scale(scalex, scaley)
    region.scalex = scalex;
    region.scaley = scaley;
    foreground:ClearAllPoints();
    if(scalex < 0) then
      region.mirror_h = not data.mirror;
      scalex = scalex * -1;
    else
      region.mirror_h = data.mirror;
    end
    if(region.mirror_h) then
      if(data.orientation == "HORIZONTAL_INVERSE") then
        foreground:SetPoint("RIGHT", region, "RIGHT");
      elseif(data.orientation == "HORIZONTAL") then
        foreground:SetPoint("LEFT", region, "LEFT");
      end
    else
      if(data.orientation == "HORIZONTAL") then
        foreground:SetPoint("LEFT", region, "LEFT");
      elseif(data.orientation == "HORIZONTAL_INVERSE") then
        foreground:SetPoint("RIGHT", region, "RIGHT");
      end
    end
    if(scaley < 0) then
      region.mirror_v = true;
      scaley = scaley * -1;
      if(data.orientation == "VERTICAL_INVERSE") then
        foreground:SetPoint("TOP", region, "TOP");
      elseif(data.orientation == "VERTICAL") then
        foreground:SetPoint("BOTTOM", region, "BOTTOM");
      end
    else
      region.mirror_v = nil;
      if(data.orientation == "VERTICAL") then
        foreground:SetPoint("BOTTOM", region, "BOTTOM");
      elseif(data.orientation == "VERTICAL_INVERSE") then
        foreground:SetPoint("TOP", region, "TOP");
      end
    end

    region:SetWidth(region.width * scalex);
    region:SetHeight(region.height * scaley);

    local scaleWedge =  1 / 1.4142 * (1 + (data.crop or 0.41));
    foregroundSpinner:SetWidth(region.width * scaleWedge * scalex);
    foregroundSpinner:SetHeight(region.height * scaleWedge * scaley);
    backgroundSpinner:SetWidth((region.width + data.backgroundOffset * 2) * scaleWedge * scalex);
    backgroundSpinner:SetHeight((region.height + data.backgroundOffset * 2) * scaleWedge * scaley);

    if(data.orientation == "HORIZONTAL_INVERSE" or data.orientation == "HORIZONTAL") then
      foreground:SetWidth(region.width * scalex * (region.progress or 1));
      foreground:SetHeight(region.height * scaley);
    else
      foreground:SetWidth(region.width * scalex);
      foreground:SetHeight(region.height * scaley * (region.progress or 1));
    end
    background:SetPoint("BOTTOMLEFT", region, "BOTTOMLEFT", -1 * scalex * data.backgroundOffset, -1 * scaley * data.backgroundOffset);
    background:SetPoint("TOPRIGHT", region, "TOPRIGHT", scalex * data.backgroundOffset, scaley * data.backgroundOffset);
  end

  function region:Rotate(angle)
    region.rotation = angle or 0;
    region.cos_rotation = cos(region.rotation);
    region.sin_rotation = sin(region.rotation);
    region:SetValueOnTexture(region.progress);
  end

  function region:GetRotation()
    return region.rotation;
  end

  function region:Color(r, g, b, a)
    region.color_r = r;
    region.color_g = g;
    region.color_b = b;
    if (r or g or b) then
      a = a or 1;
    end
    region.color_a = a;
    foreground:SetVertexColor(region.color_anim_r or r, region.color_anim_g or g, region.color_anim_b or b, region.color_anim_a or a);
    foregroundSpinner:Color(region.color_anim_r or r, region.color_anim_g or g, region.color_anim_b or b, region.color_anim_a or a);
  end

  function region:ColorAnim(r, g, b, a)
    region.color_anim_r = r;
    region.color_anim_g = g;
    region.color_anim_b = b;
    region.color_anim_a = a;
    if (r or g or b) then
      a = a or 1;
    end
    foreground:SetVertexColor(r or region.color_r, g or region.color_g, b or region.color_b, a or region.color_a);
    foregroundSpinner:Color(r or region.color_r, g or region.color_g, b or region.color_b, a or region.color_a);
  end

  function region:GetColor()
    return region.color_r or data.foregroundColor[1], region.color_g or data.foregroundColor[2],
      region.color_b or data.foregroundColor[3], region.color_a or data.foregroundColor[4];
  end

  region:Color(data.foregroundColor[1], data.foregroundColor[2], data.foregroundColor[3], data.foregroundColor[4]);

  function region:SetTime(duration, expirationTime, inverse)
    local progress = 1;
    if (duration ~= 0) then
      local remaining = expirationTime - GetTime();
      progress = remaining / duration;
      local inversed = (not inverse and region.inverseDirection) or (inverse and not region.inverseDirection);
      if(inversed) then
        progress = 1 - progress;
      end
    end

    progress = progress > 0.0001 and progress or 0.0001;
    region:SetValueOnTexture(progress);
  end

  function region:SetValue(value, total)
    local progress = 1
    if(total > 0) then
      progress = value / total;
      if(region.inverseDirection) then
        progress = 1 - progress;
      end
    end
    progress = progress > 0.0001 and progress or 0.0001;
    region:SetValueOnTexture(progress);
  end

  function region:Update()
    local state = region.state

    local max
    if state.progressType == "timed" then
      local expirationTime = state.expirationTime and state.expirationTime > 0 and state.expirationTime or math.huge;
      local duration = state.duration or 0
      if region.adjustedMinRelPercent then
        region.adjustedMinRel = region.adjustedMinRelPercent * duration
      end
      local adjustMin = region.adjustedMin or region.adjustedMinRel or 0;
      if duration == 0 then
        max = 0
      elseif region.adjustedMax then
        max = region.adjustedMax
      elseif region.adjustedMaxRelPercent then
        region.adjustedMaxRel = region.adjustedMaxRelPercent * duration
        max = region.adjustedMaxRel
      else
        max = duration
      end

      region:SetTime(max - adjustMin, expirationTime - adjustMin, state.inverse);
      if not region.TimerTick then
        region.TimerTick = TimerTick
        region:UpdateRegionHasTimerTick()
      end
    elseif state.progressType == "static" then
      local value = state.value or 0;
      local total = state.total or 0;
      if region.adjustedMinRelPercent then
        region.adjustedMinRel = region.adjustedMinRelPercent * total
      end
      local adjustMin = region.adjustedMin or region.adjustedMinRel or 0;

      if region.adjustedMax then
        max = region.adjustedMax
      elseif region.adjustedMaxRelPercent then
        region.adjustedMaxRel = region.adjustedMaxRelPercent * total
        max = region.adjustedMaxRel
      else
        max = total
      end

      region:SetValue(value - adjustMin, max - adjustMin);
      if region.TimerTick then
        region.TimerTick = nil
        region:UpdateRegionHasTimerTick()
      end
    else
      region:SetTime(0, math.huge)
      if region.TimerTick then
        region.TimerTick = nil
        region:UpdateRegionHasTimerTick()
      end
    end

    max = max or 0

    if state.texture then
      region:SetTexture(state.texture)
    end
  end

  function region:SetTexture(texture)
    region.currentTexture = texture;
    region.foreground:SetTexture(texture, region.textureWrapMode, region.textureWrapMode);
    foregroundSpinner:SetTexture(texture);
    if (data.sameTexture) then
      background:SetTexture(texture, region.textureWrapMode, region.textureWrapMode);
      backgroundSpinner:SetTexture(texture);
    end
  end

  function region:SetForegroundDesaturated(b)
    region.foreground:SetDesaturated(b);
    region.foregroundSpinner:SetDesaturated(b);
  end

  function region:SetBackgroundDesaturated(b)
    region.background:SetDesaturated(b);
    region.backgroundSpinner:SetDesaturated(b);
  end

  function region:SetBackgroundColor(r, g, b, a)
    region.background:SetVertexColor(r, g, b, a);
    region.backgroundSpinner:Color(r, g, b, a);
  end

  function region:SetRegionWidth(width)
    region.width = width;
    region:Scale(region.scalex, region.scaley);
  end

  function region:SetRegionHeight(height)
    region.height = height;
    region:Scale(region.scalex, region.scaley);
  end

  function region:SetInverse(inverse)
    if (region.inverseDirection == inverse) then
      return;
    end
    region.inverseDirection = inverse;
    local progress = 1 - region.progress;
    progress = progress > 0.0001 and progress or 0.0001;
    region:SetValueOnTexture(progress);
  end

  WeakAuras.regionPrototype.modifyFinish(parent, region, data);
end

WeakAuras.RegisterRegionType("progresstexture", create, modify, default, properties);
