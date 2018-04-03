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
    local x,y = origoBlockGroup.blocks[1].collider:getPosition()
    origo = Vec(x,y)
    rotation = origoBlockGroup.blocks[1].collider:getAngle()
  end


  local directLine = pos - origo

  local horizontal = Vec(1,0)
  horizontal:rotateInplace(rotation)

  local xVec = directLine:projectOn(horizontal)
  print(xVec:len())
  local yVec = directLine - xVec

  local xLen = xVec:len()
  local yLen = yVec:len()

  xLen = Util.round(xLen/Global.BLOCK_SIZE)
  yLen = Util.round(yLen/Global.BLOCK_SIZE)

  xVec = xVec:normalized()*Global.BLOCK_SIZE * xLen
  yVec = yVec:normalized()*Global.BLOCK_SIZE * yLen

  return origo + xVec + yVec
end

local function isTable(t) return type(t) == 'table' end


-- (x,y) top left of block
local function queryBlocksAt(x,y)
  return physicsWorld:queryRectangleArea(
    x,
    y,
    Global.BLOCK_SIZE,
    Global.BLOCK_SIZE,
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

return {
  getId = getId,
  queryBlocksAt = queryBlocksAt,
  toGridCoords = toGridCoords,
  randomColor = randomColor,
  round = round,
  isTable = isTable
}
