local ControlBlock = Class("ControlBlock", BlockType)

function ControlBlock:initialize(t)
  BlockType.initialize(self,{
      args = t,
      defaults = {}
    })

    self.image = game.resourceManager:getImg("Game/assets/niels.png")
end

function ControlBlock:update(dt)
  
end

function ControlBlock:draw()
  local pos = self.parent:getPositionVec()
  local rot = self.parent:getAngle()

  love.graphics.setColor(self.parent.color)
  love.graphics.draw( self.image, pos.x, pos.y, rot, 1, 1, Global.BLOCK_SIZE/2, Global.BLOCK_SIZE/2 )
end


function ControlBlock:turnRight()
  self:applyAngularForce(Global.BLOCKTYPE_CONTROLBLOCK_FORCE)
end

function ControlBlock:turnLeft()
  self:applyAngularForce(-Global.BLOCKTYPE_CONTROLBLOCK_FORCE)
end

return ControlBlock
