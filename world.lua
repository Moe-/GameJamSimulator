require('background')
require('player')
require('challenge')

class "World" {
  width = 0;
  height = 0;
  challengeCount = 10;
}

function World:__init(width, height)
  self.width = width
  self.height = height
  self.background = Background:new()
  self.player = Player:new(200, 200)
  self.challenges = {}
  for i = 1, self.challengeCount do
    self:genChallenge()
  end
end

function World:genChallenge()
  local x = math.random(1, self.width)
  local y = math.random(1, self.height)
  table.insert(self.challenges, Challenge:new(x, y))
end

function World:update(dt)
  self.background:update(dt)
  self.player:update(dt)
  
  for i, v in pairs(self.challenges) do
    v:update(dt)
  end
end

function World:draw()
  self.background:draw()
  self.player:draw()
  
  for i, v in pairs(self.challenges) do
    v:draw()
  end
end

function World:keypressed(key)
  self.player:keypressed(key)
end

function World:keyreleased(key)
  self.player:keyreleased(key)
end
