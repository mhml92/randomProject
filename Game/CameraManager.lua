HumpCamera = require "hump/camera"

local CameraManager = Class("CameraManager", Entity)

function CameraManager:initialize(t)
  Entity.initialize(self,{
    args = t,
    defaults = {
        camera = HumpCamera(0,0)
    }
  })
end

function CameraManager:update(dt)

end

function CameraManager:worldCoords(v)
  local x,y = self.camera:worldCoords(v.x,v.y)
  return Vec(x,y)
end

function CameraManager:move(v)
  self.camera:move(v.x,v.y)
end

function CameraManager:attach()
  self.camera:attach()
end

function CameraManager:detach()
  self.camera:detach()
end

return CameraManager
