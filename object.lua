class "Object" {
  posx = 0;
  posy = 0;
}

function Object:__init(posx, posy)
	self.posx = posx
	self.posy = posy
	local rnd = math.random(1, 100)
	if rnd < 90 then
		self.image = love.graphics.newImage("gfx/chair.png")
		if rnd < 45 then
			self.mirror = true
		else
			self.mirror = false
		end
	else
		if rnd < 95 then
			self.image = love.graphics.newImage("gfx/table.png")
		else
			self.image = love.graphics.newImage("gfx/table2.png")
		end
		
		self.mirror = false
  end
	self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Object:update(dt)
	
end

function Object:draw(offsetx, offsety)
	if self.mirror then
		love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety, 0, -1, 1)
	else
		love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety)
	end
end

function Object:getPosition()
	return self.posx, self.posy
end

function Object:checkCollision(x, y)
		if x > self.posx - self.width / 2 and x < self.posx + self.width / 2 and
			 y > self.posy - self.height / 2 and y < self.posy + self.height / 2 then
			return true
		end
		return false
end

function Object:getSize()
	return self.width, self.height
end