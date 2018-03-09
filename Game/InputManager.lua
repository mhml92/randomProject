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

function InputManager:keypressed( key, scancode, isrepeat )
  print("keypressed",key,scancode,isrepeat)
end

function InputManager:keyreleased(key,scancode)
  print("keypressed",key,scancode)
end

function InputManager:mousepressed(x, y, button, isTouch)
  print("mousepressed",x,y,button,isTouch)
end
function InputManager:mousereleased(x, y, button, isTouch)
  print("mousereleased",x,y,button,isTouch)
end

return InputManager
