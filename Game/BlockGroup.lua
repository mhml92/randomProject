BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        color = Util.randomColor(64),
        blocks = {
          Block:new(),
          Block:new(),
          Block:new(),
          Block:new()
        },
      }
    }
  )
  --correct relativePositions with respect to rotation center
  for k,v in ipairs(self.relativePositions) do
    self.relativePositions[k] = v + self.rotationCenter
  end

  -- set block positions
  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * (self.relativePositions[k])
    v:setPosition(relPos)
  end


  for k,v in ipairs(self.blocks) do
    v:setParent(self)
    v:setColor(self.color)
  end

  self:setJoints()

end

function BlockGroup:setJoints()
  for i = 1, #self.blocks do
    for j = i + 1, #self.blocks do
      Util.weldBlocks(self.blocks[i],self.blocks[j],true)
    end
  end

  --for i = 2, #self.blocks do
  --  Util.weldBlocks(self.blocks[i-1],self.blocks[i],true)
  --end


  -- outer joints
  self:_setNeighborJoints()
end

function BlockGroup:_setNeighborJoints()
  for k,v in ipairs(self.blocks) do

    -- calculate neighbors from own position
    local x,y = v:getPositionVec():unpack()
    local neighbors = {
      Vec(0                       , 0 - Global.BLOCK_SIZE/2 ):rotateInplace(v:getAngle())+Vec(x,y),
      Vec(0                       , 0 + Global.BLOCK_SIZE/2 ):rotateInplace(v:getAngle())+Vec(x,y),
      Vec(0 - Global.BLOCK_SIZE/2 , 0                       ):rotateInplace(v:getAngle())+Vec(x,y),
      Vec(0 + Global.BLOCK_SIZE/2 , 0                       ):rotateInplace(v:getAngle())+Vec(x,y)
    }

    local blockGroupId = self.id
    for _,pos in ipairs(neighbors) do
      for __,neighbor_block in ipairs(Util.queryBlocksAt(pos.x,pos.y)) do
        local n = neighbor_block:getObject()
        if (blockGroupId ~= n:getParent().id) then
          Util.weldBlocks(v,n,true)
        end
      end
    end
  end
end

function BlockGroup:releaseJoints()
  for k,v in ipairs(self.blocks) do
    for _,j in ipairs(v.collider:getJointList()) do
      physicsWorld:removeJoint(j)
    end
  end
end

function BlockGroup:setSensor(isSensor)
  for k,v in ipairs(self.blocks) do
    v.collider:setSensor(isSensor)
  end
end

function BlockGroup:update(dt)
  self:updateBlocks(dt)
end

function BlockGroup:rotateRight()
  self:rotate(math.pi/2)
end

function BlockGroup:rotateLeft()
  self:rotate(-math.pi/2)
end

function BlockGroup:rotate(rad)
  for k,v in ipairs(self.blocks) do
    v:setAngle(self:getAngle() + rad )
  end
end

function BlockGroup:setPosition(pos, rotation)

  if rotation ~= nil then
    self:rotate(rotation)
  end

  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * self.relativePositions[k]:rotated(self:getAngle())
    v:setPosition(pos + relPos)
  end
end

function BlockGroup:getAngle()
  return self.blocks[1]:getAngle()
end

function BlockGroup:getPositionVec()
  return self.blocks[1]:getPositionVec()
end

function BlockGroup:setBlockPositions()
end

function BlockGroup:updateBlocks(dt)
  for k,v in ipairs(self.blocks) do
    v:update(dt)
  end
end

function BlockGroup:isPlaceable()
  for _,v in ipairs(self.blocks) do
    if not v:isPlaceable() then
      return false
    end
  end
  return true
end

function BlockGroup:draw()
  -- draw 'CenterBlock'
  love.graphics.setColor(0,255,0)
  local cx,cy = self.blocks[1].collider:getPosition()
  love.graphics.circle("line", cx, cy, Global.BLOCK_SIZE/4, 15)

  for k,v in ipairs(self.blocks) do
    v:draw()
  end
end

return BlockGroup
