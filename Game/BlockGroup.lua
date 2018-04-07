BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        color = Util.randomColor(64),
        blocks = {
          Block:new(),
          Block:new(),
          Block:new(),
          Block:new()
        },
        -- Relative positions in block units from rotation center 0,0 + 'rotationCenter'
        -- https://tetris.wiki/SRS
        -- default is 'T' tetromino
        rotationCenter = Vec(0,0),
        relativePositions = {
          Vec(-1,0),
          Vec(0,0),
          Vec(1,0),
          Vec(0,1)
        }
      }
    }
  )

  self.originalRelativePositions = {}
  for k,v in ipairs(self.relativePositions) do
    table.insert(self.originalRelativePositions, v:clone())
  end

  -- correct relativePositions with respect to rotation center
  for k,v in ipairs(self.relativePositions) do
    self.relativePositions[k] = v - self.rotationCenter
  end

  -- set block positions
  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * (self.relativePositions[k] + self.rotationCenter)
    v:setPosition(self.pos + relPos)
  end


  for k,v in ipairs(self.blocks) do
    v:setParent(self)
    v:setColor(self.color)
  end

  self:setJoints()

end

function BlockGroup:setJoints()
  -- inner joints
  for i = 2, #self.blocks do
    local b1,b2 = self.blocks[i-1],self.blocks[i]
    local anchor_point = ((b2.pos - b1.pos)/2) + b1.pos
    physicsWorld:addJoint('WeldJoint', b1.collider, b2.collider, anchor_point.x, anchor_point.y, true)
  end

  -- outer joints
  self:_setNeighborJoints()
end

function BlockGroup:_setNeighborJoints()
  for k,v in ipairs(self.blocks) do

    -- calculate neighbors from own position
    local x,y = v.collider:getPosition()

    local neighbors = {
      {x = x, y = y - Global.BLOCK_SIZE},
      {x = x, y = y + Global.BLOCK_SIZE},
      {x = x - Global.BLOCK_SIZE, y = y},
      {x = x + Global.BLOCK_SIZE, y = y}
    }

    local blockGroupId = self.id
    for _,pos in ipairs(neighbors) do
      for __,neighbor_block in ipairs(Util.queryBlocksAt(pos.x,pos.y)) do
        local n = neighbor_block:getObject()
        if not (blockGroupId == n:getParent().id) then
          local b1,b2 = v, n
          local anchor_point = ((b2.pos - b1.pos)/2) + b1.pos
          physicsWorld:addJoint('WeldJoint', b1.collider, b2.collider, anchor_point.x, anchor_point.y, true)
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
  for k,v in ipairs(self.relativePositions) do
    self.relativePositions[k]:rotateInplace( rad )
    self.blocks[k].collider:setAngle(self.blocks[k].collider:getAngle()+rad)
  end
end

function BlockGroup:setPosition(v)
  self.pos = v:clone()
  self:setBlockPositions()
end

function BlockGroup:getPositionVec()
  return self.pos:clone()
end

function BlockGroup:setBlockPositions()
  local rt = self.rotationCenter:clone()
  rt:rotateInplace(self.blocks[1].collider:getAngle())
  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * (self.relativePositions[k] + rt)--self.rotationCenter)
    v:setPosition(self.pos + relPos)
  end
end

function BlockGroup:updateBlocks(dt)
  local rot = self.blocks[1].collider:getAngle()
  for k,v in ipairs(self.relativePositions) do
    self.relativePositions[k] = self.originalRelativePositions[k]:rotated(rot)
  end
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
end

return BlockGroup
