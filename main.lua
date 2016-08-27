-- [[ ------------------------------------------------------------------------
-- Ludum Dare 36 game??
-- Main file
-- ]] ------------------------------------------------------------------------


-- Import some things from the hump library
-- http://hump.readthedocs.io/
Gamestate	= require "hump.gamestate"
Class		= require "hump.class"
Timer		= require "hump.timer"
Vector		= require "hump.vector"


-- Globals ---------------------------------------
-- Timers since game start
globalTimer		= 0
globalFrames	= 0
-- Collection of used fonts (loaded in love.load)
fonts			= {}


function love.load()
	-- Load assets and other things here

	-- Load font assets
	fonts.big	= love.graphics.newFont(30)
	fonts.main	= love.graphics.newFont(14)
	fonts.small	= love.graphics.newFont(10)
	fonts.debug	= love.graphics.newFont("assets/Pokemon GB.ttf", 8)

	-- Set font to "main" font
	love.graphics.setFont(fonts.main)

	-- Register GameState callbacks here
	-- GameState.registerEvents()
end



function love.update(dt)
	-- Track current game runtime
	globalTimer		= globalTimer + dt
	globalFrames	= globalFrames + 1
end


function love.draw()
	-- Draw current runtime in corner
	-- Later, maybe FPS or something
	local currentFont	= love.graphics.getFont()
	love.graphics.setFont(fonts.debug)
	love.graphics.print(string.format("Runtime\n%7.2fs\n%7df", globalTimer, globalFrames), 10, 10)
	love.graphics.setFont(currentFont)

end
