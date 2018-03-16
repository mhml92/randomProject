InputManager = Class("InputManager",Entity)

function InputManager:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        _keyPressed = {},
        _keyReleased = {},
        _mousePressed = {},
        _mouseReleased = {}
      }
    })
end

function InputManager:reset()
  self._keyPressed = {}
  self._keyReleased = {}
  self._mousePressed = {}
  self._mouseReleased = {}
end

function InputManager:getMousePosition()
  local mx,my = love.mouse.getPosition()
  return Vec(mx,my)
end

function InputManager:keyDown(key)
  return love.keyboard.isDown(key)
end

function InputManager:keyPressed(key)
  return self._keyPressed[key]
end

function InputManager:keyReleased(key)
  return self._keyReleased[key]
end

function InputManager:mouseDown(button)
  return love.mouse.isDown(button)
end

function InputManager:mousePressed(button)
  return self._mousePressed[button]
end

function InputManager:mouseReleased(button)
  return self._mouseReleased[button]
end
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function InputManager:keypressed( key, scancode, isrepeat )
  print("keypressed",key,scancode,isrepeat)
  self._keyPressed[scancode] = true
end

function InputManager:keyreleased(key,scancode)
  print("keyreleased",key,scancode)
  self._keyReleased[scancode] = true
end

function InputManager:mousepressed(x, y, button, isTouch)
  print("mousepressed",x,y,button,isTouch)
  self._mousePressed[button] = true
end
function InputManager:mousereleased(x, y, button, isTouch)
  print("mousereleased",x,y,button,isTouch)
  self._mouseReleased[button] = true
end

return InputManager
