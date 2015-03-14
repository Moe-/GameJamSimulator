require('background')

class "World" {
  width = 0;
  height = 0;
}

function World:__init(width, height)
  self.width = width
  self.height = height
  self.background = Background:new()
end

function World:update(dt)
  self.background:update(dt)
end

function World:draw()
  self.background:draw()
end