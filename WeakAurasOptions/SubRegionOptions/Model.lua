if not WeakAuras.IsCorrectVersion() then return end
local AddonName, OptionsPrivate = ...

local SharedMedia = LibStub("LibSharedMedia-3.0");
local L = WeakAuras.L;

local function createOptions(parentData, data, index, subIndex)
  local options = {
    __title = L["Model %s"]:format(subIndex),
    __order = 1,
    model_visible = {
      type = "toggle",
      width = WeakAuras.doubleWidth,
      name = L["Show Model"],
      order = 9,
    },
    model_path = {
      type = "input",
      width = WeakAuras.doubleWidth - 0.15,
      name = L["Model"],
      order =  10.5
    },
    chooseModel = {
      type = "execute",
      width = 0.15,
      name = L["Choose"],
      order =  11,
      func = function()
        OptionsPrivate.OpenModelPicker(parentData, {"subRegions", index});
      end,
      imageWidth = 24,
      imageHeight = 24,
      control = "WeakAurasIcon",
      image = "Interface\\AddOns\\WeakAuras\\Media\\Textures\\browse",
    },
    bar_model_clip = {
      type = "toggle",
      width = WeakAuras.doubleWidth,
      name = L["Clipped by Progress"],
      order = 12,
      hidden = function() return parentData.regionType ~= "aurabar" end
    },
    extra_width = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Extra Width"],
      order = 12.1,
      softMin = -100,
      softMax = 500,
      step = 1,
      hidden = function() return data.bar_model_clip and parentData.regionType == "aurabar" end
    },
    extra_height = {
      type = "range",
      width = WeakAuras.normalWidth,
      name = L["Extra Height"],
      order = 12.2,
      softMin = -100,
      softMax = 500,
      step = 1,
      hidden = function() return data.bar_model_clip and parentData.regionType == "aurabar" end
    },
    model_alpha = {
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

  OptionsPrivate.AddUpDownDeleteDuplicate(options, parentData, index, "submodel")

  return options
end

WeakAuras.RegisterSubRegionOptions("submodel", createOptions, L["Shows a model"]);
