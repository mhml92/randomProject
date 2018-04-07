local function getT()
  return BlockGroup:new({
    pos = Vec(0,0),
    relativePositions = {
      Vec(-1,0),
      Vec(0,0),
      Vec(1,0),
      Vec(0,1)
    }
  })
end

local function getZ()
  return BlockGroup:new({
    pos = Vec(0,0),
    relativePositions = {
      Vec(-1,-1),
      Vec(0,-1),
      Vec(0,0),
      Vec(1,0)
    }
  })
end

local function getO()
  return BlockGroup:new({
    pos = Vec(0,0),
    rotationCenter = Vec(-0.5,-0.5),
    relativePositions = {
      Vec(0,-2),
      Vec(0,-1),
      Vec(0,0),
      Vec(0,1)
    }
  })
end

local function getS()
  return BlockGroup:new({
    pos = Vec(0,0),
    rotationCenter = Vec(-0.5,-0.5),
    relativePositions = {
      Vec(1,-1),
      Vec(0,-1),
      Vec(0,0),
      Vec(-1,0)
    }
  })
end

local function getL()
  return BlockGroup:new({
    pos = Vec(0,0),
    relativePositions = {
      Vec(0,-1),
      Vec(0,0),
      Vec(0,1),
      Vec(1,1)
    }
  })
end

local function getJ()
  return BlockGroup:new({
    pos = Vec(0,0),
    relativePositions = {
      Vec(0,-1),
      Vec(0,0),
      Vec(0,1),
      Vec(-1,1)
    }
  })
end

local function getO()
  return BlockGroup:new({
    pos = Vec(0,0),
    rotationCenter = Vec(-0.5,-0.5),
    relativePositions = {
      Vec(0,-1),
      Vec(0,0),
      Vec(-1,-1),
      Vec(-1,0)
    }
  })
end

local function getI()
  return BlockGroup:new({
    pos = Vec(0,0),
    rotationCenter = Vec(-0.5,-0.5),
    relativePositions = {
      Vec(0,-2),
      Vec(0,-1),
      Vec(0,0),
      Vec(0,1)
    }
  })
end

local function getRandom()
  local p = math.random(1, 7)
  print(p)
  if p == 1 then
    return getT()
  elseif p == 2 then
    return getZ()
  elseif p == 3 then
    return getL()
  elseif p == 4 then
    return getJ()
  elseif p == 5 then
    return getO()
  elseif p == 6 then
    return getS()
  elseif p == 7 then
    return getI()
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
