Entity = Class("Entity")

function Entity:initialize(t)
  self:copyTableToSelf(t.args)
  self:setDefaults(t.defaults)

  self.__isActive = true
  self.id = Util.getId()
end

function Entity:isActive()
  return self.__isActive
end

function Entity:setActive(isActive)
  self.__isActive = isActive
end

function Entity:setDefaults(t)
  for k,v in pairs(t) do
    if self[k] == nil then
      self[k] = v
    end
  end
end

function Entity:copyTableToSelf(t)
  if t then
    for k,v in pairs(t) do
      self[k] = v
    end
  end
end

return Entity
