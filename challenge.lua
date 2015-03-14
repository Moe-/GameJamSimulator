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

function Challenge:draw(offsetx, offsety)
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2  + offsetx, self.posy - self.height / 2 + offsety)
end

function Challenge:getPosition()
  return self.posx, self.posy
end