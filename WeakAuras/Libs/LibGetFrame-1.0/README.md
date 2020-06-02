# LibGetFrame

Return unit frame for a given unit

## Usage

```Lua
local LGF = LibStub("LibGetFrame-1.0")
local frame = LGF.GetUnitFrame(unit , options)
```

## Options

- framePriorities : array, default :

```Lua
{
    -- raid frames
    [1] = "^Vd1", -- vuhdo
    [2] = "^Vd2", -- vuhdo
    [3] = "^Vd3", -- vuhdo
    [4] = "^Vd4", -- vuhdo
    [5] = "^Vd5", -- vuhdo
    [6] = "^Vd", -- vuhdo
    [7] = "^HealBot", -- healbot
    [8] = "^GridLayout", -- grid
    [9] = "^Grid2Layout", -- grid2
    [10] = "^ElvUF_RaidGroup", -- elv
    [11] = "^oUF_bdGrid", -- bdgrid
    [12] = "^oUF.*raid", -- generic oUF
    [13] = "^LimeGroup", -- lime
    [14] = "^SUFHeaderraid", -- suf
    [15] = "^CompactRaid", -- blizz
    -- party frames
    [16] = "^SUFHeaderparty", --suf
    [17] = "^ElvUF_PartyGroup", -- elv
    [18] = "^oUF.*party", -- generic oUF
    [19] = "^PitBull4_Groups_Party", -- pitbull4
    [20] = "^CompactParty", -- blizz
    -- player frame
    [21] = "^SUFUnitplayer",
    [22] = "^PitBull4_Frames_Player",
    [23] = "^ElvUF_Player",
    [24] = "^oUF.*player",
    [25] = "^PlayerFrame",
}
```

- ignorePlayerFrame : boolean (default true)
- ignoreTargetFrame : boolean (default true)
- ignoreTargettargetFrame : boolean (default true)
- playerFrames : array, default :

```Lua
{
    "SUFUnitplayer",
    "PitBull4_Frames_Player",
    "ElvUF_Player",
    "oUF_TukuiPlayer",
    "PlayerFrame",
}
```

- targetFrames : array, default :

```Lua
{
    "SUFUnittarget",
    "PitBull4_Frames_Target",
    "ElvUF_Target",
    "TargetFrame",
    "oUF_TukuiTarget",
}
```

- targettargetFrames : array, default :

```Lua
{
    "SUFUnittargetarget",
    "PitBull4_Frames_TargetTarget",
    "ElvUF_TargetTarget",
    "TargetTargetFrame",
    "oUF_TukuiTargetTarget",
}
```

- ignoreFrames : array, default :

```Lua
{ }
```

- returnAll : boolean (default false)

## Examples

### Glow player frame

```Lua
local LGF = LibStub("LibGetFrame-1.0")
local LCG = LibStub("LibCustomGlow-1.0")
local frame = LGF.GetUnitFrame("player")

if frame then
  LCG.ButtonGlow_Start(frame)
  -- LCG.ButtonGlow_Stop(frame)
end
```

### Glow every frames for your target

```Lua
local LGF = LibStub("LibGetFrame-1.0")
local LCG = LibStub("LibCustomGlow-1.0")

local frames = LGF.GetUnitFrame("target", {
      ignorePlayerFrame = false,
      ignoreTargetFrame = false,
      ignoreTargettargetFrame = false,
      returnAll = true,
})

for _, frame in pairs(frames) do
   LCG.ButtonGlow_Start(frame)
   --LCG.ButtonGlow_Stop(frame)
end
```

### Ignore Vuhdo panel 2 and 3

```Lua
local frame = LGF.GetUnitFrame("player", {
      ignoreFrames = { "Vd2.*", "Vd3.*" }
})
```

[GitHub Project](https://github.com/mrbuds/LibGetFrame)
