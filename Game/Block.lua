local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        x = 0,
        y = 0,
        isCollidingWithOtherBlock = false,
        width = Global.BLOCK_SIZE,
        height = Global.BLOCK_SIZE,
        color = Util.randomColor(),
        colliderPadding = Global.COLLIDER_PADDING
      }
    })

  self.collider = HCollider:rectangle(
    self.x,
    self.y,
    self.width-self.colliderPadding,
    self.height-self.colliderPadding)
  self:initCollider()
  self:updateCollider()
end

function Block:setColor(color)
  self.color = color
end

function Block:setPosition(x,y)
  self.x, self.y = x,y
  self:updateCollider()
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
  self.collider:moveTo(self.x,self.y)
end

function Block:draw()
  love.graphics.setColor(self.color)
  self.collider:draw("fill")

  -- debug
  love.graphics.setColor(Global.BLOCK_LINE_COLOR)
  love.graphics.setLineWidth(2)
  love.graphics.circle("fill", self.x, self.y, 2, 4)
  love.graphics.rectangle("line", self.x-(self.width/2), self.y-(self.height/2), self.width, self.height)
end

function Block:drawShadowLayer()
  love.graphics.setColor(Global.SHADOW_COLOR)
  love.graphics.rectangle("fill", self.x-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.y-(Global.BLOCK_SIZE/2)+Global.SHADOW_DISTANCE, self.width, self.height)
end

function Block:drawSilhouette()
  love.graphics.rectangle("fill", self.x-(Global.BLOCK_SIZE/2), self.y-(Global.BLOCK_SIZE/2), self.width, self.height)
end


function Block:setPosition(x,y)
  self.x, self.y = x,y
end


return Block
