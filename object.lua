class "Object" {
  posx = 0;
  posy = 0;
}

function Object:__init(posx, posy)
	self.posx = posx
	self.posy = posy
	
	self.image = love.graphics.newImage("gfx/chair.png")
  self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Object:update(dt)
	
end

function Object:draw(offsetx, offsety)
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety)
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