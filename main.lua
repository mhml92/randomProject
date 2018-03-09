-- globag Class
Class        = require "middleclass/middleclass"
I            = require "inspect/inspect"
Windfield    = require "windfield/windfield"
HC           = require "HC"
Vec          = require "hump/vector"
Entity       = require "Entity"
BlockGroup   = require "BlockGroup"
Block        = require "Block"
Util         = require "Util"
ActionManager = require "ActionManager"


function love.load()
  HCollider = HC.new(100)
  actionManager = ActionManager:new()

  blocks = {
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
      positionOffset = Vec(0.5,0.5),
      relativePositions = {
        Vec(0,-2),
        Vec(0,-1),
        Vec(0,0),
        Vec(0,1)
      }
    })
  }
end

function love.update(dt)
  actionManager:update(dt)
  for k,v in ipairs(blocks) do
    v:update(dt)
  end
end

function love.draw()
  love.window.setTitle("FPS: ".. love.timer.getFPS())
  for k,v in ipairs(blocks) do
    v:draw(dt)
  end
  actionManager:draw()
end
