local ControlBlock = Class("ControlBlock", BlockType)

function ControlBlock:initialize(t)
  BlockType.initialize(self,{
      args = t,
      defaults = {
      }
    })

    self.image = game.resourceManager:getImg("Game/assets/niels_block.png")
end

function ControlBlock:applyAngularForce(force)
  self.parent.collider:applyAngularImpulse(force)
end

function ControlBlock:update(dt)
  local force = 500
  if inputManager:keyDown("right") then
    self:applyAngularForce(force)
  end

  if inputManager:keyDown("left") then
    self:applyAngularForce(-force)
  end
end

function ControlBlock:draw()
  local pos = self.parent:getPositionVec()
  local rot = self.parent:getAngle()


  love.graphics.setColor(self.parent.color)
  love.graphics.draw( self.image, pos.x, pos.y, rot, 1, 1, Global.BLOCK_SIZE/2, Global.BLOCK_SIZE/2 )
end

return ControlBlock
