if not WeakAuras.IsCorrectVersion() then return end
local AddonName, OptionsPrivate = ...

local SharedMedia = LibStub("LibSharedMedia-3.0");
local L = WeakAuras.L;

local function createOptions(parentData, data, index, subIndex)
  local options = {
    __title = L["Model %s"]:format(subIndex),
    __order = 1,
    __up = function()
      if (OptionsPrivate.Private.ApplyToDataOrChildData(parentData, OptionsPrivate.MoveSubRegionUp, index, "subbarmodel")) then
        WeakAuras.ClearAndUpdateOptions(parentData.id)
      end
    end,
    __down = function()
      if (OptionsPrivate.Private.ApplyToDataOrChildData(parentData, OptionsPrivate.MoveSubRegionDown, index, "subbarmodel")) then
        WeakAuras.ClearAndUpdateOptions(parentData.id)
      end
    end,
    __duplicate = function()
      if (OptionsPrivate.Private.ApplyToDataOrChildData(parentData, OptionsPrivate.DuplicateSubRegion, index, "subbarmodel")) then
        WeakAuras.ClearAndUpdateOptions(parentData.id)
      end
    end,
    __delete = function()
      if (OptionsPrivate.Private.ApplyToDataOrChildData(parentData, WeakAuras.DeleteSubRegion, index, "subbarmodel")) then
        WeakAuras.ClearAndUpdateOptions(parentData.id)
      end
    end,
    bar_model_visible = {
      type = "toggle",
      width = WeakAuras.doubleWidth,
      name = L["Show Model"],
      order = 9,
    },
    model_path = {
      type = "input",
      width = WeakAuras.normalWidth,
      name = L["Model"],
      order =  10
    },
    chooseModel = {
      type = "execute",
      width = WeakAuras.normalWidth,
      name = L["Choose"],
      order =  11,
      func = function()
        OptionsPrivate.OpenModelPicker(data, parentData);
      end,
    },
    bar_model_clip = {
      type = "toggle",
      width = WeakAuras.normalWidth,
      name = L["Clipped by Progress"],
      order = 12,
      hidden = function() return parentData.regionType ~= "aurabar" end
    },
    bar_model_alpha = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Alpha"],
      order = 13,
      min = 0,
      max = 1,
      bigStep = 0.1
    },
    model_z = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Z Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 20,
    },
    model_x = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["X Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 30,
    },
    model_y = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Y Offset"],
      softMin = -20,
      softMax = 20,
      step = .001,
      bigStep = 0.05,
      order = 40,
    },
    rotation = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Rotation"],
      min = 0,
      max = 360,
      step = 1,
      bigStep = 3,
      order = 45,
    },
  }
  return options
end

WeakAuras.RegisterSubRegionOptions("subbarmodel", createOptions, L["Shows a model"]);
