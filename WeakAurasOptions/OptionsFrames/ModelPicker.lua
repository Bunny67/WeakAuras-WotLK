if not WeakAuras.IsCorrectVersion() then return end
local AddonName, OptionsPrivate = ...

-- Lua APIs
local pairs, rad = pairs, rad

-- WoW APIs
local CreateFrame = CreateFrame

local AceGUI = LibStub("AceGUI-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local WeakAuras = WeakAuras
local L = WeakAuras.L

local modelPicker

local function GetAll(baseObject, path, property, default)
  local valueFromPath = OptionsPrivate.Private.ValueFromPath
  if not property then
    return default
  end
  if baseObject.controlledChildren then
    local result
    local first = true
    for index, childId in pairs(baseObject.controlledChildren) do
      local childData = WeakAuras.GetData(childId)
      local childObject = valueFromPath(childData, path)
      if childObject and childObject[property] then
        if first then
          result = childObject[property]
          first = false
        else
          if result ~= childObject[property] then
            return default
          end
        end
      end
    end
    return result
  else
    local object = valueFromPath(baseObject, path)
    if object and object[property] then
      return object[property]
    end
    return default
  end
end

local function ConstructModelPicker(frame)
  local group = AceGUI:Create("InlineGroup");
  group.frame:SetParent(frame);
  group.frame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -17, 87);
  group.frame:SetPoint("TOPLEFT", frame, "TOPLEFT", 17, -10);
  group.frame:Hide();
  group:SetLayout("flow");

  local modelPickerZ = AceGUI:Create("Slider");
  modelPickerZ:SetSliderValues(-20, 20, 0.05);
  modelPickerZ:SetLabel(L["Z Offset"]);
  modelPickerZ.frame:SetParent(group.frame);
  modelPickerZ:SetCallback("OnValueChanged", function()
    group:Pick(nil, modelPickerZ:GetValue());
  end);

  local modelPickerX = AceGUI:Create("Slider");
  modelPickerX:SetSliderValues(-20, 20, 0.05);
  modelPickerX:SetLabel(L["X Offset"]);
  modelPickerX.frame:SetParent(group.frame);
  modelPickerX:SetCallback("OnValueChanged", function()
    group:Pick(nil, nil, modelPickerX:GetValue());
  end);

  local modelPickerY = AceGUI:Create("Slider");
  modelPickerY:SetSliderValues(-20, 20, 0.05);
  modelPickerY:SetLabel(L["Y Offset"]);
  modelPickerY.frame:SetParent(group.frame);
  modelPickerY:SetCallback("OnValueChanged", function()
    group:Pick(nil, nil, nil, modelPickerY:GetValue());
  end);

  local modelTree = AceGUI:Create("WeakAurasTreeGroup");
  group.modelTree = modelTree;
  group.frame:SetScript("OnUpdate", function()
    local frameWidth = frame:GetWidth();
    local sliderWidth = (frameWidth - 50) / 3;
    local narrowSliderWidth = (frameWidth - 50) / 7;

    modelTree:SetTreeWidth(frameWidth - 370);

    modelPickerZ.frame:SetPoint("bottomleft", frame, "bottomleft", 15, 43);
    modelPickerZ.frame:SetPoint("bottomright", frame, "bottomleft", 15 + sliderWidth, 43);

    modelPickerX.frame:SetPoint("bottomleft", frame, "bottomleft", 25 + sliderWidth, 43);
    modelPickerX.frame:SetPoint("bottomright", frame, "bottomleft", 25 + (2 * sliderWidth), 43);

    modelPickerY.frame:SetPoint("bottomleft", frame, "bottomleft", 35 + (2 * sliderWidth), 43);
    modelPickerY.frame:SetPoint("bottomright", frame, "bottomleft", 35 + (3 * sliderWidth), 43);
  end);
  group:SetLayout("fill");
  modelTree:SetTree(WeakAuras.ModelPaths);
  modelTree:SetCallback("OnGroupSelected", function(self, event, value, fileId)
    local path = string.gsub(value, "\001", "/");
    if(string.lower(string.sub(path, -3, -1)) == ".m2") then
      group:Pick(path, fileId);
    end
  end);
  group:AddChild(modelTree);

  local model = CreateFrame("PlayerModel", nil, group.content);
  model:SetAllPoints(modelTree.content);
  model:SetFrameStrata("FULLSCREEN");
  group.model = model;

  local function SetOnObject(object, model_path, model_z, model_x, model_y)
    if model_path then
      object.model_path = model_path
    end
    if model_z then
      object.model_z = model_z
    end
    if model_x then
      object.model_x = model_x
    end
    if model_y then
      object.model_y = model_y
    end
  end

  function group.Pick(self, model_path, model_z, model_x, model_y)
    local valueFromPath = OptionsPrivate.Private.ValueFromPath

    self.selectedValues.model_path = model_path or self.selectedValues.model_path
    self.selectedValues.model_x = model_x or self.selectedValues.model_x
    self.selectedValues.model_y = model_y or self.selectedValues.model_y
    self.selectedValues.model_z = model_z or self.selectedValues.model_z

    WeakAuras.SetModel(self.model, self.selectedValues.model_path)

    self.model:SetPosition(self.selectedValues.model_z, self.selectedValues.model_x, self.selectedValues.model_y);
    self.model:SetFacing(rad(self.selectedValues.rotation));

    if(self.baseObject.controlledChildren) then
      for index, childId in pairs(self.baseObject.controlledChildren) do
        local childData = WeakAuras.GetData(childId)
        local object = valueFromPath(childData, self.path)
        if(object) then
          SetOnObject(object, model_path, model_z, model_x, model_y)
          WeakAuras.Add(childData)
          WeakAuras.UpdateThumbnail(childData)
        end
      end
    else
      local object = valueFromPath(self.baseObject, self.path)
      if object then
        SetOnObject(object, model_path, model_z, model_x, model_y)
        WeakAuras.Add(self.baseObject)
        WeakAuras.UpdateThumbnail(self.baseObject)
      end
    end
  end

  function group.Open(self, baseObject, path)
    local valueFromPath = OptionsPrivate.Private.ValueFromPath

    self.baseObject = baseObject
    self.path = path
    self.selectedValues = {}

    self.selectedValues.model_path = GetAll(baseObject, path, "model_path", "spells/arcanepower_state_chest.m2")

    WeakAuras.SetModel(self.model, self.selectedValues.model_path)

    self.selectedValues.model_x = GetAll(baseObject, path, "model_x", 0)
    self.selectedValues.model_y = GetAll(baseObject, path, "model_y", 0)
    self.selectedValues.model_z = GetAll(baseObject, path, "model_z", 0)
    self.selectedValues.rotation = GetAll(baseObject, path, "rotation", 0)

    self.model:SetPosition(self.selectedValues.model_z, self.selectedValues.model_x, self.selectedValues.model_y);
    self.model:SetFacing(rad(self.selectedValues.rotation));
    modelPickerZ:SetValue(self.selectedValues.model_z);
    modelPickerZ.editbox:SetText(("%.2f"):format(self.selectedValues.model_z));
    modelPickerX:SetValue(self.selectedValues.model_x);
    modelPickerX.editbox:SetText(("%.2f"):format(self.selectedValues.model_x));
    modelPickerY:SetValue(self.selectedValues.model_y);
    modelPickerY.editbox:SetText(("%.2f"):format(self.selectedValues.model_y));

    if(baseObject.controlledChildren) then
      self.givenModel = {};
      self.givenZ = {};
      self.givenX = {};
      self.givenY = {};
      for index, childId in pairs(baseObject.controlledChildren) do
        local childData = WeakAuras.GetData(childId)
        local object = valueFromPath(childData, path)
        if(object) then
          self.givenModel[childId] = object.model_path;
          self.givenZ[childId] = object.model_z;
          self.givenX[childId] = object.model_x;
          self.givenY[childId] = object.model_y;
        end
      end
    else
      local object = valueFromPath(baseObject, path)

      self.givenModel = object.model_path;
      self.givenZ = object.model_z;
      self.givenX = object.model_x;
      self.givenY = object.model_y;
    end
    frame.window = "model";
    frame:UpdateFrameVisible()
  end

  function group.Close()
    frame.window = "default"
    frame:UpdateFrameVisible()
    WeakAuras.FillOptions()
  end

  function group.CancelClose(self)
    local valueFromPath = OptionsPrivate.Private.ValueFromPath
    if(group.baseObject.controlledChildren) then
      for index, childId in pairs(group.baseObject.controlledChildren) do
        local childData = WeakAuras.GetData(childId);
        local object = valueFromPath(childData, self.path)
        if(object) then
          object.model_path = group.givenModel[childId];
          object.model_z = group.givenZ[childId];
          object.model_x = group.givenX[childId];
          object.model_y = group.givenY[childId];
          WeakAuras.Add(childData);
          WeakAuras.UpdateThumbnail(childData);
        end
      end
    else
      local object = valueFromPath(self.baseObject, self.path)

      if(object) then
        object.model_path = group.givenModel
        object.model_z = group.givenZ
        object.model_x = group.givenX
        object.model_y = group.givenY
        WeakAuras.Add(self.baseObject);
        WeakAuras.UpdateThumbnail(self.baseObject);
      end
    end
    group.Close();
  end

  local cancel = CreateFrame("Button", nil, group.frame, "UIPanelButtonTemplate");
  cancel:SetScript("OnClick", group.CancelClose);
  cancel:SetPoint("bottomright", frame, "bottomright", -27, 16);
  cancel:SetHeight(20);
  cancel:SetWidth(100);
  cancel:SetText(L["Cancel"]);

  local close = CreateFrame("Button", nil, group.frame, "UIPanelButtonTemplate");
  close:SetScript("OnClick", group.Close);
  close:SetPoint("RIGHT", cancel, "LEFT", -10, 0);
  close:SetHeight(20);
  close:SetWidth(100);
  close:SetText(L["Okay"]);

  return group
end

function OptionsPrivate.ModelPicker(frame)
  modelPicker = modelPicker or ConstructModelPicker(frame)
  return modelPicker
end
