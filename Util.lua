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

  if Global.DEBUG_DRAW then
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

  if Global.DEBUG_DRAW then
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

-- Checks if two lines intersect (or line segments if seg is true)
-- Lines are given as four numbers (two coordinates)
function findIntersect(l1p1x,l1p1y, l1p2x,l1p2y, l2p1x,l2p1y, l2p2x,l2p2y, seg1, seg2)
	local a1,b1,a2,b2 = l1p2y-l1p1y, l1p1x-l1p2x, l2p2y-l2p1y, l2p1x-l2p2x
	local c1,c2 = a1*l1p1x+b1*l1p1y, a2*l2p1x+b2*l2p1y
	local det,x,y = a1*b2 - a2*b1
	if det==0 then return false, "The lines are parallel." end
	x,y = (b2*c1-b1*c2)/det, (a1*c2-a2*c1)/det
	if seg1 or seg2 then
		local min,max = math.min, math.max
		if seg1 and not (min(l1p1x,l1p2x) <= x and x <= max(l1p1x,l1p2x) and min(l1p1y,l1p2y) <= y and y <= max(l1p1y,l1p2y)) or
		   seg2 and not (min(l2p1x,l2p2x) <= x and x <= max(l2p1x,l2p2x) and min(l2p1y,l2p2y) <= y and y <= max(l2p1y,l2p2y)) then
			return false, "The lines don't intersect."
		end
	end
	return x,y
end

local function debugDraw(list)
  for k,v in ipairs(list) do
    love.graphics.setColor(v.color)
    if v.type == "line" then
      love.graphics.line(
        v.a.x,
        v.a.y,
        v.b.x,
        v.b.y)
    end
  end
end

local function radToVec(rad)
  return Vec(math.cos(rad),math.sin(rad))
end

local function weldBlocks(b1, b2, selfCollide)
  local anchor_point = ((b2:getPositionVec() - b1:getPositionVec())/2) + b1:getPositionVec()
  physicsWorld:addJoint('WeldJoint', b1.collider, b2.collider, anchor_point.x, anchor_point.y, selfCollide)
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
