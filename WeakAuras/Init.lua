WeakAuras = {}
WeakAuras.L = {}
WeakAuras.frames = {}

WeakAuras.normalWidth = 1.3
WeakAuras.halfWidth = WeakAuras.normalWidth / 2
WeakAuras.doubleWidth = WeakAuras.normalWidth * 2

local versionStringFromToc = GetAddOnMetadata("WeakAuras", "Version")
local versionString = "2.18.0"
local buildTime = "20200802154726"

WeakAuras.versionString = versionStringFromToc
WeakAuras.buildTime = buildTime
WeakAuras.printPrefix = "|cff9900ffWeakAuras:|r "
WeakAuras.newFeatureString = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0|t"
WeakAuras.BuildInfo = select(4, GetBuildInfo())

function WeakAuras.IsClassic()
  return false
end

function WeakAuras.IsCorrectVersion()
  return true
end

WeakAuras.prettyPrint = function(msg)
  print("|cff9900ffWeakAuras:|r " .. msg)
end

if versionString ~= versionStringFromToc and versionStringFromToc ~= "Dev" then
  WeakAuras.prettyPrint("You need to restart your game client to complete the WeakAuras update!")
end

-- Force enable WeakAurasCompanion and Archive because some addon managers interfere with it
EnableAddOn("WeakAurasCompanion")
EnableAddOn("WeakAurasArchive")

--These function stubs are defined here to reduce the number of errors that occur if WeakAuras.lua fails to compile
function WeakAuras.RegisterRegionType()
end

function WeakAuras.RegisterRegionOptions()
end

function WeakAuras.StartProfileSystem()
end

function WeakAuras.StartProfileAura()
end

function WeakAuras.StopProfileSystem()
end

function WeakAuras.StopProfileAura()
end

function WeakAuras.StartProfileUID()
end

function WeakAuras.StopProfileUID()
end

-- If WeakAuras shuts down due to being installed on the wrong target, keep the bindings from erroring
function WeakAuras.StartProfile()
end

function WeakAuras.StopProfile()
end

function WeakAuras.PrintProfile()
end

function WeakAuras.CountWagoUpdates()
  -- XXX this is to work around the Companion app trying to use our stuff!
  return 0
end
