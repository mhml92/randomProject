DragBlockGroupAction = require "Game/actions/DragBlockGroupAction"
DragCameraAction = require "Game/actions/DragCameraAction"

ActionManager = Class("ActionManager", Entity)

function ActionManager:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        actions = {
          DragBlockGroupAction:new(),
          DragCameraAction:new()
        }
      }
    }
  )
end


function ActionManager:update(dt)
  self:updateActions(dt)
end

function ActionManager:draw()
  self:drawActions()
end

function ActionManager:updateActions(dt)
  for _,v in ipairs(self.actions) do
    if v:isActive() then
      v:update(dt)
    end
  end
end

function ActionManager:drawActions()
  for _,v in ipairs(self.actions) do
    if v:isActive() then
      v:draw(dt)
    end
  end
end


return ActionManager
