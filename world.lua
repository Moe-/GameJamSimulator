require('background')
require('player')

class "World" {
  width = 0;
  height = 0;
}

function World:__init(width, height)
  self.width = width
  self.height = height
  self.background = Background:new()
  self.player = Player:new(200, 200)
end

function World:update(dt)
  self.background:update(dt)
  self.player:update(dt)
end

function World:draw()
  self.background:draw()
  self.player:draw()
end

function World:keypressed(key)
  self.player:keypressed(key)
end

function World:keyreleased(key)
  self.player:keyreleased(key)
end
