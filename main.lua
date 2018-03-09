Util   = require "Util"
Class  = require "middleclass/middleclass"
Entity = require "Entity"
I      = require "inspect/inspect"
Game   = require "Game/game"



function love.load()
  game = Game:new()
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  love.window.setTitle("FPS: ".. love.timer.getFPS())
  game:draw()
end

function love.keypressed( key, scancode, isrepeat )
  game:keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
  game:keypressed(key,scancode)
end

function love.mousepressed(x, y, button, isTouch)
  game:mousepressed(x,y,button,isTouch)
end
function love.mousereleased(x, y, button, isTouch)
  game:mousereleased(x,y,button,isTouch)
end
