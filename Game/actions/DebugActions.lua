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
    table.insert(game.blocks,blockGroupFactory.getRandom())
  end

  if inputManager:mouseReleased(2) then
    local colliders = physicsWorld:queryCircleArea(self.mouseWorldPos.x, self.mouseWorldPos.y, 100)
    for _, collider in ipairs(colliders) do
      collider:applyAngularImpulse(100)
    end
  end

end

function DebugActions:draw()
end


return DebugActions
