local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        parent = nil,
        width = Global.BLOCK_SIZE,
        height = Global.BLOCK_SIZE,
        color = Util.randomColor(),
      }
    })

  self.image = game.resourceManager:getImg("Game/assets/niels.png")

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

function Block:isPlaceable()
  local x,y = self.collider:getPosition()
  return #Util.queryBlocksAt(x,y) == 0
end

function Block:draw()
  pos = self:getPositionVec()

  love.graphics.setColor(self.color)
  love.graphics.draw( self.image, pos.x, pos.y, self:getAngle(),1,1,Global.BLOCK_SIZE/2,Global.BLOCK_SIZE/2)
end

return Block
