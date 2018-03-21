BlockGroup = Class("BlockGroup", Entity)

function BlockGroup:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        pos = Vec(0,0),
        drawActive = true,
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
  self:setBlockPositions()

  self.joints = {}
  for i = 2, #self.blocks do
    local b1,b2 = self.blocks[i-1],self.blocks[i]
    table.insert(self.joints,game.physicsWorld:addJoint('WeldJoint', b1.physics, b2.physics, b1.pos.x, b1.pos.y, false))
  end
  print(#self.joints)

  for k,v in ipairs(self.blocks) do
    v.parent = self
    v:setColor(self.color)
  end
end

function BlockGroup:update(dt)
  self:updateBlocks(dt)
end

function BlockGroup:rotateRight()
  for _,v in ipairs(self.relativePositions) do
    v:rotateInplace(math.pi/2)
  end
end

function BlockGroup:rotateLeft()
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
  local blockSize = Global.BLOCK_SIZE
  for k,v in ipairs(self.blocks) do
    local relPos = blockSize * (self.relativePositions[k] + self.rotationCenter)
    v:setPosition(self.pos + relPos)
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
  if self.drawActive then
    for k,v in ipairs(self.blocks) do
      game.canvas.foreground:renderTo( function() v:draw() end)
      --game.canvas.shadow:renderTo(function() v:drawShadowLayer() end)
    end
  end
end

function BlockGroup:drawForeground()
  if self.drawActive then
    for k,v in ipairs(self.blocks) do
      v:draw()
    end
  end
end
function BlockGroup:drawShadowLayer()
  if self.drawActive then
    for k,v in ipairs(self.blocks) do
      v:drawShadowLayer()
    end
  end
end

function BlockGroup:drawSilhouette()
  if self.drawActive then
    for k,v in ipairs(self.blocks) do
      v:drawSilhouette()
    end
  end
end

function BlockGroup:disableDraw()
  self.drawActive = false
end

function BlockGroup:endableDraw()
  self.drawActive = true
end

return BlockGroup
