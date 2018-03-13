local function randomColor()
  return {
    math.random(256)-1,
    math.random(256)-1,
    math.random(256)-1,
    255
  }
end

local function isTable(t) return type(t) == 'table' end

local function round(x) return math.floor(x+0.5) end


local function toGridCoords(pos)
  return Vec(
  Util.round(pos.x/Global.BLOCK_SIZE),
  Util.round(pos.y/Global.BLOCK_SIZE)
) * Global.BLOCK_SIZE
end

return {
  toGridCoords = toGridCoords,
  randomColor = randomColor,
  round = round,
  isTable = isTable
}
