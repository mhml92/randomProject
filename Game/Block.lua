local Block = Class("Block", Entity)

function Block:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        x = 0,
        y = 0,
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
  self.collider.parentBlock = self

  self:updateCollider()
end

function Block:setPosition(x,y)
  self.x, self.y = x,y
  self:updateCollider()
end

function Block:update(dt)
  self:updateCollider()
end

function Block:checkForCollisions()
  for shape, delta in pairs(HCollider:collisions(self.collider)) do
    --self.color = Util.randomColor()
  end
end

function Block:updateCollider()
  self.collider:moveTo(self.x,self.y)
end

function Block:draw()
  love.graphics.setColor(self.color)
  self.collider:draw("fill")

  -- debug
  love.graphics.setColor({255,255,255})
  love.graphics.circle("fill", self.x, self.y, 2, 8)
  love.graphics.rectangle("line", self.x-(self.width/2), self.y-(self.height/2), self.width, self.height)

end

function Block:setPosition(x,y)
  self.x, self.y = x,y
end


return Block
