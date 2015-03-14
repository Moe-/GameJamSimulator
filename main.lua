require('utils')
require('world')

gWorld = nil

gScreenWidth = 0
gScreenHeight = 0
gScale = 2

function love.load()
	if arg[#arg] == "-debug" then 
		require("mobdebug").start() 
	end
	love.graphics.setDefaultFilter("nearest", "nearest", 0)
	math.randomseed( os.time() )
	gScreenWidth, gScreenHeight = love.graphics.getDimensions( )
	resetGame()
end

function love.update(dt)
  gWorld:update(dt)
end

function love.draw()
	--love.graphics.pop()
	love.graphics.scale(gScale, gScale)
	gWorld:draw()
end

function resetGame()
  gWorld = World:new(1280, 800)
end

function love.mousepressed(x, y, button)
  
end

function love.mousereleased(x, y, button)

end

function love.keypressed(key)
  gWorld:keypressed(key)
end

function love.keyreleased(key)
  if key == 'escape' then
		love.event.quit()
  end
  gWorld:keyreleased(key)
end
