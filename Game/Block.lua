
local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        parent = nil,
        blockType = nil,
        width = Global.BLOCK_SIZE,
        height = Global.BLOCK_SIZE,
        color = Util.randomColor(),
      }
    })


  self:_initCollider()
end

function Block:_initCollider()
  self.collider = physicsWorld:newRectangleCollider(
    self.pos.x - (Global.BLOCK_SIZE - Global.COLLIDER_PADDING)/2,
    self.pos.y - (Global.BLOCK_SIZE - Global.COLLIDER_PADDING)/2,
    Global.BLOCK_SIZE - Global.COLLIDER_PADDING,
    Global.BLOCK_SIZE - Global.COLLIDER_PADDING)

  self.collider:setCollisionClass(Global.COLLISION_CLASS_BLOCK)
  self.collider:setObject(self)
  self.collider:setSensor(false)
  self.collider:setLinearDamping(Global.BLOCK_LINEARDAMPING)
end

function Block:setParent(p)
  self.parent = p
end

function Block:setBlockType(blockType)
  blockType:setParent(self)
  self.blockType = blockType
end

function Block:getParent()
  return self.parent
end

function Block:getPositionVec()
  local x,y = self.collider:getPosition()
  return Vec(x,y)
end

function Block:getAngle()
  return self.collider:getAngle()
end

function Block:setColor(color)
  self.color = color
end

function Block:setPosition(v)
  self.collider:setPosition(v.x, v.y)
end

function Block:setAngle(rad)
  self.collider:setAngle(rad)
end

function Block:update(dt)
  self.blockType:update(dt)
end

function Block:isPlaceable()
  local x,y = self.collider:getPosition()
  return #Util.queryBlocksAt(x,y) == 0
end

function Block:draw()
  self.blockType:draw()
end

return Block
