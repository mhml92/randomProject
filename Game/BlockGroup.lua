BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        color = Util.randomColor(),
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

  -- correct relativePositions with respect to rotation center
  for k,v in ipairs(self.relativePositions) do
    self.relativePositions[k] = v - self.rotationCenter
  end

  -- set block positions
  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * (self.relativePositions[k] + self.rotationCenter)
    v:setPosition(self.pos + relPos)
  end

  self:setInnerJoints()

  for k,v in ipairs(self.blocks) do
    v.collider:setObject(self)
    v:setColor(self.color)
  end
end

function BlockGroup:setInnerJoints()
  self.joints = {}
  for i = 2, #self.blocks do
    local b1,b2 = self.blocks[i-1],self.blocks[i]
    table.insert(self.joints,physicsWorld:addJoint('WeldJoint', b1.collider, b2.collider, b1.pos.x, b1.pos.y, true))
  end
end

function BlockGroup:releaseInnerJoints()
  for k,v in ipairs(self.joints) do
    physicsWorld:removeJoint(v)
  end
  self.joints = nil
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
  --local angle = self.blocks[1].collider:getAngle()
  --self.blocks[1].collider:setAngle(angle + math.pi/2)
  for _,v in ipairs(self.relativePositions) do
    v:rotateInplace(math.pi/2)
  end
end

function BlockGroup:rotateLeft()
  --local angle = self.blocks[1].collider:getAngle()
  --self.blocks[1].collider:setAngle(angle - math.pi/2)
  for _,v in ipairs(self.relativePositions) do
    v:rotateInplace(-math.pi/2)
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
  for k,v in ipairs(self.blocks) do
    local relPos = Global.BLOCK_SIZE * (self.relativePositions[k] + self.rotationCenter)
    v:setPosition(self.pos + relPos)
  end
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
end

return BlockGroup
