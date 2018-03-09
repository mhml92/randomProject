InputManager = Class("InputManager",Entity)

function InputManager:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        keyDown = {},
        keyReleased = {},
        mouseDown = {},
        mouseReleased = {}
      }
    })
end

function InputManager:reset()
  self.keyDown = {}
  self.keyReleased = {}
  self.mouseDown = {}
  self.mouseReleased = {}
end

function InputManager:getMousePosition()
  local mx,my = love.mouse.getPosition()
  return Vec(mx,my)
end

function InputManager:isKeyDown(key)
  return self.keyDown[key]
end

function InputManager:isKeyReleased(key)
  return self.keyReleased[key]
end

function InputManager:isMouseDown(button)
  return self.mouseDown[button]
end

function InputManager:isMouseReleased(button)
  return self.mouseReleased[button]
end
-----------------------------------------------------------------------
-----------------------------------------------------------------------
function InputManager:keypressed( key, scancode, isrepeat )
  print("keypressed",key,scancode,isrepeat)
  self.keyDown[scancode] = true
end

function InputManager:keyreleased(key,scancode)
  print("keyreleased",key,scancode)
  self.keyReleased[scancode] = true
end

function InputManager:mousepressed(x, y, button, isTouch)
  print("mousepressed",x,y,button,isTouch)
  self.mouseDown[button] = true
end
function InputManager:mousereleased(x, y, button, isTouch)
  print("mousereleased",x,y,button,isTouch)
  self.mouseReleased[button] = true
end

return InputManager
