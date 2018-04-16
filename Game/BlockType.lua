local BlockType = Class("BlockType", Entity)

function BlockType:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        parent = nil,
        activationKey = "space",
      }
    })

  self.image = game.resourceManager:getImg("Game/assets/niels.png")
end

function BlockType:setParent(p)
  self.parent = p
end

function BlockType:update(dt)
  if self.activationKey and inputManager:keyDown(self.activationKey) then
    local rot = self.parent:getAngle()
    self.parent.collider:applyForce(100*math.cos(rot),100*math.sin(rot))
  end
end

function BlockType:draw()
  local pos = self.parent:getPositionVec()
  local rot = self.parent:getAngle()


  love.graphics.setColor(self.parent.color)
  love.graphics.draw( self.image, pos.x, pos.y, rot, 1, 1, Global.BLOCK_SIZE/2, Global.BLOCK_SIZE/2 )

  if Global.DEBUG_MODE then
    love.graphics.setColor(255,255,255)
    local tmp = Vec(math.cos(rot)*Global.BLOCK_SIZE/2, math.sin(rot)*Global.BLOCK_SIZE/2)
    local tip = (pos + tmp)-(tmp/2)
    local r_corner = (pos + tmp:rotated(math.pi/2)/2)-(tmp/2)
    local l_corner = (pos + tmp:rotated(-math.pi/2)/2)-(tmp/2)
    local vertices = {
      r_corner.x,r_corner.y,
      l_corner.x,l_corner.y,
      tip.x,tip.y
    }
    love.graphics.polygon("fill",vertices)
  end
end

return BlockType
