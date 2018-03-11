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

  self.currentBlockGroup = nil
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


  if self.currentBlockGroup then
    local isPlaceable = self.currentBlockGroup:isPlaceable()
    if inputManager:isMouseReleased(1) and isPlaceable then
      self.currentBlockGroup = nil
    else
      if not isPlaceable then
        --
        --
      end
      local blockGroupPos = self.mousePos + self.offset
      blockGroupPos = Vec(Util.round(blockGroupPos.x/Global.BLOCK_SIZE),Util.round(blockGroupPos.y/Global.BLOCK_SIZE))*Global.BLOCK_SIZE
      self.currentBlockGroup:setPosition(blockGroupPos.x, blockGroupPos.y)
    end
  else
    if inputManager:isMouseReleased(1) then
      self.currentBlockGroup = self:getBlockGroup()
      if self.currentBlockGroup then
        self.offset = self.currentBlockGroup:getPositionVec() - self.mousePos
      end
    end
  end
end

function DragBlockGroupAction:getBlockGroup()
  for shape, delta in pairs(HCollider:collisions(self.collider)) do
    return shape.parentBlock.parent
  end
  return nil
end

function DragBlockGroupAction:draw()
  love.graphics.setColor(255, 0, 0)
  love.graphics.circle("fill", self.mousePos.x, self.mousePos.y, 5, 16)
  love.graphics.setColor(255, 255, 255)
  self.collider:draw()
end

return DragBlockGroupAction
