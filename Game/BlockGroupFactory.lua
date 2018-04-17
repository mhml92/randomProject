-- 'Center block' is relativePositions[1]
-- 'Center block' has relative position 0,0
-- rotation center is 'Center block' + rotationOffset
-- Block position IS rotation center
local function getT(pos)
  return BlockGroup:new({
    rotationCenter = Vec(0,0),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(1,0),
      Vec(0,1),
      Vec(-1,0),
    }
  })
end

local function getZ(pos)
  return BlockGroup:new({
    rotationCenter = Vec(0,0),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(-1,-1),
      Vec(0,-1),
      Vec(1,0)
    }
  })
end

local function getS(pos)
  return BlockGroup:new({
    rotationCenter = Vec(0,0),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(1,-1),
      Vec(0,-1),
      Vec(-1,0)
    }
  })
end

local function getL(pos)
  return BlockGroup:new({
    rotationCenter = Vec(0,0),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(0,-1),
      Vec(0,1),
      Vec(1,1)
    }
  })
end

local function getJ(pos)
  return BlockGroup:new({
    rotationCenter = Vec(0,0),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(0,-1),
      Vec(0,1),
      Vec(-1,1)
    }
  })
end

local function getO(pos)
  return BlockGroup:new({
    rotationCenter = Vec(-0.5,-0.5),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(0,-1),
      Vec(-1,-1),
      Vec(-1,0)
    }
  })
end

local function getI(pos)
  return BlockGroup:new({
    rotationCenter = Vec(-0.5,-0.5),
    position = pos,
    relativePositions = {
      Vec(0,0),
      Vec(0,1),
      Vec(0,-2),
      Vec(0,-1)
    }
  })
end

local function randomBlockGroup(pos)
  local p = math.random(1, 7)
  local blockGroup = nil

  if p == 1 then
    blockGroup = getT(pos)
  elseif p == 2 then
    blockGroup = getZ(pos)
  elseif p == 3 then
    blockGroup = getL(pos)
  elseif p == 4 then
    blockGroup = getJ(pos)
  elseif p == 5 then
    blockGroup = getO(pos)
  elseif p == 6 then
    blockGroup = getS(pos)
  elseif p == 7 then
    blockGroup = getI(pos)
  end
  blockGroup:rotate(math.random(1, 4) * math.pi/2)
  return blockGroup
end

local function getRandomControlBlockGroup(pos)
  local blockGroup = randomBlockGroup(pos)

  blockGroup:setBlockTypes({
    ControlBlock:new(),
    ControlBlock:new(),
    ControlBlock:new(),
    ControlBlock:new()
  })
  return blockGroup
end

local function getRandomBlockGroup(pos)
  local blockGroup = randomBlockGroup(pos)

  blockGroup:setBlockTypes({
    PropulsionBlock:new(),
    PropulsionBlock:new(),
    PropulsionBlock:new(),
    PropulsionBlock:new()
  })

  return blockGroup
end

return {
  getRandomControlBlockGroup = getRandomControlBlockGroup,
  getRandomBlockGroup = getRandomBlockGroup,
  getT = getT,
  getZ = getZ,
  getL = getL,
  getJ = getJ,
  getO = getO,
  getS = getS
}
