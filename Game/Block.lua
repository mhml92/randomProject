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
  self.image = love.graphics.newImage("assets/block.png")

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
end

function Block:getPositionVec()
  local x,y = self.collider:getPosition()
  return Vec(x,y)
end

function Block:isPlaceable()
  local x,y = self.collider:getPosition()
  return #Util.queryBlocksAt(x,y) == 0
end

function Block:draw()
  local pos = {}
  pos.x,pos.y = self.collider:getPosition()

  love.graphics.setColor(self.color)
  love.graphics.circle("fill", pos.x, pos.y, Global.BLOCK_SIZE/3, 16)
  love.graphics.setColor(255,255,255)
  love.graphics.circle("fill", pos.x, pos.y, 2, 4)
  love.graphics.draw( self.image, pos.x-Global.BLOCK_SIZE/2, pos.y-Global.BLOCK_SIZE/2, self:getAngle())
end

return Block
