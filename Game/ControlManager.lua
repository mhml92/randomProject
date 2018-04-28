local ControlManager = Class("ControlManager", Entity)

function ControlManager:initialize(t)
  BlockType.initialize(self,{
      args = t,
      defaults = {
        _listenForKeys = false,
        _activeBlockGroup = nil
      }
    })
end

function ControlManager:update(dt)
  if self._listenForKeys and self._activeBlockGroup then
    for k,v in ipairs(inputManager:getPressedKeys()) do

    end
    -- todo
    return
  end

  if inputManager:keyReleased(Global.) then
  end

end

function ControlManager:draw()
end

return ControlManager
