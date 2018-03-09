Game = Class("Game", Entity)

function Game:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {}
    }
  )
end

function Game:load()
end

function Game:update(dt)
end

function Game:draw()
end

return Game
