require('background')
require('player')
require('challenge')

class "World" {
  width = 0;
  height = 0;
  challengeCount = 10;
  challengeTime = 5;
}

function World:__init(width, height)
  self.width = width
  self.height = height
  self.background = Background:new()
  self.player = Player:new(200, 200)
  self.challenges = {}
  self.nextChallenge = nil
  self.curChallengeTime = 0
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
  if self.nextChallenge == nil then
    self.background:update(dt)
    self.player:update(dt)
    
    local px, py = self.player:getPosition()
    for i, v in pairs(self.challenges) do
      v:update(dt)
      local cx, cy = v:getPosition()
      if getDistance(px, py, cx, cy) < 16 then
        self.nextChallenge = i
        self.curChallengeTime = self.challengeTime
      end
    end
  else
	leaveChallange = self.challenges[self.nextChallenge]:updateBattle(dt)
	
	if leaveChallange then
      table.remove(self.challenges, self.nextChallenge)
      self.nextChallenge = nil
	end
  end
end

function World:draw()
  if self.nextChallenge == nil then
    self.background:draw()
    self.player:draw()
    
    for i, v in pairs(self.challenges) do
      v:draw()
    end
  else
    self.challenges[self.nextChallenge]:drawBattle()
  end
end

function World:keypressed(key)
	self.player:keypressed(key)
	if self.nextChallenge ~= nil then
		self.challenges[self.nextChallenge]:keypressed(key)
	end
end

function World:keyreleased(key)
  self.player:keyreleased(key)
end
