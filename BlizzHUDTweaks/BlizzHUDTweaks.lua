local _, BlizzHUDTweaks = ...
local addon = LibStub("AceAddon-3.0"):NewAddon("BlizzHUDTweaks", "AceEvent-3.0", "AceConsole-3.0")
local AC = LibStub("AceConfig-3.0")
local ACD = LibStub("AceConfigDialog-3.0")
local LibDBIcon = LibStub:GetLibrary("LibDBIcon-1.0", true)

local function getBlizzHUDTweaksLibDbIconData(db)
  local LibDataBroker = LibStub:GetLibrary("LibDataBroker-1.1", true)
  if LibDBIcon and LibDataBroker then
    return LibDataBroker:NewDataObject(
      "BlizzHUDTweaks",
      {
        type = "data source",
        text = "BlizzHUDTweaks",
        icon = "Interface\\AddOns\\BlizzHUDTweaks\\Media\\Icons\\BlizzHUDTweaks.blp",
        OnClick = function(self, button)
          if button == "LeftButton" then
            addon:OpenOptions()
          elseif button == "RightButton" then
            if addon:IsEnabled() then
              db.profile["enabled"] = false
              addon:DisableAll()
            else
              db.profile["enabled"] = true
              addon:EnableAll()
            end
          end
        end,
        OnEnter = function()
          GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
          GameTooltip:AddDoubleLine("|cFF69CCF0BlizzHUDTweaks|r", "v" .. db.global.version)
          GameTooltip:AddDoubleLine("|cFFdcabffLeft-Click|r", "Open Options")
          GameTooltip:AddDoubleLine("|cFFdcabffRight-Click|r", "Toggle Addon")
          GameTooltip:Show()
        end,
        OnLeave = function()
          GameTooltip:Hide()
        end
      }
    )
  end
end

local defaultConfig = {
  ["global"] = {
    ["version"] = "@project-version@"
  },
  ["profile"] = {
    ["*Global*"] = {
      displayName = "* |T134063:16:16:0:0:64:64:6:58:6:58|t|cFFa0a832 Global Settings|r",
      description = "You can set global values which can be activated for each frame."
    },
    ["PlayerFrame"] = {
      displayName = "Player Frame"
    },
    ["TargetFrame"] = {
      displayName = "Target Frame"
    },
    ["TargetFrameToT"] = {
      displayName = "Target of Target Frame"
    },
    ["FocusFrame"] = {
      displayName = "Focus Frame"
    },
    ["ActionBar1"] = {
      displayName = "Action Bar 1"
    },
    ["ActionBar2"] = {
      displayName = "Action Bar 2"
    },
    ["ActionBar3"] = {
      displayName = "Action Bar 3"
    },
    ["ActionBar4"] = {
      displayName = "Action Bar 4"
    },
    ["ActionBar5"] = {
      displayName = "Action Bar 5"
    },
    ["ActionBar6"] = {
      displayName = "Action Bar 6"
    },
    ["ActionBar7"] = {
      displayName = "Action Bar 7"
    },
    ["ActionBar8"] = {
      displayName = "Action Bar 8"
    },
    ["PetActionBar"] = {
      displayName = "Pet Action Bar"
    },
    ["StanceBar"] = {
      displayName = "Stance Bar"
    },
    ["MicroButtonAndBagsBar"] = {
      displayName = "System and Bags Bar"
    },
    ["ObjectiveTrackerFrame"] = {
      displayName = "Objective Tracker"
    },
    ["BuffFrame"] = {
      displayName = "Buff Frame"
    },
    ["DebuffFrame"] = {
      displayName = "Debuff Frame"
    },
    ["ZoneAbilityFrame"] = {
      displayName = "Zone Ability Frame"
    },
    ["MinimapCluster"] = {
      displayName = "Minimap"
    },
    ["StatusTrackingBarManager"] = {
      displayName = "Reputation and Experience Bar"
    },
    ["PlayerCastingBarFrame"] = {
      displayName = "Player Cast Bar"
    },
    ["ExtraActionButtonFrame"] = {
      displayName = "Extra Action Button"
    },
    ["PetFrame"] = {
      displayName = "Pet Frame"
    },
    ["QueueStatusButton"] = {
      displayName = "Queue Status Eye"
    },
    ["DurabilityFrame"] = {
      displayName = "Durability Frame"
    },
    ["VehicleSeatIndicator"] = {
      displayName = "Vehicle Seats Frame"
    }
  }
}

local frameMapping = {
  ["PlayerFrame"] = PlayerFrame,
  ["TargetFrame"] = TargetFrame,
  ["TargetFrameToT"] = TargetFrameToT,
  ["FocusFrame"] = FocusFrame,
  ["ActionBar1"] = MainMenuBar,
  ["ActionBar2"] = MultiBarBottomLeft,
  ["ActionBar3"] = MultiBarBottomRight,
  ["ActionBar4"] = MultiBarRight,
  ["ActionBar5"] = MultiBarLeft,
  ["ActionBar6"] = MultiBar5,
  ["ActionBar7"] = MultiBar6,
  ["ActionBar8"] = MultiBar7,
  ["PetActionBar"] = PetActionBar,
  ["StanceBar"] = StanceBar,
  ["MicroButtonAndBagsBar"] = MicroButtonAndBagsBar,
  ["ObjectiveTrackerFrame"] = ObjectiveTrackerFrame,
  ["BuffFrame"] = BuffFrame,
  ["DebuffFrame"] = DebuffFrame,
  ["ZoneAbilityFrame"] = ZoneAbilityFrame,
  ["MinimapCluster"] = MinimapCluster,
  ["StatusTrackingBarManager"] = StatusTrackingBarManager,
  ["PlayerCastingBarFrame"] = PlayerCastingBarFrame,
  ["ExtraActionButtonFrame"] = ExtraActionButtonFrame,
  ["PetFrame"] = PetFrame,
  ["QueueStatusButton"] = QueueStatusButton,
  ["DurabilityFrame"] = DurabilityFrame,
  ["VehicleSeatIndicator"] = VehicleSeatIndicator
}

local function setFrameDefaultOptions(frameOptions)
  frameOptions["Enabled"] = true
  frameOptions["MouseOverInCombat"] = true
  frameOptions["FadeDuration"] = 0.25

  frameOptions["FadeInCombat"] = true
  frameOptions["InCombatAlpha"] = 1

  frameOptions["FadeOutOfCombat"] = true
  frameOptions["OutOfCombatAlpha"] = 0.6
  frameOptions["OutOfCombatFadeDelay"] = 0

  frameOptions["FadeInRestedArea"] = false
  frameOptions["RestedAreaAlpha"] = 0.3
end

do
  defaultConfig.profile["enabled"] = true

  for frameName, frameOptions in pairs(defaultConfig.profile) do
    if type(frameOptions) == "table" then
      setFrameDefaultOptions(frameOptions)

      if frameName ~= "*Global*" then
        frameOptions["UseGlobalOptions"] = true
      else
        frameOptions["UpdateInterval"] = 0.1
        frameOptions["TreatTargetLikeInCombat"] = true
      end

      if tContains({"Minimap", "BuffFrame", "DebuffFrame", "ObjectiveTrackerFrame"}, frameName) then
        frameOptions["UseGlobalOptions"] = false
        frameOptions["FadeOutOfCombat"] = false
      end
    end
  end
end

local function ensureFrameOptions(profile, addonName, frames)
  for _, frameOptions in ipairs(frames) do
    if not profile[frameOptions.name] then
      profile[frameOptions.name] = {
        displayName = frameOptions.name .. " (" .. addonName .. ")",
        description = "This frame is added because you have `" .. addonName .. "` loaded",
        Enabled = true
      }
    end
  end
end

local function showFrameOptions(profile, frames)
  for _, frameOptions in ipairs(frames) do
    if profile[frameOptions.name] then
      profile[frameOptions.name]["Hidden"] = false
    end
  end
end

local function hideFrameOptions(profile, frames)
  for _, frameOptions in ipairs(frames) do
    if profile[frameOptions.name] then
      profile[frameOptions.name]["Hidden"] = true
    end
  end
end

local additionalFrameNames = {
  {
    name = "MicroButtonAndBagsBarMovable",
    frame = MicroButtonAndBagsBarMovable
  },
  {
    name = "EditModeExpandedBackpackBar",
    frame = EditModeExpandedBackpackBar
  }
}
local function updateFramesForLoadedAddons(profile)
  ensureFrameOptions(profile, "EditModeExpanded", additionalFrameNames)

  local EditModeExpanded

  if LibStub then
    EditModeExpanded = LibStub:GetLibrary("EditModeExpanded-1.0", true)
  end

  if EditModeExpanded then -- and EditModeExpanded.IsRegistered
    addon:Print("EditModeExpaneded found. Adding additional frames.")
    for _, frameOptions in ipairs(additionalFrameNames) do
      if frameOptions.frame then
        if frameOptions.frame then --EditModeExpanded:IsRegistered(frameOptions.frame)
          frameMapping[frameOptions.name] = frameOptions.frame
          if profile[frameOptions.name] then
            profile[frameOptions.name]["Hidden"] = false
          end
        end
      end
    end
    hideFrameOptions(profile, {name = "MicroButtonAndBagsBar"})
  else
    showFrameOptions(profile, {name = "MicroButtonAndBagsBar"})
    hideFrameOptions(profile, additionalFrameNames)
  end
end

local function cleanupNonsense(profile)
  -- Make durabilityFrame and VehicleFrame accessable everytime not only when EME is loaded
  showFrameOptions(profile, {{name = "DurabilityFrame"}, {name = "VehicleSeatIndicator"}})
  profile["DuarbilityFrame"] = nil
  profile["FloatingChatFrame"] = nil
  profile["DurabilityFrame"].description = nil
  profile["DurabilityFrame"].displayName = "Durability Frame"
  profile["VehicleSeatIndicator"].description = nil
  profile["VehicleSeatIndicator"].displayName = "Vehicle Seat Frame"
end

-------------------------------------------------------------------------------
-- Public API

function addon:GetFrameMapping()
  return frameMapping
end

function addon:GetFrameTable()
  local t = {}

  for frameName, frameOptions in pairs(self.db.profile) do
    if type(frameOptions) == "table" then
      if not frameOptions.Hidden and frameName ~= "*Global*" then
        t[frameName] = frameOptions.displayName or frameName
      end
    end
  end

  return t
end

function addon:LoadProfile()
  updateFramesForLoadedAddons(self.db.profile)
  if addon:IsEnabled() then
    addon:RefreshFrameAlphas()
    addon:InitializeUpdateTicker()
  end
end

function addon:ClearUpdateTicker()
  if BlizzHUDTweaks.updateTicker then
    BlizzHUDTweaks.updateTicker:Cancel()
  end
end

function addon:StartUpdateTicker(interval)
  BlizzHUDTweaks.updateTicker =
    C_Timer.NewTicker(
    math.min(interval, 1),
    function()
      addon:RefreshMouseoverFrameAlphas()
    end
  )
end

function addon:RefreshUpdateTicker(interval)
  addon:ClearUpdateTicker()

  if not BlizzHUDTweaks.updateTicker or BlizzHUDTweaks.updateTicker:IsCancelled() then
    if interval and interval < 0.01 then
      interval = 0.01
    end

    addon:StartUpdateTicker(interval)
  end
end
function addon:InitializeUpdateTicker()
  if self.db.profile["enabled"] then
    addon:RefreshUpdateTicker(self.db.profile["*Global*"].UpdateInterval or 0.1)
  end
end

function addon:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("BlizzHUDTweaksDB", defaultConfig, false)
  updateFramesForLoadedAddons(self.db.profile)

  cleanupNonsense(self.db.profile)

  -- Initialize Minimap Icon
  local dbIconData = getBlizzHUDTweaksLibDbIconData(self.db)
  LibDBIcon:Register("BlizzHUDTweaks", dbIconData, self.db.global.minimap)

  self.db.RegisterCallback(self, "OnProfileChanged", "LoadProfile")
  self.db.RegisterCallback(self, "OnProfileCopied", "LoadProfile")
  self.db.RegisterCallback(self, "OnProfileReset", "LoadProfile")

  AC:RegisterOptionsTable("BlizzHUDTweaks_options", addon:GetAceOptions(self.db))
  self.optionsFrame = ACD:AddToBlizOptions("BlizzHUDTweaks_options", "BlizzHUDTweaks")

  local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
  AC:RegisterOptionsTable("BlizzHUDTweaks_Profiles", profiles)
  ACD:AddToBlizOptions("BlizzHUDTweaks_Profiles", "Profiles", "BlizzHUDTweaks")

  self:RegisterChatCommand("blizzhudtweaks", "OpenOptions")
  self:RegisterChatCommand("bht", "OpenOptions")

  addon:HideGCDFlash()
  addon:RegisterEvent("PLAYER_REGEN_ENABLED")
  addon:RegisterEvent("PLAYER_REGEN_DISABLED")
  addon:RegisterEvent("PLAYER_UPDATE_RESTING")
  addon:RegisterEvent("PLAYER_TARGET_CHANGED")
  addon:RegisterEvent("PLAYER_ENTERING_WORLD")

  QueueStatusButton:SetParent(UIParent)

  addon:InitializeUpdateTicker()
end

function addon:RefreshOptions()
  AC:RegisterOptionsTable("BlizzHUDTweaks_options", addon:GetAceOptions(self.db))
end

function addon:OpenOptions()
  InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function addon:ResetFrame(frame)
  if frame then
    frame:SetAlpha(1)
  end
end

function addon:DisableAll()
  addon:Print("Disabled fading for all action bars and frames.")
  addon:ClearUpdateTicker()
  for _, frame in pairs(addon:GetFrameMapping()) do
    addon:ResetFrame(frame)
  end
end

function addon:EnableAll()
  addon:Print("Enabled fading of action bars and frames.")
  addon:InitializeUpdateTicker()
  addon:RefreshFrameAlphas()
end

function addon:IsEnabled()
  return self.db.profile["enabled"]
end

function addon:PLAYER_REGEN_ENABLED()
  BlizzHUDTweaks.inCombat = false

  if addon:IsEnabled() then
    addon:RefreshFrameAlphas(true)
  end
end

function addon:PLAYER_REGEN_DISABLED()
  BlizzHUDTweaks.inCombat = true

  if addon:IsEnabled() then
    addon:RefreshFrameAlphas()
  end
end

function addon:PLAYER_UPDATE_RESTING()
  BlizzHUDTweaks.isResting = IsResting("player")

  if addon:IsEnabled() then
    addon:RefreshFrameAlphas()
  end
end

function addon:PLAYER_TARGET_CHANGED()
  BlizzHUDTweaks.hasTarget = UnitExists("target")

  if addon:IsEnabled() then
    if BlizzHUDTweaks.hasTarget then
      addon:RefreshFrameAlphas()
    else
      addon:RefreshFrameAlphas(true)
    end
  end
end

function addon:PLAYER_ENTERING_WORLD()
  BlizzHUDTweaks.isResting = IsResting("player")

  if addon:IsEnabled() then
    addon:RefreshFrameAlphas()
  end
end
