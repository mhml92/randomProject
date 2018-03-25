local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
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
  --self:updateCollider()
end

function Block:isPlaceable()
  print(I(self.collider:stay(Global.COLLISION_CLASS_BLOCK)))
  --print((self.collider:exit(Global.COLLISION_CLASS_BLOCK)))
  --print(I(self.collider:getStayCollisionData(Global.COLLISION_CLASS_BLOCK)))
  return true --self.collider:stay()
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
  love.graphics.circle("fill", self.pos.x, self.pos.y, 2, 4)
  --[[
  love.graphics.setColor(self.color)

  -- debug
  love.graphics.setColor(Global.BLOCK_LINE_COLOR)
  love.graphics.setLineWidth(2)
  love.graphics.circle("fill", self.pos.x, self.pos.y, 2, 4)
  love.graphics.rectangle("line", self.pos.x-(self.width/2), self.pos.y-(self.height/2), self.width, self.height)
  ]]
end

function Block:drawShadowLayer()
  --[[
  love.graphics.setColor(Global.SHADOW_COLOR)
  love.graphics.rectangle("fill", self.pos.x-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.pos.y-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.width, self.height)
  ]]
end

function Block:drawSilhouette()
  --[[
  love.graphics.rectangle("fill", self.pos.x-(Global.BLOCK_SIZE/2), self.pos.y-(Global.BLOCK_SIZE/2), self.width, self.height)
  ]]
end


return Block
