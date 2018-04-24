BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        color = Util.randomColor(),
        position = Vec(0,0),
        relativePositions = {
          Vec(0,0),
          Vec(1,0),
          Vec(0,1),
          Vec(-1,0),
        },
      blocks = {
        Block:new(),
        Block:new(),
        Block:new(),
        Block:new()
      },
        blockType = nil
      }
    }
  )
  self:setPosition(self.position)

  for k,v in ipairs(self.blocks) do
    v:setParent(self)
    v:setColor(self.color)
  end
  self:_setInnerJoints()
end

function BlockGroup:setJoints()
  self:_setInnerJoints()
  self:_setNeighborJoints()
end

-- list of blockTypes to apply to BlockGroup blocks
function BlockGroup:setBlockTypes(blockTypes)
  for k,v in ipairs(blockTypes) do
    self.blocks[k]:setBlockType(v)
  end
end

function BlockGroup:_setInnerJoints()
  local pairs = {}
  for i = 1, #self.blocks do
    for j = i + 1, #self.blocks do
      local b1,b2 = self.blocks[i],self.blocks[j]
      if b1:getPositionVec():dist(b2:getPositionVec()) <= Global.BLOCK_SIZE+1 then
        local pair_id = math.min(b1.id,b2.id) .. math.max(b1.id,b2.id)
        if not pairs[pair_id] then
          Util.weldBlocks(self.blocks[i],self.blocks[j],false)
          pairs[pair_id] = true
        end
      end
    end
  end
end

function BlockGroup:_setNeighborJoints()
  local blockGroupId = self.id
  for k,v in ipairs(self.blocks) do

    -- relativly costly -- optimize with vector-light
    -- calculate neighborPos from own position
    local x,y = v:getPositionVec():unpack()
    local neighborPos = {
      Vec(0, -Global.BLOCK_SIZE/2 ):rotateInplace(v:getAngle())+Vec(x,y),
      Vec(0,  Global.BLOCK_SIZE/2 ):rotateInplace(v:getAngle())+Vec(x,y),
      Vec( -Global.BLOCK_SIZE/2, 0):rotateInplace(v:getAngle())+Vec(x,y),
      Vec(  Global.BLOCK_SIZE/2, 0):rotateInplace(v:getAngle())+Vec(x,y)
    }

    for _,pos in ipairs(neighborPos) do
      local neighbours = Util.queryBlocksAt(pos.x,pos.y)
      for __,neighbor_block in ipairs(neighbours) do
        local n = neighbor_block:getObject()
        if (blockGroupId ~= n:getParent().id) then
          Util.weldBlocks(v,n,false)
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
  self:setPosition(self:getPositionVec(),rad)
  --for k,v in ipairs(self.blocks) do
  --  v:setAngle(self:getAngle() + rad )
  --end
end

function BlockGroup:setPosition(pos, rotation)
  local sensorState = self:isSensor()
  self:setSensor(true)
  self:releaseJoints()

  if rotation ~= nil then
    --self:rotate(rotation)
    local rad = (self:getAngle() + rotation) % (2*math.pi)
    print(rad,self:getAngle() + rotation)
    for k,v in ipairs(self.blocks) do
      v:setAngle( rad )
    end
  end

  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * self.relativePositions[k]:rotated(self:getAngle())
    v:setPosition(pos + relPos)
  end

  self:setSensor(sensorState)
  self:_setInnerJoints()
end

function BlockGroup:isSensor()
  return self.blocks[1].collider:isSensor()
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
  for k,v in ipairs(self.blocks) do
    v:draw()
  end
  if Global.DEBUG_MODE then
    -- draw 'CenterBlock'
    love.graphics.setColor(0,255,0)
    local cx,cy = self.blocks[1].collider:getPosition()
    love.graphics.circle("line", cx, cy, Global.BLOCK_SIZE/4, 15)
  end

end

return BlockGroup
