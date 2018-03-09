local function randomColor()
  return {
    math.random(256)-1,
    math.random(256)-1,
    math.random(256)-1
  }
end

local function isTable(t) return type(t) == 'table' end

return {
  randomColor = randomColor,
  isTable = isTable
}
