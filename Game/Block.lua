local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        isCollidingWithOtherBlock = false,
        width = Global.BLOCK_SIZE,
        height = Global.BLOCK_SIZE,
        color = Util.randomColor(),
        colliderPadding = Global.COLLIDER_PADDING
      }
    })

  self.collider = HCollider:rectangle(
    self.pos.x,
    self.pos.y,
    self.width - self.colliderPadding,
    self.height - self.colliderPadding)
  self:initCollider()

  self.physics = game.physicsWorld:newRectangleCollider(
    self.pos.x,
    self.pos.y,
    Global.BLOCK_SIZE-2,
    Global.BLOCK_SIZE-2)
  self.physics:setSensor(true)
end

function Block:setColor(color)
  self.color = color
end

function Block:setPosition(v)
  self.pos = v
  self:updateCollider()
  self:updatePhysics()
end

function Block:update(dt)
  self:updateCollider()
end

function Block:checkForCollisions()
  self.isCollidingWithOtherBlock = false
  for shape, delta in pairs(HCollider:collisions(self.collider)) do
    if shape.parentBlock.class.name == "Block" then
      self.isCollidingWithOtherBlock = true
    end
  end
end

function Block:isPlaceable()
  return not self.isCollidingWithOtherBlock
end

function Block:updateCollider()
  self.collider:moveTo(self.pos.x,self.pos.y)
end

function Block:updatePhysics()
  self.physics:setPosition(
    self.pos.x,-- - (Global.BLOCK_SIZE-2)/2,
    self.pos.y-- - (Global.BLOCK_SIZE-2)/2
  )
end

function Block:draw()
  love.graphics.setColor(self.color)
  self.collider:draw("fill")

  -- debug
  love.graphics.setColor(Global.BLOCK_LINE_COLOR)
  love.graphics.setLineWidth(2)
  love.graphics.circle("fill", self.pos.x, self.pos.y, 2, 4)
  love.graphics.rectangle("line", self.pos.x-(self.width/2), self.pos.y-(self.height/2), self.width, self.height)
end

function Block:drawShadowLayer()
  love.graphics.setColor(Global.SHADOW_COLOR)
  love.graphics.rectangle("fill", self.pos.x-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.pos.y-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.width, self.height)
end

function Block:drawSilhouette()
  love.graphics.rectangle("fill", self.pos.x-(Global.BLOCK_SIZE/2), self.pos.y-(Global.BLOCK_SIZE/2), self.width, self.height)
end


return Block
