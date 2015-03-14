class "Challenge" {
	posx = 0;
	posy = 0;
}

function Challenge:__init(posx, posy)
	self.posx = posx
	self.posy = posy
	self.image = love.graphics.newImage("gfx/challenge.png")
	self.bg = love.graphics.newImage("gfx/battle_bg1.png")
	self.menu = love.graphics.newImage("gfx/battle_menu.png")
	self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight())
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
	local rnd = math.random(1, 6)
	if rnd == 1 then
		self.desc = "Merge conflict!"
	elseif rnd == 2 then
		self.desc = "Application crash!"
	elseif rnd == 3 then
		self.desc = "Non-transparent background!"
	elseif rnd == 4 then
		self.desc = "Unlogical gameplay!"
	elseif rnd == 5 then
		self.desc = "Untriggered quest!"
	else
		self.desc = "Inverted colors!"
	end
	self.player = {}
	self.player[1] = {}
	self.player[1].x = 300
	self.player[1].y = 100
	self.player[1].image = love.graphics.newImage("gfx/marckus.png")
	self.player[2] = {}
	self.player[2].x = 300
	self.player[2].y = 150
	self.player[2].image = love.graphics.newImage("gfx/alex.png")
	self.player[3] = {}
	self.player[3].x = 300
	self.player[3].y = 200
	self.player[3].image = love.graphics.newImage("gfx/tomochan.png")
	self.active = true
end

function Challenge:update(dt)
  
end

function Challenge:draw(offsetx, offsety)
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety)
	local px = self.posx + self.width / 2 + offsetx - 8
	local py = self.posy + offsety - 12
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print(self.desc, px + 1, py + 1, 0, 1.25)
	love.graphics.setColor(128, 128, 255, 255)
	love.graphics.print(self.desc, px, py, 0, 1.25)
	love.graphics.setColor(255, 255, 255, 255)
end

function Challenge:updateBattle(dt)
	return not self.active
end

function Challenge:drawBattle()
	love.graphics.print("Fight!!!", 200, 20)
	
	--background
	love.graphics.draw(self.bg, 0, 0)
	
	--menu
	love.graphics.draw(self.menu, 0, 300 - 64)
	
	--draw player
	for i = 1, 3 do
		love.graphics.draw(self.player[i].image, self.player[i].x, self.player[i].y)
	end

	--draw menu
	love.graphics.print("Fight!!!", 200, 20)
end

function Challenge:getPosition()
	return self.posx, self.posy
end

function Challenge:getSize()
	return self.width, self.height
end

function Challenge:keypressed(key)
	if key == "f1" then
		self.active = false
	end
end