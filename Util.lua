local function randomColor()
  return {
    math.random(256)-1,
    math.random(256)-1,
    math.random(256)-1
  }
end

local function isTable(t) return type(t) == 'table' end

local function round(x) return math.floor(x+0.5) end

return {
  randomColor = randomColor,
  round = round,
  isTable = isTable
}
