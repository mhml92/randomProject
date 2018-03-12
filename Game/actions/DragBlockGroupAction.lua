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


  if self.activeBlockGroup then
    self:rotateBlockGroup(dt)
    local isPlaceable = self.activeBlockGroup:isPlaceable()
    if inputManager:isMouseReleased(Global.DRAG_BLOCKGROUP) and isPlaceable then
      self:releaseBlockGroup()
    else
      if not isPlaceable then
        --
        --
      end
      local blockGroupPos = self.mousePos + self.offset
      blockGroupPos = Vec(Util.round(blockGroupPos.x/Global.BLOCK_SIZE),Util.round(blockGroupPos.y/Global.BLOCK_SIZE))*Global.BLOCK_SIZE
      self.activeBlockGroup:setPosition(blockGroupPos.x, blockGroupPos.y)
    end
  else
    if inputManager:isMouseReleased(Global.DRAG_BLOCKGROUP) then
      self.activeBlockGroup = self:getBlockGroup()
      if self.activeBlockGroup then
        self.offset = self.activeBlockGroup:getPositionVec() - self.mousePos
      end
    end
  end
end

function DragBlockGroupAction:rotateBlockGroup(dt)
  if inputManager:isKeyReleased(Global.ROTATE_BLOCKGROUP_RIGHT) then
      self.activeBlockGroup:rotateRight()
  end

  if inputManager:isKeyReleased(Global.ROTATE_BLOCKGROUP_LEFT) then
      self.activeBlockGroup:rotateLeft()
  end
end

function DragBlockGroupAction:getBlockGroup()
  for shape, delta in pairs(HCollider:collisions(self.collider)) do
    return shape.parentBlock.parent
  end
  return nil
end

function DragBlockGroupAction:grapBlockGroup(blockGroup)
  self.activeBlockGroup = blockGroup
end
function DragBlockGroupAction:releaseBlockGroup()
  self.activeBlockGroup = nil
end

function DragBlockGroupAction:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", self.mousePos.x, self.mousePos.y, 5, 16)
  love.graphics.setColor(255, 255, 255)
  self.collider:draw()
end

return DragBlockGroupAction
