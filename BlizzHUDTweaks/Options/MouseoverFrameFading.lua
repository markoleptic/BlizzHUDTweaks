local addon = LibStub("AceAddon-3.0"):GetAddon("BlizzHUDTweaks")
local Options = addon:GetModule("Options")
local MouseoverFrameFading = addon:GetModule("MouseoverFrameFading")

local function generateFrameOptionDescription(frameOptions, frameName)
  local desc = "Frame: " .. frameName

  if frameOptions.description then
    desc = desc .. "\n" .. frameOptions.description
  end

  if frameOptions.UseGlobalOptions then
    desc = desc .. "\n\n|cFFa0a832*|r Uses the global settings."
  end

  return desc
end

local function generateFrameOptionName(frameOptions, frameName)
  local name = frameOptions.displayName or frameName

  if frameOptions.UseGlobalOptions then
    name = name .. " (|cFFa0a832*|r)"
  end

  if not frameOptions.Enabled then
    name = "|cFFba3504" .. name .. "|r"
  end

  return name
end

local function addFrameOptions(order, t, frameName, frameOptions, withUseGlobal)
  local subOptions = {}

  t[frameName] = {
    name = generateFrameOptionName(frameOptions, frameName),
    desc = generateFrameOptionDescription(frameOptions, frameName),
    type = "group",
    args = subOptions
  }

  if withUseGlobal then
    order = order + 0.1
    subOptions["Enabled"] = {
      order = order,
      name = "Enabled",
      width = "full",
      type = "toggle",
      get = "GetValue",
      set = function(info, value)
        Options:SetValue(info, value)
        addon:RefreshOptionTables()
        addon:ResetFrame(addon:GetFrameMapping()[frameName])
        MouseoverFrameFading:RefreshFrameAlphas()
      end,
      arg = frameName
    }
    order = order + 0.1
    subOptions["CopyFrom"] = {
      order = order,
      name = "Copy from",
      desc = "Copies all settings of the selected frame to the current frame. This can be used to quickly change many frames to a specific behavior.",
      width = "full",
      type = "select",
      set = "CopyFrom",
      values = addon:GetFrameTable(),
      arg = frameName
    }
    order = order + 0.1
    subOptions["UseGlobalOptions"] = {
      order = order,
      name = "Use global options",
      desc = "Disables all options for this frame and instead uses the globally set options.",
      width = "full",
      type = "toggle",
      get = "GetValue",
      set = function(info, value)
        Options:SetValue(info, value)
        addon:RefreshOptionTables()
        MouseoverFrameFading:RefreshFrameAlphas()
      end,
      arg = frameName
    }
  end
  order = order + 0.1
  subOptions["MouseOverInCombat"] = {
    order = order,
    name = "Allow mouseover in combat",
    desc = "When activated you can mouseover action bars and frames while within combat to show the frame with full alpha.",
    width = "full",
    type = "toggle",
    get = "GetValue",
    set = "SetValue",
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  if not withUseGlobal then
    order = order + 0.1
    subOptions["TreatTargetLikeInCombat"] = {
      order = order,
      name = "Treat target as in combat",
      desc = "When active the fade will change to the in combat fade when you have a target.",
      width = "full",
      type = "toggle",
      get = "GetValue",
      set = "SetValue",
      arg = frameName
    }
    order = order + 0.1
    subOptions["UpdateInterval"] = {
      order = order,
      name = "Update Interval",
      desc = "The interval in which the add-on should check for necessary alpha changes." ..
        "If you don't need mouseovers to be instantaneously, a value of 0.1 should be fine for you." ..
          addon:ColoredString("\n\nNOTE: ", "eb4034") ..
            "Setting a value below 0.1 puts some stress on the CPU, since the add-on will check" ..
              "for mouseovers far more often. It shouldn't be a real problem, but if " .. "you have any FPS issues, try increasing the value again.",
      width = 0.8,
      type = "range",
      get = "GetUpdateTickerValue",
      set = "SetUpdateTickerValue",
      min = 0.01,
      max = 1,
      step = 0.01,
      arg = frameName
    }
  end

  order = order + 0.1
  subOptions["FadeDuration"] = {
    order = order,
    name = "Fade Duration",
    desc = "The duration how long the fade should take (fade in and out).",
    width = 0.8,
    type = "range",
    get = "GetValue",
    set = "SetValue",
    min = 0.05,
    max = 2,
    step = 0.05,
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["InCombatFade"] = {
    order = order,
    name = "In Combat Fade",
    width = "full",
    type = "header"
  }
  order = order + 0.1
  subOptions["FadeInCombat"] = {
    order = order,
    name = "Enabled",
    width = 0.6,
    type = "toggle",
    get = "GetValue",
    set = "SetValue",
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["InCombatAlpha"] = {
    order = order,
    name = "Alpha",
    desc = "Set the alpha value of the frame when within combat.",
    width = 0.8,
    type = "range",
    get = "GetFadeSliderValue",
    set = "SetFadeSliderValue",
    min = 0,
    max = 100,
    step = 1,
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["OutOfCombatFade"] = {
    order = order,
    name = "Out of Combat Fade",
    width = "full",
    type = "header"
  }
  order = order + 0.1
  subOptions["FadeOutOfCombat"] = {
    order = order,
    name = "Enabled",
    width = 0.6,
    type = "toggle",
    get = "GetValue",
    set = "SetValue",
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["OutOfCombatAlpha"] = {
    order = order,
    name = "Alpha",
    desc = "Set the alpha value of the frame when not in combat.",
    width = 0.8,
    type = "range",
    get = "GetFadeSliderValue",
    set = "SetFadeSliderValue",
    min = 0,
    max = 100,
    step = 1,
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["OutOfCombatFadeDelay"] = {
    order = order,
    name = "Fade Delay",
    desc = "Set a delay for how long the in combat alpha should be maintained before fading to the out of combat alpha." ..
      "The default is 0 and means that the alpha values will change immediately. Setting a higher value can help with reducing `flashing`" ..
        " action bars or frames when entering/leaving combat fast, e.g. while questing." ..
          addon:ColoredString("\n\nNOTE: ", "eb4034") .. "Mouseover a frame will interrupt the delay and use the normal alpha values instead.",
    width = 0.8,
    type = "range",
    get = "GetValue",
    set = "SetValue",
    min = 0,
    max = 60,
    step = 0.5,
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["RestedAreaFade"] = {
    order = order,
    name = "Rested Area Fade",
    width = "full",
    type = "header"
  }
  order = order + 0.1
  subOptions["FadeInRestedArea"] = {
    order = order,
    name = "Enabled",
    width = 0.6,
    type = "toggle",
    get = "GetValue",
    set = "SetValue",
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
  order = order + 0.1
  subOptions["RestedAreaAlpha"] = {
    order = order,
    name = "Alpha",
    desc = "Set the alpha value of the frame while in a rested area.",
    width = 0.8,
    type = "range",
    get = "GetFadeSliderValue",
    set = "SetFadeSliderValue",
    min = 0,
    max = 100,
    step = 1,
    disabled = "GetUseGlobalFrameOptions",
    arg = frameName
  }
end

-------------------------------------------------------------------------------
-- Public API

function MouseoverFrameFading:CopyFrom(info, value)
  local fromFrameOptions = addon:GetProfileDB()[value]

  if fromFrameOptions then
    local copy = addon:tClone(fromFrameOptions)
    copy.displayName = addon:GetProfileDB()[info.arg].displayName
    addon:GetProfileDB()[info.arg] = copy
    MouseoverFrameFading:RefreshFrameAlphas()
  end
end

function MouseoverFrameFading:GetFadeSliderValue(info)
  return (Options:GetValue(info) or 1) * 100
end

function MouseoverFrameFading:SetFadeSliderValue(info, value)
  local normalizedValue = (value or 1) / 100
  Options:SetValue(info, normalizedValue)
  MouseoverFrameFading:RefreshFrameAlphas()
end

function MouseoverFrameFading:GetUpdateTickerValue(info)
  return Options:GetValue(info) or 1
end

function MouseoverFrameFading:SetUpdateTickerValue(info, value)
  local interval = (value or 0.1)
  Options:SetValue(info, interval)
  addon:RefreshUpdateTicker(interval)
end

function MouseoverFrameFading:GetUseGlobalFrameOptions(info)
  if info then
    if addon:GetProfileDB()[info.arg] then
      return addon:GetProfileDB()[info.arg]["UseGlobalOptions"] or false
    end
  end
end

function MouseoverFrameFading:GetValue(info)
  return Options:GetValue(info)
end

function MouseoverFrameFading:SetValue(info, value)
  Options:SetValue(info, value)

  MouseoverFrameFading:RefreshFrameAlphas()
end

function MouseoverFrameFading:GetMouseoverFrameFadingOptions(profile)
  local options = {}

  local order = 1
  local withUseGlobal

  for frameName, frameOptions in pairs(profile) do
    if type(frameOptions) == "table" and frameOptions.displayName then
      if frameName ~= "*Global*" then
        withUseGlobal = true
      else
        withUseGlobal = false
      end

      if not frameOptions.Hidden then
        addFrameOptions(order, options, frameName, frameOptions, withUseGlobal)
        order = order + 1
      end
    end
  end

  return options
end

function MouseoverFrameFading:GetOptionsTable(profile)
  return {
    name = "Mouseover Frame Fading",
    type = "group",
    handler = MouseoverFrameFading,
    args = MouseoverFrameFading:GetMouseoverFrameFadingOptions(profile)
  }
end