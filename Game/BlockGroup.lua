BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        x = 0,
        y = 0,
        color = Util.randomColor(),
        altColor = false,
        blocks = {
          Block:new(),
          Block:new(),
          Block:new(),
          Block:new()
        },
        -- Relative positions in block units from origo 0,0 + 'positionOffset'
        -- https://tetris.wiki/SRS
        -- default is 'T' tetromino
        positionOffset = Vec(0,0),
        relativePositions = {
          Vec(-1,0),
          Vec(0,0),
          Vec(1,0),
          Vec(0,1)
        }
      }
    }
  )
  for k,v in ipairs(self.blocks) do
    v.parent = self
  end
  self.canvas = love.graphics.newCanvas()
end

function BlockGroup:setPosition(x,y)
  self.x,self.y = x,y
end

function BlockGroup:getPositionVec()
  return Vec(self.x,self.y)
end

function BlockGroup:update(dt)
  self:setBlockPositions()
  self:updateBlocks(dt)
end

function BlockGroup:setBlockPositions()
  local blockSize = self.blocks[1].width
  for k,v in ipairs(self.blocks) do
    local relPos = blockSize * (self.relativePositions[k] + self.positionOffset)
    v:setPosition(self.x + relPos.x, self.y + relPos.y)
  end
end

function BlockGroup:updateBlocks(dt)
  for k,v in ipairs(self.blocks) do
    v:update(dt)
  end
  for k,v in ipairs(self.blocks) do
    v:checkForCollisions()
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
    love.graphics.setColor(self.color)
    v:draw()
  end
  self.altColor = false
end

return BlockGroup
