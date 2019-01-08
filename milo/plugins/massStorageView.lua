local Ansi       = require('ansi')
local UI         = require('ui')

local colors     = _G.colors
local device     = _G.device

--[[ Configuration Screen ]]
local template =
[[%sWarning%s

Must an interface for Refined Storage / Applied Energistics.

Add all speed upgrades possible.
]]

local wizardPage = UI.Window {
  title = 'Mass Storage',
  index = 2,
  backgroundColor = colors.cyan,
  [1] = UI.TextArea {
    x = 2, ex = -2, y = 2, ey = -2,
    value = string.format(template, Ansi.red, Ansi.reset),
  },
}

function wizardPage:isValidFor(node)
  if node.mtype == 'storage' then
    local m = device[node.name]
    return m and m.listAvailableItems
  end
end

function wizardPage:setNode(node)
  self.node = node
end

function wizardPage:validate()
  self.node.adapterType = 'massAdapter'
  return true
end

UI:getPage('nodeWizard').wizard:add({ inputChest = wizardPage })