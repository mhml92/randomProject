DragBlockGroupAction = Class("DragBlockGroupAction", Entity)

function DragBlockGroupAction:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        _mouseDelta = Vec(0,0),
        _mousePos = Vec(0,0),
        _activeBlockGroup = nil,
        _offset = Vec(0,0)
      }
    }
  )
end

function DragBlockGroupAction:update(dt)

  self:_updateMouse()
  if self:_isHoldingBlockGroup() then
    self:_update_activeBlockGroup(dt)
  else
    if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) then
      self:_grapBlockGroup(self:_getBlockGroupUnderCursor())
      if self._activeBlockGroup then
        self._offset = self._activeBlockGroup:getPositionVec() - self._mousePos --+ (self._mousePos - Util.toGridCoords(self._mousePos))
      end
    end
  end
end

function DragBlockGroupAction:draw()
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function DragBlockGroupAction:_updateMouse()
  local pos = game.cameraManager:worldCoords(inputManager:getMousePosition())
  self._mouseDelta = pos - self._mousePos
  self._mousePos = pos
end


function DragBlockGroupAction:_update_activeBlockGroup()

  local isPlaceable = self._activeBlockGroup:isPlaceable()
  if inputManager:mouseReleased(Global.DRAG_BLOCKGROUP) and isPlaceable then
    self:_releaseBlockGroup()
  else
    local blockGroupPos = self._mousePos + self._offset
    blockGroupPos = Util.toGridCoords(blockGroupPos, game.blocks[1])

    self._activeBlockGroup:setPosition(blockGroupPos)

    self:_rotateBlockGroup(dt)
    local base = Util.radToVec(game.blocks[1].blocks[1].collider:getAngle())
    local active = Util.radToVec(self._activeBlockGroup.blocks[1].collider:getAngle())
    self._activeBlockGroup:rotate(base:angleTo(active))

  end

end


function DragBlockGroupAction:_rotateBlockGroup(dt)
  if inputManager:keyReleased(Global.ROTATE_BLOCKGROUP_RIGHT) then
      self._activeBlockGroup:rotateRight()
  end

  if inputManager:keyReleased(Global.ROTATE_BLOCKGROUP_LEFT) then
      self._activeBlockGroup:rotateLeft()
  end
end

function DragBlockGroupAction:_getBlockGroupUnderCursor()
  --- this is stupid....
  local max_dist = Global.BLOCK_SIZE
  result = nil
  for _, collider in ipairs(physicsWorld:queryCircleArea(self._mousePos.x, self._mousePos.y,Global.BLOCK_SIZE)) do
    local dist = self._mousePos:dist(collider:getObject():getPositionVec())
    if dist < max_dist then
      result = collider:getObject():getParent()
      max_dist = dist
    end
  end
  return result
end

function DragBlockGroupAction:_isHoldingBlockGroup()
  return self._activeBlockGroup ~= nil
end

function DragBlockGroupAction:_grapBlockGroup(blockGroup)
  if blockGroup then
    self._activeBlockGroup = blockGroup
    self._activeBlockGroup:setSensor(true)
    self._activeBlockGroup:releaseJoints()

    game.cameraManager:shake({duration = 0.1, min = 0, max = 3})
  end
end

function DragBlockGroupAction:_releaseBlockGroup()
  self._activeBlockGroup:setJoints()
  self._activeBlockGroup:setSensor(false)
  self._activeBlockGroup = nil

  game.cameraManager:shake({duration = 0.1, min = 0, max = 3})
end


return DragBlockGroupAction
