Vec               = require "hump/vector"
Timer             = require "hump/timer"

Global            = require "Game/Global"
Block             = require "Game/Block"
BlockGroup        = require "Game/BlockGroup"
blockGroupFactory = require "Game/blockGroupFactory"
Inputmanager      = require "Game/InputManager"
ActionManager     = require "Game/ActionManager"
CameraManager     = require "Game/CameraManager"

Game = Class("Game", Entity)

debugDraw = {}
function Game:initialize(t)

  Entity.initialize(self,{
      args = t,
      defaults = {
        timer = Timer:new(),
        cameraManager = CameraManager:new(),
        actionManager = ActionManager:new(),
      }
    }
  )

  love.mouse.setVisible(true)
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
end

function Game:load()
  self.blocks = {
    -- T
    blockGroupFactory.getT()
    --[[,
    -- Z
    BlockGroup:new({
      pos = Vec(
        7 * Global.BLOCK_SIZE,
        3 * Global.BLOCK_SIZE),
      relativePositions = {
        Vec(-1,-1),
        Vec(0,-1),
        Vec(0,0),
        Vec(1,0)
      }
    }),
      -- I
      BlockGroup:new({
      pos = Vec(
        11 * Global.BLOCK_SIZE,
        3 * Global.BLOCK_SIZE),
        rotationCenter = Vec(-0.5,-0.5),
        relativePositions = {
          Vec(0,-2),
          Vec(0,-1),
          Vec(0,0),
          Vec(0,1)
        }
      }),
    -- S
    BlockGroup:new({
      pos = Vec(
        3 * Global.BLOCK_SIZE,
        7 * Global.BLOCK_SIZE),
      rotationCenter = Vec(-0.5,-0.5),
      relativePositions = {
        Vec(1,-1),
        Vec(0,-1),
        Vec(0,0),
        Vec(-1,0)
      }
    }),
    -- L
    BlockGroup:new({
      pos = Vec(
        7 * Global.BLOCK_SIZE,
        7 * Global.BLOCK_SIZE),
      relativePositions = {
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1),
        Vec(1,1)
      }
    }),
    -- J
    BlockGroup:new({
      pos = Vec(
        11 * Global.BLOCK_SIZE,
        7 * Global.BLOCK_SIZE),
      relativePositions = {
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1),
        Vec(-1,1)
      }
    }),
    -- I
    BlockGroup:new({
      pos = Vec(
        14 * Global.BLOCK_SIZE,
        7 * Global.BLOCK_SIZE),
      rotationCenter = Vec(-0.5,-0.5),
      relativePositions = {
        Vec(0,-1),
        Vec(0, 0),
        Vec(-1,-1),
        Vec(-1,0)
      }
    })]]
  }
end

function Game:update(dt)
  debugDraw = {}
  self.timer:update(dt)
  if inputManager:keyPressed("escape") then
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
  self.cameraManager:attach()
  for k,v in ipairs(self.blocks) do
    v:draw()
  end
  self.actionManager:draw()
  physicsWorld:draw()
  Util.debugDraw(debugDraw)
  self.cameraManager:detach()
end

function Game:keypressed( key, scancode, isrepeat )
  inputManager:keypressed(key,scancode,isrepeat)
end

function Game:keyreleased(key,scancode)
  inputManager:keyreleased(key,scancode)
end

function Game:mousepressed(x, y, button, isTouch)
  inputManager:mousepressed(x,y,button,isTouch)
end
function Game:mousereleased(x, y, button, isTouch)
  inputManager:mousereleased(x,y,button,isTouch)
end

return Game
