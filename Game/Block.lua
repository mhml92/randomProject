local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        parent = nil,
        width = Global.BLOCK_SIZE,
        height = Global.BLOCK_SIZE,
        color = Util.randomColor(64),
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
end

function Block:setParent(p)
  self.parent = p
end

function Block:getParent()
  return self.parent
end

function Block:setColor(color)
  self.color = color
end

function Block:setPosition(v)
  self.pos = v
  self:updateCollider()
end

function Block:update(dt)
  self:_updatePosition(dt)
end

function Block:getPositionVec()
  local x,y = self.collider:getPosition()
  return Vec(x,y)
end

function Block:isPlaceable()
  local x,y = self.collider:getPosition()
  x = x - Global.BLOCK_SIZE/2
  y = y - Global.BLOCK_SIZE/2
  return #physicsWorld:queryRectangleArea(x,y, Global.BLOCK_SIZE, Global.BLOCK_SIZE, {Global.COLLISION_CLASS_BLOCK}) == 0
end

function Block:_updatePosition(dt)
  local x,y = self.collider:getPosition()
  self.pos.x,self.pos.y = x,y
end

function Block:updateCollider()
  self.collider:setPosition(
    self.pos.x,
    self.pos.y
  )
end

function Block:draw()
  love.graphics.setColor(self.color)
  love.graphics.circle("fill", self.pos.x, self.pos.y, Global.BLOCK_SIZE/3, 16)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("fill", self.pos.x, self.pos.y, 2, 4)
end

return Block
