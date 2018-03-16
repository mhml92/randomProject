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

local function getI()
  BlockGroup:new({
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

return {
  getT = getT,
  getZ = getZ,
  getL = getL,
  getJ = getJ,
  getI = getI,
  getS = getS
}
