Util      = require "Util"
Windfield = require "windfield/windfield"
HC        = require "HC"
Class     = require "middleclass/middleclass"
Entity    = require "Entity"
I         = require "inspect/inspect"
Game      = require "Game/game"

function love.load()
<<<<<<< HEAD
  math.randomseed( os.time() )
=======
  math.randomseed(os.time())
>>>>>>> 36e7b04785498bc270f9c1fd8fe4c783950f4560
  HCollider = HC.new(100)

  inputManager = InputManager:new()

  game = Game:new()
  game:load()
end

function love.update(dt)
  game:update(dt)
  inputManager:reset()
end

function love.draw()
  love.window.setTitle("FPS: ".. love.timer.getFPS())
  game:draw()
end

function love.keypressed( key, scancode, isrepeat )
  game:keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
  game:keyreleased(key,scancode)
end

function love.mousepressed(x, y, button, isTouch)
  game:mousepressed(x,y,button,isTouch)
end
function love.mousereleased(x, y, button, isTouch)
  game:mousereleased(x,y,button,isTouch)
end
