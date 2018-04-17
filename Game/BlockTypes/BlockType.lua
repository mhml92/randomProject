local BlockType = Class("BlockType", Entity)

function BlockType:initialize(t)
  Entity.initialize(self,{
      args = t,
      defaults = {
        parent = nil,
      }
    })

end

function BlockType:setParent(p)
  self.parent = p
end

return BlockType
