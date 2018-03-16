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

function Game:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        timer = Timer:new(),
        actionManager = ActionManager:new(),
        cameraManager = CameraManager:new(),
        canvas = {
          shadow = love.graphics.newCanvas(),
          foreground = love.graphics.newCanvas(),
          selection = love.graphics.newCanvas(),
        }
      }
    }
  )
  love.mouse.setVisible(false)
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
end

function Game:load()
  self.blocks = {
    blockGroupFactory.getT(),
    blockGroupFactory.getT(),
    blockGroupFactory.getT(),
    blockGroupFactory.getT(),
    -- T
    BlockGroup:new({
      pos = Vec(
        3 * Global.BLOCK_SIZE,
        3 * Global.BLOCK_SIZE),
      relativePositions = {
        Vec(-1,0),
        Vec(0,0),
        Vec(1,0),
        Vec(0,1)
      }
    }),
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
        Vec(0,0),
        Vec(-1,-1),
        Vec(-1,0)
      }
    })
  }
end

function Game:update(dt)
  self.timer:update(dt)
  if inputManager:keyPressed("escape") then
    love.event.quit()
  end
  self.actionManager:update(dt)
  self:updateActiveBlocks(dt)
end

function Game:updateActiveBlocks(dt)
  self.cameraManager:update(dt)
  for k,v in ipairs(self.blocks) do
    if v:isActive() then
      v:update(dt)
    end
  end
end

function Game:draw()

  love.graphics.setCanvas(self.canvas.shadow)
  love.graphics.clear()
  love.graphics.setCanvas(self.canvas.foreground)
  love.graphics.clear()
  love.graphics.setCanvas(self.canvas.selection)
  love.graphics.clear()

  self.cameraManager:attach()
  for k,v in ipairs(self.blocks) do
    v:draw(dt)
  end
  love.graphics.setCanvas(self.canvas.foreground)
  self.actionManager:draw()
  self.cameraManager:detach()
  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha")
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(self.canvas.shadow)
  love.graphics.draw(self.canvas.foreground)
  love.graphics.draw(self.canvas.selection)


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
