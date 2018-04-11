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

local function getRandom(pos)
  local p = math.random(1, 7)
  if p == 1 then
    return getT(pos)
  elseif p == 2 then
    return getZ(pos)
  elseif p == 3 then
    return getL(pos)
  elseif p == 4 then
    return getJ(pos)
  elseif p == 5 then
    return getO(pos)
  elseif p == 6 then
    return getS(pos)
  elseif p == 7 then
    return getI(pos)
  end
end

return {
  getRandom = getRandom,
  getT = getT,
  getZ = getZ,
  getL = getL,
  getJ = getJ,
  getO = getO,
  getS = getS
}
