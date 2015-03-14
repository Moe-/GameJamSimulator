require('background')
require('player')
require('challenge')
require('object')

class "World" {
  width = 0;
  height = 0;
  challengeCount = 10;
	objectCount = 30;
  challengeTime = 5;
  offsetx = 0;
  offsety = 0;
	timeLimit = 15 * 60;
	timeLeft = 0;
	timeToSpawnNewChallenge = 60;
	timeToSpwanNextChallenge = 0;
}

function World:__init(width, height)
  self.width = width
  self.height = height
  self.background = Background:new(width, height)
  self.player = Player:new(200, 200, width, height)
  self.challenges = {}
	self.objects = {}
  self.nextChallenge = nil
  self.curChallengeTime = 0
	self.timeLeft = self.timeLimit
	self.gameLost = false
	self.gameWon = false
	self.timeToSpwanNextChallenge = self.timeToSpawnNewChallenge
  for i = 1, self.challengeCount do
    self:genChallenge()
  end
	
	for i = 1, self.objectCount do
    self:genObject()
  end
end

function World:positionTakenByList(x, y, list)
	for i, v in pairs(list) do
		local cx, cy = v:getPosition()
		local cw, ch = v:getSize()
		if getDistance(x, y, cx, cy) < getLength(cw, ch) then
			return true
		end
	end
	return false
end

function World:positionTaken(x, y)
	return (self:positionTakenByList(x, y, self.objects) or self:positionTakenByList(x, y, self.challenges) or self:positionTakenByList(x, y, {self.player}))
end

function World:getUniquePosition()
	local x
	local y
	repeat
		x = math.random(1, self.width)
		y = math.random(1, self.height)
	until not self:positionTaken(x, y)
	return x, y
end

function World:genChallenge()
  local x, y = self:getUniquePosition()
  table.insert(self.challenges, Challenge:new(x, y))
end

function World:genObject()
  local x, y = self:getUniquePosition()
  table.insert(self.objects, Object:new(x, y))
end

function World:update(dt)
  if self.nextChallenge == nil then
    self.background:update(dt)
    self.player:update(dt, self.objects)
    
    local px, py = self.player:getPosition()
    for i, v in pairs(self.challenges) do
      v:update(dt)
      local cx, cy = v:getPosition()
      if getDistance(px, py, cx, cy) < 16 then
        self.nextChallenge = i
        self.curChallengeTime = self.challengeTime
      end
    end
		
		for i, v in pairs(self.objects) do
			v:update(dt)
		end
    
    if px + self.offsetx < 100 then
      self.offsetx = self.offsetx + 1.25 * gScale
    elseif px + self.offsetx > gScreenWidth / gScale - 100 then 
      self.offsetx = self.offsetx - 1.25 * gScale
    end
    
    if py + self.offsety < 100 then
      self.offsety = self.offsety + 1.25 * gScale
    elseif py + self.offsety > gScreenHeight / gScale - 100 then 
      self.offsety = self.offsety - 1.25 * gScale 
    end
  else
	leaveChallange = self.challenges[self.nextChallenge]:updateBattle(dt)
	
	if leaveChallange then
      table.remove(self.challenges, self.nextChallenge)
      self.nextChallenge = nil
	end
  end
	
	self.timeLeft = self.timeLeft - dt
	if self.timeLeft <= 0 and not self.gameWon then
		self.gameLost = true
	end
	
	if #self.challenges == 0 and not self.gameLost then
		self.gameWon = true
	end
	
	self.timeToSpwanNextChallenge = self.timeToSpwanNextChallenge - dt
	if self.timeToSpwanNextChallenge < 0 then
		self.timeToSpwanNextChallenge = self.timeToSpawnNewChallenge
		self:genChallenge()
	end
end

function World:draw()
  if self.nextChallenge == nil then
		--love.graphics.push()
		--love.graphics.scale(2.0, 2.0)
    self.background:draw(self.offsetx, self.offsety)
    self.player:draw(self.offsetx, self.offsety)
    
		for i, v in pairs(self.objects) do
			v:draw(self.offsetx, self.offsety)
		end
		
		for i, v in pairs(self.challenges) do
      v:draw(self.offsetx, self.offsety)
    end
		--love.graphics.pop()
  else
    self.challenges[self.nextChallenge]:drawBattle()
  end
	
	love.graphics.push()
	love.graphics.scale(1/gScale, 1/gScale)
	if self.gameLost == true then
		local outStr = "You failed creating a game!"
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.print(outStr, gScreenWidth/8 + 2, gScreenHeight/3 + 2, 0, 3.5)
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print(outStr, gScreenWidth/8, gScreenHeight/3, 0, 3.5)
		love.graphics.setColor(255, 255, 255, 255)
	elseif self.gameWon == true then
		local outStr = "You successfully made a game!"
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.print(outStr, gScreenWidth/8 + 2, gScreenHeight/3 + 2, 0, 3.5)
		love.graphics.setColor(255, 0, 0, 255)
		love.graphics.print(outStr, gScreenWidth/8, gScreenHeight/3, 0, 3.5)
		love.graphics.setColor(255, 255, 255, 255)
	else
		local outStr = "Seconds left: " .. round(self.timeLeft, 0)
		love.graphics.setColor(0, 0, 0, 255)
		love.graphics.print(outStr, 27, 27, 0, 2.5)
		love.graphics.setColor(255, 255, 0, 255)
		love.graphics.print(outStr, 25, 25, 0, 2.5)
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.pop()
end

function World:keypressed(key)
	self.player:keypressed(key)
	if self.nextChallenge ~= nil then
		self.challenges[self.nextChallenge]:keypressed(key)
	end
end

function World:keyreleased(key)
  self.player:keyreleased(key)
	if self.nextChallenge ~= nil then
		self.challenges[self.nextChallenge]:keyreleased(key)
	end
end
