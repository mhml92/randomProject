Vec           = require "hump/vector"
BlockGroup    = require "Game/BlockGroup"
Block         = require "Game/Block"
Global        = require "Game/Global"
Inputmanager  = require "Game/InputManager"
ActionManager = require "Game/ActionManager"

Game = Class("Game", Entity)

function Game:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        actionManager = ActionManager:new(),
        canvas = {
          shadow = love.graphics.newCanvas(),
          foreground = love.graphics.newCanvas(),
          selection = love.graphics.newCanvas(),
        }
      }
    }
  )
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
end

function Game:load()
  self.blocks = {
    -- T
    BlockGroup:new({
      x = 100,
      y = 100,
      relativePositions = {
        Vec(-1,0),
        Vec(0,0),
        Vec(1,0),
        Vec(0,1)
      }
    }),
    -- Z
    BlockGroup:new({
      x = 300,
      y = 100,
      relativePositions = {
        Vec(-1,-1),
        Vec(0,-1),
        Vec(0,0),
        Vec(1,0)
      }
    }),
      -- I
      BlockGroup:new({
        x = 500,
        y = 300,
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
      x = 500,
      y = 100,
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
      x = 700,
      y = 100,
      relativePositions = {
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1),
        Vec(1,1)
      }
    }),
    -- J
    BlockGroup:new({
      x = 100,
      y = 300,
      relativePositions = {
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1),
        Vec(-1,1)
      }
    }),
    -- I
    BlockGroup:new({
      x = 300,
      y = 300,
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
  if inputManager:keyPressed("escape") then
    love.event.quit()
  end
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
    love.graphics.setCanvas(self.canvas.shadow)
    love.graphics.clear()
    love.graphics.setCanvas(self.canvas.foreground)
    love.graphics.clear()
    love.graphics.setCanvas(self.canvas.selection)
    love.graphics.clear()
  for k,v in ipairs(self.blocks) do
    v:draw(dt)
  end
  love.graphics.setCanvas(self.canvas.foreground)
  self.actionManager:draw()
  love.graphics.setCanvas()
  love.graphics.setBlendMode("alpha", "premultiplied")
  love.graphics.setColor(255, 255, 255, 80)
  love.graphics.draw(self.canvas.shadow)
  love.graphics.setColor(255, 255, 255)
  love.graphics.setBlendMode("alpha", "premultiplied")
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
