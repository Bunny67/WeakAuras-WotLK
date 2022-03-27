if not WeakAuras.IsCorrectVersion() then return end
local AddonName, Private = ...

local SharedMedia = LibStub("LibSharedMedia-3.0");
local L = WeakAuras.L;

Private.barmodels = {}

local default = function(parentType)
  return {
    model_visible = true,
    model_alpha = 1,

    model_x = 0,
    model_y = 0,
    model_z = 0,
    rotation = 0,

    model_path = "Environments/Stars/NexusRaid_RuneEffects_Nebula.m2",
    bar_model_clip = true
  }
end

local properties = {
  model_visible = {
    display = L["Visibility"],
    setter = "SetVisible",
    type = "bool",
    defaultProperty = true
  },
  model_alpha = {
    display = L["Alpha"],
    setter = "SetAlpha",
    type = "number",
    min = 0,
    max = 1,
    bigStep = 0.1
  }
}

local function PreShow(self)
  local data = self.data
  --self:SetKeepModelOnHide(true)
  self:Show()

  -- Adjust model
  self:SetModel(data.model_path)

  self:SetPosition(data.model_z, data.model_x, data.model_y);
  self:SetFacing(0);
  self:SetAlpha(self.region.alpha)
end

local function CreateModel()
  local model =  CreateFrame("PlayerModel", nil, UIParent)
  model.PreShow = PreShow;
  return model
end

-- Keep the two model apis separate
local pool = CreateObjectPool(CreateModel)

local function AcquireModel(region, data)
  local model = pool:Acquire()
  model.data = data
  Private.barmodels[model] = true

  model:ClearAllPoints()

  local anchor
  if region.parentType == "aurabar" then
    anchor = region.parent.bar
  else
    anchor = region.parent
  end

  local extra_width, extra_height = 0, 0
  if not(data.bar_model_clip and region.parentType == "aurabar") then
    extra_width = data.extra_width or 0
    extra_height = data.extra_height or 0
  end

  model:SetPoint("TOPLEFT", anchor ,"TOPLEFT", -extra_width/2, extra_height/2)
  model:SetPoint("BOTTOMRIGHT", anchor ,"BOTTOMRIGHT", extra_width/2, -extra_height/2)

  model:SetParent(region)
  --model:SetKeepModelOnHide(true)
  model:Show()

  -- Adjust model
  model:SetModel(data.model_path)
  model:SetPosition(data.model_z, data.model_x, data.model_y);
  model:SetScript("OnShow", function()
    model:SetModel(data.model_path)
    model:SetPosition(data.model_z, data.model_x, data.model_y);
  end)
  model:SetFacing(0);

  return model
end

local function ReleaseModel(model)
  --model:SetKeepModelOnHide(false)
  model:Hide()
  pool:Release(model)
  Private.barmodels[model] = nil
end

local funcs = {
  SetVisible = function(self, visible)
    self.visible = visible
    self:UpdateVisible()
  end,
  SetAlpha = function(self, alpha)
    if self.model then
      self.model:SetAlpha(alpha)
    end
    self.alpha = alpha
  end,
  AlphaChanged = function(self)
    self:SetAlpha(self.alpha)
  end,
  UpdateVisible = function(self)
    local effectiveVisible = self.parent_visible and self.visible and not self.toosmall
    if effectiveVisible then
      if not self.model then
        self.model = AcquireModel(self, self.data)
        self.model:SetAlpha(self.alpha)
        self.model.region = self
      end
    else
      if self.model then
        ReleaseModel(self.model)
        self.model = nil
      end
    end
  end,
  PreShow = function(self)
    self.parent_visible = true
    self:UpdateVisible()
  end,
  PreHide = function(self)
    self.parent_visible = false
    self:UpdateVisible()
  end,
  OnSizeChanged = function(self)
    -- WORKAROUND clipping being broken on the SL beta with some setups with bars of zero width
    if self:GetWidth() < 1 or self:GetHeight() < 1 then
      self.toosmall = true
    else
      self.toosmall = false
    end
    self:UpdateVisible()
  end
}

local function create()
  local subRegion = CreateFrame("FRAME", nil, UIParent)
  --subRegion:SetClipsChildren(true)

  for k, v in pairs(funcs) do
    subRegion[k] = v
  end

  subRegion:SetScript("OnSizeChanged", subRegion.OnSizeChanged)
  return subRegion
end

local function onAcquire(subRegion)
  subRegion:Show()
end

local function onRelease(subRegion)
  subRegion:Hide()
end



local function modify(parent, region, parentData, data, first)
  if region.model then
    ReleaseModel(region.model)
    region.model = nil
  end

  region.data = data
  region.parentType = parentData.regionType
  region.parent = parent

  region:SetParent(parent)

  local anchor
  if parentData.regionType == "aurabar" then
    if data.bar_model_clip then
      anchor = parent.bar.fgFrame
    else
      anchor = parent.bar
    end
  else
    anchor = parent
  end

  local extra_width, extra_height = 0, 0
  if not(data.bar_model_clip and parentData.regionType == "aurabar") then
    extra_width = data.extra_width or 0
    extra_height = data.extra_height or 0
  end

  region:SetPoint("TOPLEFT", anchor ,"TOPLEFT", -extra_width/2, extra_height/2)
  region:SetPoint("BOTTOMRIGHT", anchor ,"BOTTOMRIGHT", extra_width/2, -extra_height/2)

  region:SetAlpha(data.model_alpha)
  region:SetVisible(data.model_visible)

  parent.subRegionEvents:AddSubscriber("AlphaChanged", region)
  parent.subRegionEvents:AddSubscriber("PreShow", region)
  parent.subRegionEvents:AddSubscriber("PreHide", region)
end

local function supports(regionType)
  return regionType == "texture"
         or regionType == "progresstexture"
         or regionType == "icon"
         or regionType == "aurabar"
         or regionType == "text"
end

WeakAuras.RegisterSubRegionType("submodel", L["Model"], supports, create, modify, onAcquire, onRelease, default, nil, properties);
