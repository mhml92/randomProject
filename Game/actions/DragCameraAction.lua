DragCameraAction = Class("DragCameraAction", Entity)

function DragCameraAction:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        mouseDelta = Vec(0,0),
        mousePos = Vec(0,0),
      }
    }
  )
end

function DragCameraAction:updateMouse()
  local pos = inputManager:getMousePosition()
  self.mouseDelta = pos - self.mousePos
  self.mousePos = pos
end

function DragCameraAction:update(dt)
  print("DragCameraAction")
  self:updateMouse()
  if inputManager:mouseDown(Global.DRAG_CAMERA) then
    game.cameraManager:move(-self.mouseDelta)
  end
end

function DragCameraAction:draw()
end


return DragCameraAction
