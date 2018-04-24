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
  if inputManager:keyDown("right") then
    self:applyAngularForce(Global.BLOCKTYPE_CONTROLBLOCK_FORCE)
  end

  if inputManager:keyDown("left") then
    self:applyAngularForce(-Global.BLOCKTYPE_CONTROLBLOCK_FORCE)
  end
end

function ControlBlock:draw()
  local pos = self.parent:getPositionVec()
  local rot = self.parent:getAngle()


  love.graphics.setColor(self.parent.color)
  love.graphics.draw( self.image, pos.x, pos.y, rot, 1, 1, Global.BLOCK_SIZE/2, Global.BLOCK_SIZE/2 )
end

return ControlBlock
