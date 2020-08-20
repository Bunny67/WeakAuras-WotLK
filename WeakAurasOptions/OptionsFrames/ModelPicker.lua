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

  function group.Pick(self, model_path, model_z, model_x, model_y)
    model_path = model_path or self.data.model_path;

    model_z = model_z or self.data.model_z;
    model_x = model_x or self.data.model_x;
    model_y = model_y or self.data.model_y;

    WeakAuras.SetModel(self.model, model_path)

    self.model:SetPosition(model_z, model_x, model_y);
    self.model:SetFacing(rad(self.data.rotation));

    if(not self.parentData and self.data.controlledChildren) then
      for index, childId in pairs(self.data.controlledChildren) do
        local childData = WeakAuras.GetData(childId);
        if(childData) then
          childData.model_path = model_path;
          childData.model_z = model_z;
          childData.model_x = model_x;
          childData.model_y = model_y;
          WeakAuras.Add(childData);
          WeakAuras.UpdateThumbnail(childData);
        end
      end
    else
      self.data.model_path = model_path;
      self.data.model_z = model_z;
      self.data.model_x = model_x;
      self.data.model_y = model_y;

      if self.parentData then
        WeakAuras.Add(self.parentData)
      else
        WeakAuras.Add(self.data);
        WeakAuras.UpdateThumbnail(self.data);
      end
    end
  end

  function group.Open(self, data, parentData)
    self.data = data;
    self.parentData = parentData
    WeakAuras.SetModel(self.model, data.model_path)

    self.model:SetPosition(data.model_z, data.model_x, data.model_y);
    self.model:SetFacing(rad(data.rotation));
    modelPickerZ:SetValue(data.model_z);
    modelPickerZ.editbox:SetText(("%.2f"):format(data.model_z));
    modelPickerX:SetValue(data.model_x);
    modelPickerX.editbox:SetText(("%.2f"):format(data.model_x));
    modelPickerY:SetValue(data.model_y);
    modelPickerY.editbox:SetText(("%.2f"):format(data.model_y));

    modelPickerZ.frame:Show();
    modelPickerY.frame:Show();
    modelPickerX.frame:Show();

    if(not parentData and data.controlledChildren) then
      self.givenModel = {};
      self.givenZ = {};
      self.givenX = {};
      self.givenY = {};
      for index, childId in pairs(data.controlledChildren) do
        local childData = WeakAuras.GetData(childId);
        if(childData) then
          self.givenModel[childId] = childData.model_path;
          self.givenZ[childId] = childData.model_z;
          self.givenX[childId] = childData.model_x;
          self.givenY[childId] = childData.model_y;
        end
      end
    else
      self.givenModel = data.model_path;

      self.givenZ = data.model_z;
      self.givenX = data.model_x;
      self.givenY = data.model_y;
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
    if(not group.parentData and group.data.controlledChildren) then
      for index, childId in pairs(group.data.controlledChildren) do
        local childData = WeakAuras.GetData(childId);
        if(childData) then
          childData.model_path = group.givenModel[childId];
          childData.model_z = group.givenZ[childId];
          childData.model_x = group.givenX[childId];
          childData.model_y = group.givenY[childId];
          WeakAuras.Add(childData);
          WeakAuras.UpdateThumbnail(childData);
        end
      end
    else
      group:Pick(group.givenModel, group.givenZ, group.givenX, group.givenY);
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

function WeakAuras.ModelPicker(frame)
  modelPicker = modelPicker or ConstructModelPicker(frame)
  return modelPicker
end
