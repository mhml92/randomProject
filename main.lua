Windfield = require "windfield/windfield"
Class     = require "middleclass/middleclass"
Entity    = require "Entity"
I         = require "inspect/inspect"
Game      = require "Game/game"
Util      = require "Util"

function love.load()
  love.graphics.setBackgroundColor(Global.BACKGROUD_COLOR)
  math.randomseed(os.time())
  love.graphics.setDefaultFilter( "nearest", "nearest" )
  inputManager = InputManager:new()
  physicsWorld = Windfield.newWorld(0,0,true)

  physicsWorld:addCollisionClass(Global.COLLISION_CLASS_BLOCK)

  game = Game:new()
  game:load()
end

function love.update(dt)
  physicsWorld:update(dt)
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
