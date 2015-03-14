class "Player" {
  posx = 0;
  posy = 0;
  dx = 0;
  dy = 0;
  speed = 125;
}

function Player:__init(posx, posy, mapWidth, mapHeight)
  self.posx = posx
  self.posy = posy
  self.dead = false
	self.mapWidth = mapWidth
	self.mapHeight = mapHeight

  --self.image = love.graphics.newImage("gfx/player.png")
	self.image = love.graphics.newImage("gfx/marckus.png")
	self.image2 = love.graphics.newImage("gfx/alex.png")
	self.image3 = love.graphics.newImage("gfx/tomochan.png")
	self.curImg = self.image
  self.quad = love.graphics.newQuad(0, 0, self.image:getWidth(), self.image:getHeight(), self.image:getWidth(), self.image:getHeight())
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
end

function Player:update(dt, objects)
  local offsetx = self.speed * self.dx * dt
  local offsety = self.speed * self.dy * dt
	
	local newx = self.posx + offsetx
	local newy = self.posy + offsety
  
  local playerBlocked = false
	if newx < 0 or newx > self.mapWidth then
		playerBlocked = true
	end
	if newy < 0 or newy > self.mapHeight then
		playerBlocked = true
	end
	
	for i, v in pairs(objects) do
			if v:checkCollision(newx, newy) then
				playerBlocked = true
			end
		end

  if not playerBlocked then
    self.posx = newx
    self.posy = newy
  end
end

function Player:draw(offsetx, offsety)
	if self.dx >= 0 then 
		love.graphics.draw(self.curImg, self.quad, self.posx + self.width / 2 + offsetx, self.posy - self.height / 2 + offsety, 0, -1, 1)
	else
		love.graphics.draw(self.curImg, self.quad, self.posx - self.width / 2 + offsetx, self.posy - self.height / 2 + offsety, 0, 1, 1)
	end
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
	
	if key == 'e' then
		if self.curImg == self.image then
			self.curImg = self.image2
		elseif self.curImg == self.image2 then
			self.curImg = self.image3
		else
			self.curImg = self.image
		end
	end
end

function Player:getPosition()
  return self.posx, self.posy
end

function Player:getSize()
	return self.width, self.height
end