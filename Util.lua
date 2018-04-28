local function randomColor(alpha)
  if not alpha then alpha = 255 end
  return {
    math.random(256)-1,
    math.random(256)-1,
    math.random(256)-1,
    alpha
  }
end

local function getId()
  Global.STATIC_OBJECT_ID = Global.STATIC_OBJECT_ID + 1
  return Global.STATIC_OBJECT_ID
end

local function round(x) return math.floor(x+0.5) end

local function toGridCoords(pos,origoBlockGroup)

  -- origo
  local origo = Vec(0,0)
  local rotation = 0
  if origoBlockGroup then
    origo = origoBlockGroup:getPositionVec()
    rotation = origoBlockGroup:getAngle()
  end

  local directLine = pos - origo

  local horizontal = Vec(1000,0)
  horizontal:rotateInplace(rotation)

  if Global.DEBUG_MODE then
    table.insert(debugDraw,{type = "line", a = origo:clone(), b = origo + horizontal:clone(),color = {0,255,0}})
  end

  local xVec = directLine:projectOn(horizontal)
  local yVec = directLine - xVec


  local xLen = xVec:len()
  local yLen = yVec:len()

  xLen = Util.round(xLen/Global.BLOCK_SIZE)
  yLen = Util.round(yLen/Global.BLOCK_SIZE)

  xVec = xVec:normalized() * (Global.BLOCK_SIZE * xLen)
  yVec = yVec:normalized() * (Global.BLOCK_SIZE * yLen)

  if Global.DEBUG_MODE then
    table.insert(debugDraw,{type = "line", a = origo:clone(), b = origo + xVec:clone(),color = {0,0,255}})
    table.insert(debugDraw,{type = "line", a = origo + xVec, b = origo + xVec + yVec, color = {255,0,255}})
  end

  return origo + xVec + yVec
end

local function isTable(t) return type(t) == 'table' end


-- (x,y) top left of block
local function queryBlocksAt(x,y)
  return physicsWorld:queryCircleArea(
    x,
    y,
    Global.BLOCK_SIZE/2,
    {Global.COLLISION_CLASS_BLOCK})
end


local function debugDraw(list)
  for k,v in ipairs(list) do
    love.graphics.setColor(v.color)
    if v.type == "line" then
      love.graphics.line(v.a.x, v.a.y, v.b.x, v.b.y)
    end
  end
end

local function radToVec(rad)
  return Vec(math.cos(rad),math.sin(rad))
end

-- this is really stupid, but WeldJoint dont work :(
local function weldBlocks(b1, b2, collideConnected)
  --[[
  local half = (b2:getPositionVec() - b1:getPositionVec())/2
  local quarter = half:normalized():perpendicular()*Global.BLOCK_SIZE/4
  local a1,a2 = b1:getPositionVec()+ quarter + half, b1:getPositionVec() - quarter + half
  physicsWorld:addJoint('RevoluteJoint', b1.collider, b2.collider, a1.x, a1.y, collideConnected)
  physicsWorld:addJoint('RevoluteJoint', b1.collider, b2.collider, a2.x, a2.y, collideConnected)
  ]]
  -- WHY WILL THIS NOT WORK!!!! I DO NOT UNDERSTAND
  -- HA HA!!! there was a bug in love!!! https://bitbucket.org/rude/love/issues/1258/change-default-reference-angle-for-weld
  local anchor_point = ((b2:getPositionVec() - b1:getPositionVec())/2) + b1:getPositionVec()
  physicsWorld:addJoint(
    'WeldJoint',
    b1.collider,
    b2.collider,
    anchor_point.x,
    anchor_point.y,
    anchor_point.x,
    anchor_point.y,
    collideConnected,
    b2:getAngle()-b1:getAngle()
  )
end

return {
  weldBlocks = weldBlocks,
  radToVec = radToVec,
  getId = getId,
  queryBlocksAt = queryBlocksAt,
  toGridCoords = toGridCoords,
  randomColor = randomColor,
  round = round,
  isTable = isTable,
  debugDraw = debugDraw
}
