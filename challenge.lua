class "Challenge" {
	posx = 0;
	posy = 0;
	energy = 20;
	w = 0;
	fightIndex = 0;
	nextPlayer = 0;
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
	if self.energy <= 0 then
		self.active = false
	end
	return not self.active
end

function Challenge:drawBattle()
	love.graphics.print("Fight!!!", 200, 20)
	
	--background
	love.graphics.push()
	love.graphics.scale(1/gScale, 1/gScale)
	love.graphics.draw(self.bg, 0, 0)
	love.graphics.pop()
	
	--menu
	love.graphics.draw(self.menu, 0, 300 - 64)
	
	--draw player
	for i = 1, 3 do
		love.graphics.draw(self.player[i].image, self.player[i].x, self.player[i].y)
	end
	
	-- draw enemy
	love.graphics.draw(self.image, self.quad, 30 - self.width / 2, 150 - self.height / 2)
	local px = 30 + self.width / 2 - 8
	local py = 150 - 12
	love.graphics.setColor(0, 0, 0, 255)
	love.graphics.print(self.desc, px + 1, py + 1, 0, 1.25)
	love.graphics.print("HP " .. self.energy, 31, 121, 0, 1.25)
	love.graphics.setColor(128, 128, 255, 255)
	love.graphics.print(self.desc, px, py, 0, 1.25)
	love.graphics.print("HP " .. self.energy, 30, 120, 0, 1.25)
	love.graphics.setColor(255, 255, 255, 255)

	--draw menu
	love.graphics.print("Fight!!!", 200, 20)
	
	if self.nextPlayer == 0 then 
		love.graphics.print("Coder", 20, 260)
	elseif self.nextPlayer == 1 then 
		love.graphics.print("Designer", 20, 260)
	else
		love.graphics.print("Artist", 20, 260)
	end
	
	if self.fightIndex == 0 then
		love.graphics.setColor(128, 128, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("Attack!", 200, 240)
	if self.fightIndex == 1 then
		love.graphics.setColor(128, 128, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("Magic!", 200, 260)
	if self.fightIndex == 2 then
		love.graphics.setColor(128, 128, 255, 255)
	else
		love.graphics.setColor(255, 255, 255, 255)
	end
	love.graphics.print("Skip!", 200, 280)
	love.graphics.setColor(255, 255, 255, 255)
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

function Challenge:keyreleased(key)
	if key == "w" then
		self.fightIndex = self.fightIndex - 1
		if self.fightIndex < 0 then self.fightIndex = 2 end
	elseif key == "s" then
		self.fightIndex = self.fightIndex + 1
		if self.fightIndex > 2 then self.fightIndex = 0 end
	elseif key == "return" then
		if self.fightIndex == 0 then -- attack
			if self.desc == "Merge conflict!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 3
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 3
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Application crash!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 3
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 3
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Non-transparent background!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 3
				else -- gfx guy
					self.energy = self.energy -3
				end
			elseif self.desc == "Unlogical gameplay!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy - 3
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Untriggered quest!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 3
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy - 3
				else -- gfx guy
					self.energy = self.energy + 3
				end
			elseif self.desc == "Inverted colors!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 1
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 3
				else -- gfx guy
					self.energy = self.energy - 3
				end
			end
		elseif self.fightIndex == 1 then -- magic
			if self.desc == "Merge conflict!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 5
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 5
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Application crash!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 5
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 5
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Non-transparent background!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 5
				else -- gfx guy
					self.energy = self.energy - 5
				end
			elseif self.desc == "Unlogical gameplay!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy - 5
				else -- gfx guy
					self.energy = self.energy
				end
			elseif self.desc == "Untriggered quest!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 5
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy - 5
				else -- gfx guy
					self.energy = self.energy + 5
				end
			elseif self.desc == "Inverted colors!" then
				if self.nextPlayer == 0 then -- progger
					self.energy = self.energy - 2
				elseif self.nextPlayer == 1 then -- designer
					self.energy = self.energy + 5
				else -- gfx guy
					self.energy = self.energy - 5
				end
			end
		else -- skip
		
		end
		self.nextPlayer = self.nextPlayer + 1
		if self.nextPlayer > 2 then self.nextPlayer = 0 end
	end
end
