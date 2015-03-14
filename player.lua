class "Player" {
  posx = 0;
  posy = 0;
  dx = 0;
  dy = 0;
  speed = 125;
}

function Player:__init(posx, posy)
  self.posx = posx
  self.posy = posy
  self.dead = false
  self.image = love.graphics.newImage("gfx/player.png")
  self.quad = love.graphics.newQuad(0, 0, 2048, 2048, self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Player:update(dt)
  local offsetx = self.speed * self.dx * dt
  local offsety = self.speed * self.dy * dt
  
  local playerBlocked = false
  
  if not playerBlocked then
    self.posx = self.posx + offsetx
    self.posy = self.posy + offsety
  end
end

function Player:draw()
  love.graphics.draw(self.image, self.quad, self.posx - self.width / 2, self.posy - self.height / 2)
end

function Player:keypressed(key)
  if self.dead then
    return
  end

  if key == 'w' then
    self.dy = -1	
  elseif key == 's' then
    self.dy = 1
  end
  if key == 'a' then
    self.dx = -1
  elseif key == 'd' then
    self.dx = 1
  end
end

function Player:keyreleased(key)
  if self.dead then
    return
  end

  if key == 'w' then
    if not love.keyboard.isDown('s') then
      self.dy = 0
    else
      self.dy = 1
    end
  elseif key == 's' then
    if not love.keyboard.isDown('w') then
      self.dy = 0
    else
      self.dy = -1
    end
  end
  
  if key == 'a' then
    if not love.keyboard.isDown('d') then
      self.dx = 0
    else
      self.dx = 1
    end
  elseif key == 'd' then
    if not love.keyboard.isDown('a') then
      self.dx = 0
    else
      self.dx = -1
    end
  end
end

function Player:getPosition()
  return self.posx, self.posy
end