local _, BlizzHUDTweaks = ...
local addon = LibStub("AceAddon-3.0"):NewAddon("BlizzHUDTweaks", "AceConsole-3.0")

local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local EventHandler = addon:NewModule("EventHandler", "AceEvent-3.0")
local Options = addon:NewModule("Options")
local MouseoverFrameFading = addon:NewModule("MouseoverFrameFading")
local ClassResource = addon:NewModule("ClassResource")
local Miscellaneous = addon:NewModule("Miscellaneous")

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
              addon:Disable()
            else
              addon:Enable()
            end
          elseif button == "MiddleButton" then
            db.global.minimap.hide = true
            LibDBIcon:Hide("BlizzHUDTweaks")
            addon:Print("Minimap icon is now hidden. If you want to show it again use /bht minimap")
          end
        end,
        OnEnter = function()
          GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
          GameTooltip:AddDoubleLine("|cFF69CCF0BlizzHUDTweaks|r", "v" .. db.global.version)
          GameTooltip:AddDoubleLine("|cFFdcabffLeft-Click|r", "Open Options")
          GameTooltip:AddDoubleLine("|cFFdcabffRight-Click|r", "Toggle Addon")
          GameTooltip:AddDoubleLine("|cFFdcabffMiddle-Click|r", "Hide minimap icon")
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
    ["version"] = "@project-version@",
    ["minimap"] = {
      ["hide"] = false
    }
  },
  ["profile"] = {
    ["GlobalOptionsMouseoverFrameFadingEnabled"] = true,
    ["GlobalOptionsClassResourceEnabled"] = true,
    ["GlobalOptionsMiscellaneousEnabled"] = true,
    ["Enabled"] = true,
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
    },
    ["PartyFrame"] = {
      displayName = "Party Frame"
    },
    ["CompactRaidFrameContainer"] = {
      displayName = "Raid Frame"
    },
    ["MainMenuBarVehicleLeaveButton"] = {
      displayName = "Vehicle Leave Button"
    },
    ["FocusFrameToT"] = {
      displayName = "Target of Focus Target"
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
  ["VehicleSeatIndicator"] = VehicleSeatIndicator,
  ["PartyFrame"] = PartyFrame,
  ["CompactRaidFrameContainer"] = CompactRaidFrameContainer,
  ["MainMenuBarVehicleLeaveButton"] = MainMenuBarVehicleLeaveButton,
  ["FocusFrameToT"] = FocusFrameToT
}

local function setFrameDefaultOptions(frameOptions)
  frameOptions["Enabled"] = true
  frameOptions["MouseOverInCombat"] = true
  frameOptions["FadeDuration"] = 0.25

  frameOptions["FadeInCombat"] = true
  frameOptions["InCombatAlpha"] = 1

  frameOptions["FadeInInstancedArea"] = false
  frameOptions["InstancedAreaAlpha"] = 1

  frameOptions["FadeOutOfCombat"] = true
  frameOptions["OutOfCombatAlpha"] = 0.6
  frameOptions["OutOfCombatFadeDelay"] = 0

  frameOptions["FadeInRestedArea"] = false
  frameOptions["RestedAreaAlpha"] = 0.3

  frameOptions["TreatTargetLikeInCombat"] = true
  frameOptions["TreatTargetLikeInCombatTargetType"] = "both"
end

do
  defaultConfig.profile["Enabled"] = true

  for frameName, frameOptions in pairs(defaultConfig.profile) do
    if type(frameOptions) == "table" then
      setFrameDefaultOptions(frameOptions)

      if frameName ~= "*Global*" then
        frameOptions["UseGlobalOptions"] = true
      else
        frameOptions["UpdateInterval"] = 0.1
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
    addon:Print("EditModeExpanded found. Adding additional frames.")
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
    hideFrameOptions(profile, {{name = "MicroButtonAndBagsBar"}})
  else
    showFrameOptions(profile, {{name = "MicroButtonAndBagsBar"}})
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

local frameTable

function addon:GetFrameTable()
  if not frameTable then
    frameTable = {}
    for frameName, frameOptions in pairs(self.db.profile) do
      if type(frameOptions) == "table" then
        if not frameOptions.Hidden and frameName ~= "*Global*" then
          frameTable[frameName] = frameOptions.displayName or frameName
        end
      end
    end
  end

  return frameTable
end

function addon:LoadProfile()
  updateFramesForLoadedAddons(self.db.profile)

  if addon:IsEnabled() then
    MouseoverFrameFading:RefreshFrameAlphas()
    addon:InitializeUpdateTicker()
    Miscellaneous:RestoreAll(self.db.profile)
    addon:RefreshOptionTables()
    Options:DisableAll()
    Options:EnableAll()
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
      MouseoverFrameFading:RefreshMouseoverFrameAlphas()
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
  if addon:IsEnabled() then
    addon:RefreshUpdateTicker(self.db.profile["*Global*"].UpdateInterval or 0.1)
  end
end

function addon:OnInitialize()
  self.db = LibStub("AceDB-3.0"):New("BlizzHUDTweaksDB", defaultConfig, false)
  updateFramesForLoadedAddons(self.db.profile)

  -- Remove in the future
  cleanupNonsense(self.db.profile)

  -- Initialize Minimap Icon
  local dbIconData = getBlizzHUDTweaksLibDbIconData(self.db)
  LibDBIcon:Register("BlizzHUDTweaks", dbIconData, self.db.global.minimap)

  self.db.RegisterCallback(self, "OnProfileChanged", "LoadProfile")
  self.db.RegisterCallback(self, "OnProfileCopied", "LoadProfile")
  self.db.RegisterCallback(self, "OnProfileReset", "LoadProfile")

  self:RegisterChatCommand("blizzhudtweaks", "ExecuteChatCommand")
  self:RegisterChatCommand("bht", "ExecuteChatCommand")

  addon:HideGCDFlash()

  EventHandler:RegisterEvents()

  QueueStatusButton:SetParent(UIParent)
  MainMenuBarVehicleLeaveButton:SetParent(UIParent)

  addon:InitializeUpdateTicker()
  addon:InitializeOptions()
end

function addon:InitializeOptions()
  addon:RefreshOptionTables()
  self.optionsFrame = AceConfigDialog:AddToBlizOptions("BlizzHUDTweaks_options", "BlizzHUDTweaks")
  self.profileOptionsFrame = AceConfigDialog:AddToBlizOptions("BlizzHUDTweaks_Profiles", "Profiles", "BlizzHUDTweaks")
  self.mouseoverFrameFadingOptionsFrame = AceConfigDialog:AddToBlizOptions("BlizzHUDTweaks_MouseoverFrameFading", "Mouseover Frame Fading", "BlizzHUDTweaks")
  self.classResourceOptionsFrame = AceConfigDialog:AddToBlizOptions("BlizzHUDTweaks_ClassResource", "Class Resource", "BlizzHUDTweaks")
  self.miscellaneousOptionsFrame = AceConfigDialog:AddToBlizOptions("BlizzHUDTweaks_Miscellaneous", "Miscellaneous", "BlizzHUDTweaks")
end

function addon:RefreshOptionTables()
  local globalOptions = Options:GetOptionsTable()
  AceConfig:RegisterOptionsTable("BlizzHUDTweaks_options", globalOptions)

  local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
  AceConfig:RegisterOptionsTable("BlizzHUDTweaks_Profiles", profiles)

  local mouseoverFrameFadingOptions = MouseoverFrameFading:GetOptionsTable(self.db.profile)
  AceConfig:RegisterOptionsTable("BlizzHUDTweaks_MouseoverFrameFading", mouseoverFrameFadingOptions)

  local classResourceOptions = ClassResource:GetOptionsTable(self.db.profile)
  AceConfig:RegisterOptionsTable("BlizzHUDTweaks_ClassResource", classResourceOptions)

  local miscellaneousOptions = Miscellaneous:GetOptionsTable()
  AceConfig:RegisterOptionsTable("BlizzHUDTweaks_Miscellaneous", miscellaneousOptions)
end

function addon:OpenOptions()
  InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
end

function addon:ResetFrame(frame)
  if frame then
    frame:SetAlpha(1)
  end
end

function addon:IsEnabled()
  return self.db.profile["Enabled"]
end

function addon:Disable()
  self.db.profile["Enabled"] = false
  Options:DisableAll()
end

function addon:Enable()
  self.db.profile["Enabled"] = true
  Options:EnableAll()
end

function addon:ToggleMinimapIcon()
  if self.db.global.minimap.hide then
    LibDBIcon:Show("BlizzHUDTweaks")
  else
    LibDBIcon:Hide("BlizzHUDTweaks")
  end
  self.db.global.minimap.hide = not self.db.global.minimap.hide
end

function addon:ExecuteChatCommand(input)
  if input == "" or input == nil then
    addon:OpenOptions()
  elseif input == "minimap" then
    addon:ToggleMinimapIcon()
  end
end

function addon:GetProfileDB()
  return self.db.profile
end
