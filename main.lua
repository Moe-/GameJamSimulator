require('utils')
require('world')

gWorld = nil

function love.load()
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
	end
	math.randomseed( os.time() )
  
  resetGame()
end

function love.update(dt)

end

function love.draw()
	love.graphics.print("Hello World!", 200, 200)
end

function resetGame()
  gWorld = World:new(1280, 800)
end

function love.mousepressed(x, y, button)
  
end

function love.mousereleased(x, y, button)
  
end

function love.keypressed(key)

end

function love.keyreleased(key)
  if key == 'escape' then
		love.event.quit()
  end
end
