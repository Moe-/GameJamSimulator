class "Challenge" {
  posx = 0;
  posy = 0;
}

function Challenge:__init(posx, posy)
  self.posx = posx
  self.posy = posy
  self.image = love.graphics.newImage("gfx/challenge.png")
  self.quad = love.graphics.newQuad(0, 0, 2048, 2048, self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Challenge:update(dt)
  
end

function Challenge:draw()
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2, self.posy - self.height / 2)
end

function Challenge:updateBattle(dt)
	return true
end

function Challenge:drawBattle()
  love.graphics.print("Challenge!!!", 200, 200)
end

function Challenge:getPosition()
  return self.posx, self.posy
end