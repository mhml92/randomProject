DragBlockGroupAction = Class("DragBlockGroupAction", Entity)

function DragBlockGroupAction:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        mouseDelta = Vec(0,0),
        mousePos = Vec(0,0),
        activeBlockGroup = nil,
        offset = Vec(0,0)
      }
    }
  )
  self:initCollider()
end

function DragBlockGroupAction:updateMouse()
  local pos = game.cameraManager:worldCoords(inputManager:getMousePosition())
  self.mouseDelta = pos - self.mousePos
  self.mousePos = pos
end

function DragBlockGroupAction:update(dt)
  self:updateMouse()
  -- update collider


  if self:isHoldingBlockGroup() then
    self:updateActiveBlockGroup(dt)
  else
    if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) then
      self:grapBlockGroup(self:getBlockGroupUnderCursor())
      if self.activeBlockGroup then
        self.offset = self.activeBlockGroup:getPositionVec() - self.mousePos --+ (self.mousePos - Util.toGridCoords(self.mousePos))
      end
    end
  end
end

function DragBlockGroupAction:updateActiveBlockGroup()
  self:rotateBlockGroup(dt)

  local isPlaceable = self.activeBlockGroup:isPlaceable()

  if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) and isPlaceable then
    self:releaseBlockGroup()
  else
    local blockGroupPos = self.mousePos + self.offset
    blockGroupPos = Util.toGridCoords(blockGroupPos)
    self.activeBlockGroup:setPosition(blockGroupPos)
  end
end


function DragBlockGroupAction:rotateBlockGroup(dt)
  if inputManager:keyReleased(Global.ROTATE_BLOCKGROUP_RIGHT) then
      self.activeBlockGroup:rotateRight()
  end

  if inputManager:keyReleased(Global.ROTATE_BLOCKGROUP_LEFT) then
      self.activeBlockGroup:rotateLeft()
  end
end

function DragBlockGroupAction:getBlockGroupUnderCursor()
  for _, collider in ipairs(physicsWorld:queryCircleArea(self.mousePos.x, self.mousePos.y,Global.BLOCK_SIZE)) do
    return collider:getObject()
  end
  return nil
end

function DragBlockGroupAction:isHoldingBlockGroup()
  return self.activeBlockGroup ~= nil
end

function DragBlockGroupAction:grapBlockGroup(blockGroup)
  if blockGroup then

    game.cameraManager:shake({duration = 0.1, min = 0, max = 3})
    self.activeBlockGroup = blockGroup
    self.activeBlockGroup:disableDraw()
    self.activeBlockGroup:setSensor(true)
  end
end

function DragBlockGroupAction:releaseBlockGroup()
  self.activeBlockGroup:endableDraw()
  self.activeBlockGroup:setSensor(false)
  self.activeBlockGroup = nil

  game.cameraManager:shake({duration = 0.1, min = 0, max = 3})
end

function DragBlockGroupAction:draw()
  if self:isHoldingBlockGroup() then
    self.activeBlockGroup:endableDraw()

    game.canvas.selection:renderTo(function() self.activeBlockGroup:drawShadowLayer() end)
    game.canvas.selection:renderTo(function() self.activeBlockGroup:drawForeground() end)

    if not self.activeBlockGroup:isPlaceable() then
      game.canvas.selection:renderTo(function()
        love.graphics.setColor(Global.DISABLED_COLOR)
        self.activeBlockGroup:drawSilhouette()
      end)
    end

    self.activeBlockGroup:disableDraw()
  else
    game.canvas.selection:renderTo(function()
      love.graphics.setColor(255, 0, 0)
      --love.graphics.circle("fill", self.mousePos.x, self.mousePos.y, 5, 16)
      love.graphics.setColor(255, 255, 255)
    end)
  end
end

return DragBlockGroupAction
