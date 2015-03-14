class "Background" {

}

function Background:__init()
  self.image = love.graphics.newImage("gfx/background.png")
  self.image:setWrap("repeat", "repeat")
  self.quad = love.graphics.newQuad(0, 0, 2048, 2048, self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Background:draw(offsetx, offsety)
  love.graphics.draw(self.image, self.quad, 0 + offsetx, 0 + offsety)
end

function Background:update(dt)
end

function Background:getSize()
  return self.width, self.height
end

function Background:getWidth()
  return self.width
end

function Background:getHeight()
  return self.height
end