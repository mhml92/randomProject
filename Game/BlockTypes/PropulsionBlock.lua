local PropulsionBlock = Class("PropulsionBlock", BlockType)

function PropulsionBlock:initialize(t)
  BlockType.initialize(self,{
      args = t,
      defaults = {
      }
    })

    self.activationKey = "space"
    self.image = game.resourceManager:getImg("Game/assets/niels_block.png")
end

function PropulsionBlock:update(dt)
  if self.activationKey and inputManager:keyDown(self.activationKey) then
    self:activate()
  end
end

function PropulsionBlock:activate()
    local rot = self.parent:getAngle()
    self.parent.collider:applyForce(Global.BLOCKTYPE_PROPULSIONBLOCK_FORCE*math.cos(rot),Global.BLOCKTYPE_PROPULSIONBLOCK_FORCE*math.sin(rot))
end

function PropulsionBlock:draw()
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

return PropulsionBlock
