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

-- "Pixel perfect" library w/ some modifications
PixelPerfect	= require "utils.pixelperfect"

-- "Explode" string splitter
explode			= require "utils.explode"

-- Globals ---------------------------------------
-- Timers since game start
globalTimer		= 0
globalFrames	= 0
-- Collection of used fonts (loaded in love.load)
fonts			= {}
-- Gamestates
gamestates		= {}


function love.load()
	-- Load assets and other things here

	-- Load font assets
	fonts.big	= love.graphics.newFont(24)
	fonts.main	= love.graphics.newFont(14)
	fonts.small	= love.graphics.newFont(10)
	fonts.debug	= love.graphics.newFont("assets/Pokemon GB.ttf", 8)

	-- Set font to "main" font
	love.graphics.setFont(fonts.main)

	-- Set default graphics filter
	love.graphics.setDefaultFilter("nearest", "nearest", 1)

	-- Increase zoom factor
	-- @todo: Store this in save file/config?
	PixelPerfect:load(320, 224, 3)

	-- Gamestates
	gamestates.titlescreen	= require "gamestates.title"

	-- Register Gamestate callbacks here
	Gamestate.registerEvents()

	-- Double-wrap the love.draw function.
	-- Gamestate.registerEvents wraps it, but we want to wrap it too
	-- There's no easy way to say "register ALL but this callback"
	-- :(
	local oldDraw = love.draw
	love.draw = function(...)
		drawWrapper(oldDraw, ...)
	end


	Gamestate.switch(gamestates.titlescreen)



end


-- Update function -- typically wrapped by hump.Gamestate
function love.update(dt)
	-- Track current game runtime
	globalTimer		= globalTimer + dt
	globalFrames	= globalFrames + 1
end


-- Wrapper around hump.Gamestate's wrapper around love.draw
-- This scales the game to 3X (or whatever)
function drawWrapper(wrappedDrawer, ...)

	-- Start upscaling canvas code here
	PixelPerfect:startCanvas()
	PixelPerfect:solidBG()

	-- -----------------------------------------------------------------------
	-- Do game drawing stuff here !!!!
	wrappedDrawer()
	-- -----------------------------------------------------------------------

	-- End upscaling canvas and draw it to screen
	PixelPerfect:endCanvas()

	-- Stuff below here is rendered directly on the game screen at 1x

	-- Draw current runtime in corner
	local currentFont	= love.graphics.getFont()
	love.graphics.setFont(fonts.debug)
	love.graphics.print(string.format("%7.2fs\n%7df", globalTimer, globalFrames), 320 * 3 - 70, 5)
	love.graphics.setFont(currentFont)



end
