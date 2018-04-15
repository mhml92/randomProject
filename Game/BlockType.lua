local BlockType = Class("BlockType", Entity)

function BlockType:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        parent = nil,
      }
    })

  self.image = game.resourceManager:getImg("Game/assets/niels.png")
end

function BlockType:setParent(p)
  self.parent = p
end

function BlockType:update(dt)
  if inputManager:keyDown(Global.ACCELERATE) then
    local rot = self.parent:getAngle()
    self.parent.collider:applyForce(10*math.cos(rot),10*math.sin(rot))
  end
end

function BlockType:draw()
  local pos = self.parent:getPositionVec()
  local rot = self.parent:getAngle()


  love.graphics.setColor(self.parent.color)
  love.graphics.draw( self.image, pos.x, pos.y, rot, 1, 1, Global.BLOCK_SIZE/2, Global.BLOCK_SIZE/2 )

  if Global.DEBUG_MODE then
    love.graphics.setColor(255,255,255)
    love.graphics.line(pos.x, pos.y, pos.x+(math.cos(rot)*Global.BLOCK_SIZE/2), pos.y+(math.sin(rot)*Global.BLOCK_SIZE/2))
  end
end

return BlockType
