local baton = require("baton/baton")

InputManager = Class("InputManager",Entity)

function InputManager:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        _baton = baton.new({
          controls = Global.CONTROLS
        }),
        _mouseDelta = Vec(0,0),
        _mousePos = Vec(0,0),
      }
    })
end

function InputManager:getMousePosition()
  return self._mousePos:clone()
end

function InputManager:getDeltaMouse()
  return self._mouseDelta:clone()
end

function InputManager:_updateMouse()
  local mx,my = love.mouse.getPosition()

  local newPos = Vec(mx,my)
  self._mouseDelta = newPos - self._mousePos
  self._mousePos = newPos
end

function InputManager:update(dt)
  self._baton:update()
  self:_updateMouse()
end

function InputManager:down(key)
  return self._baton:down(key)
end

function InputManager:pressed(key)
  return self._baton:pressed(key)
end

function InputManager:released(key)
  return self._baton:released(key)
end


return InputManager
