HumpCamera = require "hump/camera"

local CameraManager = Class("CameraManager", Entity)

function CameraManager:initialize(t)
  Entity.initialize(self,{
    args = t,
    defaults = {
      camera = HumpCamera(0,0),
      pos = Vec(0,0)
    }
  })
  self.camera:lookAt(self.pos.x,self.pos.y)
end

function CameraManager:update(dt)
end

function CameraManager:worldCoords(v)
  local x,y = self.camera:worldCoords(v.x,v.y)
  return Vec(x,y)
end

function CameraManager:move(v)
  self.pos = self.pos + v
  self.camera:lookAt(self.pos.x,self.pos.y)
end

function CameraManager:attach()
  self.camera:attach()
end

function CameraManager:shake(t)
  assert(t.duration)
  assert(t.min)
  assert(t.max)

  game.timer:during(
    t.duration,
    function()
      local offset = Vec.randomDirection(t.min,t.max)
      self.camera:lookAt(
        self.pos.x + offset.x,
        self.pos.y + offset.y)
    end,
    function()
      self.camera:lookAt(self.pos.x, self.pos.y)
    end)
end

function CameraManager:detach()
  self.camera:detach()
end

return CameraManager
