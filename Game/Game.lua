EditGrid          = require 'editgrid/editgrid'
Vec               = require "hump/vector"
Timer             = require "hump/timer"

Global            = require "Game/Global"
Block             = require "Game/Block"
BlockType         = require "Game/BlockTypes/BlockType"
PropulsionBlock   = require "Game/BlockTypes/PropulsionBlock"
ControlBlock      = require "Game/BlockTypes/ControlBlock"
BlockGroup        = require "Game/BlockGroup"
blockGroupFactory = require "Game/blockGroupFactory"
ActionManager     = require "Game/ActionManager"
CameraManager     = require "Game/CameraManager"
ResourceManager   = require "Game/ResourceManager"

Game = Class("Game", Entity)

debugDraw = {}
function Game:initialize(t)

  Entity.initialize(self,{
      args = t,
      defaults = {
        timer = Timer:new(),
        cameraManager = CameraManager:new(),
        actionManager = ActionManager:new(),
        resourceManager = ResourceManager:new(),
      }
    }
  )

  love.mouse.setVisible(true)
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
end

function Game:load()
  self.blocks = { blockGroupFactory.getRandomControlBlockGroup() }
end

function Game:update(dt)

  debugDraw = {}
  self.timer:update(dt)
  if inputManager:pressed("end_game") then
    love.event.quit()
  end

  self.cameraManager:update(dt)
  self.actionManager:update(dt)
  self:updateActiveBlocks(dt)
end


function Game:updateActiveBlocks(dt)
  for k,v in ipairs(self.blocks) do
    if v:isActive() then
      v:update(dt)
    end
  end
end

function Game:draw()
  EditGrid.draw(self.cameraManager.camera)
  self.cameraManager:attach()
  for k,v in ipairs(self.blocks) do
    v:draw()
  end
  self.actionManager:draw()
  if Global.DEBUG_MODE then physicsWorld:draw() end
  Util.debugDraw(debugDraw)
  self.cameraManager:detach()
end

return Game
