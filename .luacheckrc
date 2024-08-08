std = "luajit"
globals = {
  -- World of Warcraft related
  "UIParent",
  "LibStub",
  "strsplit",
  "strjoin",
  "tinsert",
  "GetLocale",
  "GameTooltip",
  "UnitName",
  "UnitAffectingCombat",
  "GetUnitName",
  "GetGuildInfo",
  "InterfaceOptionsFrame_OpenToCategory",
  "tContains",
  "GetScreenWidth",
  "GetScreenHeight",
  "AceGUIWidgetLSMlists",
  "PlaySoundFile",
  "wipe",
  "UnitGroupRolesAssigned",
  "GameFontHighlightSmall",
  "tremove",
  "GetSpellInfo",
  "UISpecialFrames",
  "strtrim",
  "strmatch",
  "GuildControlGetNumRanks",
  "GuildControlGetRankName",
  "GetTime",
  "CombatLogGetCurrentEventInfo",
  "UnitGUID",
  "UnitIsPlayer",
  "GetInstanceInfo",
  "UnitExists",
  "UnitIsDead",
  "UnitHealth",
  "UnitHealthMax",
  "UnitPower",
  "UnitPowerMax",
  "random",
  "CreateFrame",
  "BackdropTemplateMixin",
  "getn",
  "sort",
  "UnitClass",
  "GetRaidRosterInfo",
  "GetNumGroupMembers",
  "UnitInParty",
  "UnitInRaid",
  "max",
  "format",
  "UnitFullName",
  "UnitIsConnected",
  "UnitIsDeadOrGhost",
  "GetNumSpecializations",
  "GetSpecializationInfo",
  "IsAddOnLoaded",
  "DEFAULT_CHAT_FRAME",
  "ChatEdit_SendText",
  "SetRaidTarget",
  "GetSpecialization",
  "UnitAffectingCombat",
  "IsEncounterInProgress",
  "GetRealmName",
  "GetRaidTargetIndex",
  "UnitIsGroupAssistant",
  "SendChatMessage",
  "UnitIsGroupLeader",
  "GetBuildInfo",
  "GetSpellDescription",
  "GetZoneText",
  "time",
  "date",
  "C_Timer",
  "PlayerFrame",
  "TargetFrame",
  "MainMenuBar",
  "MultiBarBottomLeft",
  "MultiBarBottomRight",
  "MultiBarRight",
  "MultiBarLeft",
  "MultiBar5",
  "MultiBar6",
  "MultiBar7",
  "PetActionBar",
  "StanceBar",
  "MicroButtonAndBagsBar",
  "Minimap",
  "ObjectiveTrackerFrame",
  "BuffFrame",
  "DebuffFrame",
  "IsResting",
  "ZoneAbilityFrame",
  "MinimapCluster",
  "StatusTrackingBarManager",
  "PlayerCastingBarFrame",
  "FocusFrame",
  "ExtraActionButtonFrame",
  "PetFrame",
  "QueueStatusButton",
  "MicroButtonAndBagsBarMovable",
  "EditModeExpandedBackpackBar",
  "DurabilityFrame",
  "VehicleSeatIndicator",
  "TargetFrameToT",
  "PlayerFrameBottomManagedFramesContainer",
  "UnitClassBase",
  "TotemFrame",
  "CompactPartyFrame",
  "PartyFrame",
  "CompactRaidFrameContainer",
  "MainMenuBarVehicleLeaveButton",
  "PlayerName",
  "PlayerLevelText",
  "PlayerFrameHealthBarText",
  "PlayerFrameHealthBarTextLeft",
  "PlayerFrameHealthBarTextRight",
  "PlayerFrameManaBarText",
  "ExtraAbilityContainer",
  "PlayerFrameManaBarTextLeft",
  "PlayerFrameManaBarTextRight",
  "ActionButton1",
  "QuickKeybindFrame",
  "EditModeManagerFrame",
  "Settings",
  "InCombatLockdown",
  "SpellBookFrame",
  "PlayerSpellsFrame",
  "PetActionButton1",
  "StanceButton1",
  "IsShiftKeyDown",
  "IsControlKeyDown",
  "IsAltKeyDown",
  "UnitCanAttack",
  "FocusFrameToT",
  "PetName",
  "IsInGroup",
  "GetAddOnInfo",
  "WorldQuestTrackerScreenPanel",
  "PetFrameHealthBarTextLeft",
  "PetFrameHealthBarTextRight",
  "PetFrameHealthBarText",
  "PetFrameManaBarTextLeft",
  "PetFrameManaBarTextRight",
  "PetFrameManaBarText",
  "SpellFlyout",
  "IsInRaid",
  "UIWidgetPowerBarContainerFrame",
  "IsMounted",
  "HasBonusActionBar",
  "L",
  "BagsBar",
  "MicroMenu"
}
max_line_length = 200
max_code_line_length = 200
max_string_line_length = 200
max_comment_line_length = 200
max_cyclomatic_complexity = 200

ignore = {
  ".*self",
  "date",
  "512"
}
