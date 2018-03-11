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
        actionManager = ActionManager:new()
      }
    }
  )
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
end

function Game:load()
  self.blocks = {
    -- T
    BlockGroup:new({x = 100, y = 100}),
    -- Z
    BlockGroup:new({
      x = 200,
      y = 200,
      relativePositions = {
        Vec(-1,0),
        Vec(0,0),
        Vec(0,1),
        Vec(1,1)
      }
    }),
    -- I
    BlockGroup:new({
      x = 300,
      y = 300,
      rotationCenter = Vec(-0.5,-0.5),
      relativePositions = {
        Vec(0,-2),
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1)
      }
    })
  }
end

function Game:update(dt)
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
  for k,v in ipairs(self.blocks) do
    v:draw(dt)
  end
  self.actionManager:draw()
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
