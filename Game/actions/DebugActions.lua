DebugActions = Class("DebugActions", Entity)

function DebugActions:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        mouseDelta = Vec(0,0),
        mousePos = Vec(0,0),
        mouseWorldPos = Vec(0,0)
      }
    }
  )
end

function DebugActions:updateMouse()
  local pos = inputManager:getMousePosition()
  self.mouseDelta = pos - self.mousePos
  self.mousePos = pos
  self.mouseWorldPos = game.cameraManager:worldCoords(self.mousePos)
end

function DebugActions:update(dt)
  self:updateMouse()

  if inputManager:keyReleased("n") then
    local blockGroup = blockGroupFactory.getRandomBlockGroup(self.mouseWorldPos)
    table.insert(game.blocks,blockGroup)
  end

  if inputManager:keyReleased(Global.ZOOM_IN) then
    game.cameraManager:zoomIn()
  end

  if inputManager:keyReleased(Global.ZOOM_OUT) then
    game.cameraManager:zoomOut()
  end

  if inputManager:keyReleased(Global.ZOOM_RESET) then
    game.cameraManager:zoomTo(1)
  end

  if inputManager:keyReleased(Global.TOGGLE_DEBUG_MODE) then
    Global.DEBUG_MODE = not Global.DEBUG_MODE
    physicsWorld:setQueryDebugDrawing(Global.DEBUG_MODE)
  end

end

function DebugActions:draw()
end


return DebugActions
