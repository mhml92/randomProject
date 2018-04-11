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
    local blockGroup = blockGroupFactory.getRandom(self.mouseWorldPos)
    table.insert(game.blocks,blockGroup)
  end

  if inputManager:mouseReleased(2) then
    local colliders = physicsWorld:queryCircleArea(self.mouseWorldPos.x, self.mouseWorldPos.y, 100)
    for _, collider in ipairs(colliders) do
      collider:applyAngularImpulse(100)
    end
  end

  if inputManager:keyReleased(Global.ZOOM_IN) then
    print("hallo")
    game.cameraManager:zoomTo(2)
  end

  if inputManager:keyReleased(Global.ZOOM_OUT) then
    game.cameraManager:zoomTo(1)
  end

end

function DebugActions:draw()
end


return DebugActions
