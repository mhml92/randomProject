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
  if origoBlockGroup then
    local x,y = origoBlockGroup.blocks[1].collider:getPosition()
    origo = Vec(x,y)
  end

  -- offset
  local offset = origo/Global.BLOCK_SIZE
  offset.x = offset.x - math.floor(offset.x)
  offset.y = offset.y - math.floor(offset.y)
  offset = offset*Global.BLOCK_SIZE
  
  return (Vec(
    Util.round(pos.x/Global.BLOCK_SIZE),
    Util.round(pos.y/Global.BLOCK_SIZE)
  ) * Global.BLOCK_SIZE)+offset
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

return {
  getId = getId,
  queryBlocksAt = queryBlocksAt,
  toGridCoords = toGridCoords,
  randomColor = randomColor,
  round = round,
  isTable = isTable
}
