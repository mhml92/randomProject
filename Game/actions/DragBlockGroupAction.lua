DragBlockGroupAction = Class("DragBlockGroupAction", Entity)

function DragBlockGroupAction:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
      }
    }
  )
  self.collider = HCollider:circle(0,0,0.5)
  self:initCollider()

  self.mouseDelta = Vec(0,0)
  self.mousePos = Vec(0,0)

  self.activeBlockGroup = nil
  self.offset = Vec(0,0)

  self:updateMouse()
end

function DragBlockGroupAction:updateMouse()
  local pos = inputManager:getMousePosition()
  self.mouseDelta = pos - self.mousePos
  self.mousePos = pos
end

function DragBlockGroupAction:update(dt)
  self:updateMouse()
  -- update collider
  self.collider:moveTo(self.mousePos.x,self.mousePos.y)


  if self:isHoldingBlockGroup() then

    self:rotateBlockGroup(dt)

    local isPlaceable = self.activeBlockGroup:isPlaceable()

    if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) and isPlaceable then
      self:releaseBlockGroup()
    else
      local blockGroupPos = self.mousePos + self.offset
      blockGroupPos = Util.toGridCoords(blockGroupPos)

      self.activeBlockGroup:setPosition(blockGroupPos.x, blockGroupPos.y)
    end
  else
    ----------------------------------------------------------------------------
    -- IS NOT HOLDING BLOCKGROUP
    if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) then
      self.activeBlockGroup = self:getBlockGroupUnderCursor()

      if self.activeBlockGroup then
        self.offset = self.activeBlockGroup:getPositionVec() - self.mousePos + (self.mousePos - Util.toGridCoords(self.mousePos))
      end
    end
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
  for shape, delta in pairs(HCollider:collisions(self.collider)) do
    return shape.parentBlock.parent
  end
  return nil
end

function DragBlockGroupAction:isHoldingBlockGroup()
  return self.activeBlockGroup ~= nil
end

function DragBlockGroupAction:grapBlockGroup(blockGroup)
  self.activeBlockGroup = blockGroup
end
function DragBlockGroupAction:releaseBlockGroup()
  self.activeBlockGroup = nil
end

function DragBlockGroupAction:draw()
  if self:isHoldingBlockGroup() then
    game.canvas.selection:renderTo(function() self.activeBlockGroup:drawShadowLayer() end)
    game.canvas.selection:renderTo(function() self.activeBlockGroup:drawForeground() end)
    if not self.activeBlockGroup:isPlaceable() then
      game.canvas.selection:renderTo(function()
        love.graphics.setColor(Global.DISABLED_COLOR)
        self.activeBlockGroup:drawFootprint()
      end)
    end
  end

  game.canvas.selection:renderTo(function()
    love.graphics.setColor(255, 0, 0)
    love.graphics.circle("fill", self.mousePos.x, self.mousePos.y, 5, 16)
    love.graphics.setColor(255, 255, 255)
    self.collider:draw()
  end)
end

return DragBlockGroupAction
