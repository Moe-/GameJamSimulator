class "Challenge" {
	posx = 0;
	posy = 0;
}

function Challenge:__init(posx, posy)
	self.posx = posx
	self.posy = posy
	self.image = love.graphics.newImage("gfx/challenge.png")
	self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight())
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	self.player = {}
	self.player[1] = {}
	self.player[1].x = 300
	self.player[1].y = 100
	self.player[1].image = love.graphics.newImage("gfx/marckus.png")
	self.player[2] = {}
	self.player[2].x = 300
	self.player[2].y = 150
	self.player[2].image = love.graphics.newImage("gfx/marckus.png")
	self.player[3] = {}
	self.player[3].x = 300
	self.player[3].y = 200
	self.player[3].image = love.graphics.newImage("gfx/marckus.png")
	self.active = true
end

function Challenge:update(dt)
  
end

function Challenge:draw(offsetx, offsety)
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety)
end

function Challenge:updateBattle(dt)
	return not self.active
end

function Challenge:drawBattle()
	love.graphics.print("Challenge!!!", 200, 20)
	for i = 1, 3 do
		love.graphics.draw(self.player[i].image, self.player[i].x, self.player[i].y)
	end
end

function Challenge:getPosition()
	return self.posx, self.posy
end

function Challenge:keypressed(key)
	if key == "f1" then
		self.active = false
	end
end