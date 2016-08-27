--[[----------------------------------------------------------------------------
	Pixel Perfect is a module that does something very simple. You draw at the
	base scale then use pixelperfect.screenSize to resize so the player Can
	see the lovely pixels with no weird stuff.

	So even if you use a shader or rotate something it stays on that pixel
	grid.

	This does not support full screen mode in monitors that are taller
	then they are wide. Feel free to add support for it if you need it.
	(If Height>Width something something.) Steam Survey shows that it's
	not a real use case.

	In love-draw call:
		pixelperfect:startCanvas()
	then draw like normal, then call:
		pixelperfect:endCanvas()

	pixelperfect:solidBG() exists so that if you don't have a background
	image your 1x scale does not bleed into resized images.
	--pixelperfect.width = love.graphics.getWidth() -- Get the starting width
	--pixelperfect.height = love.grpahics.getHeight() -- Get the starting height
----------------------------------------------------------------------------]]--

pixelperfect = {} -- pixelperfect container

function pixelperfect:load(w, h, s)
	pixelperfect.scale = s and s or 2 -- Default scale 2 but vOv
	pixelperfect.width = w
	pixelperfect.height = h
	pixelperfect.gameScreen = love.graphics.newCanvas(w, h) -- Create canvas to scale later

	pixelperfect:monitorsize()
	pixelperfect:calculateMaxScale()
	pixelperfect:calculateFullscreenOffset()
	pixelperfect:screenSize(pixelperfect.scale)
end

-- Start drawing on our canvas
function pixelperfect:startCanvas()
	love.graphics.setCanvas(pixelperfect.gameScreen)
end

-- Stop drawing on our canvas return to love's default
function pixelperfect:endCanvas()
	love.graphics.setCanvas() -- Returning to love's default so we can draw our scaled one over it.
	if love.window.getFullscreen() == false then
		love.graphics.draw(pixelperfect.gameScreen, 0, 0, 0, pixelperfect.width * pixelperfect.scale / pixelperfect.width, pixelperfect.height * pixelperfect.scale / pixelperfect.height)
	else
		love.graphics.draw(pixelperfect.gameScreen, 0 + pixelperfect.fullscreenOffset, 0, 0, pixelperfect.width * pixelperfect.scale / pixelperfect.width, pixelperfect.height * pixelperfect.scale / pixelperfect.height)
	end
end

-- Draw a BG that is totally solid, with no bleedthrough
function pixelperfect:solidBG()
	love.graphics.setColor({0,0,0,255}) -- Black BG
	love.graphics.rectangle("fill", 0,0,pixelperfect.width,pixelperfect.height)
	love.graphics.setColor({255,255,255,255}) -- Default White
end

-- Adjust the screen size and scale
function pixelperfect:screenSize(size)
	pixelperfect.scale = size -- Register new scale inside the var

	local w, h, f = love.window.getMode()
	if (w ~= pixelperfect.width * pixelperfect.scale) or (h ~= pixelperfect.height * pixelperfect.scale) then
		love.window.setMode(pixelperfect.width * pixelperfect.scale, pixelperfect.height * pixelperfect.scale, {}) -- scale the window up to that size
	end
end

-- Control the mouse for checks when clicking.
function pixelperfect:mouseControl()
	pixelperfect.mousey = math.floor(love.mouse.getY()/pixelperfect.scale)
	if love.window.getFullscreen() == false then
		pixelperfect.mousex = math.floor(love.mouse.getX()/pixelperfect.scale)
	else
		pixelperfect.mousex = math.floor((love.mouse.getX() - pixelperfect.fullscreenOffset)/pixelperfect.scale) --
	end
end

-- function used for testing resize and Fullscreen
function pixelperfect:screentest(key)
	if key == "=" then
		if pixelperfect.scale < math.floor(pixelperfect.maxScale) then -- Since the scale does not take into account borders,
			pixelperfect:screenSize(pixelperfect.scale + 1)			  -- we need the floor in windowed mode.
		else
			pixelperfect:screenSize(1)
		end
	end

	if key == "-" then
		pixelperfect:setFullscreen()
	end
end

-- Set/Unset Fullscreen Mode with proper scaling and centered window.
function pixelperfect:setFullscreen()
	if love.window.getFullscreen() == false then
			pixelperfect:screenSize(pixelperfect.maxScale)
	  love.window.setFullscreen(true, "desktop")
	else
			pixelperfect:screenSize(math.floor(pixelperfect.maxScale))
	  love.window.setFullscreen(false, "desktop")
	end
end

-- How big is the main computer screen?
function pixelperfect:monitorsize()
	local width, height = love.window.getDesktopDimensions(1)
	print(("display %d: %d x %d"):format(1, width, height))
	pixelperfect.monitorWidth = width
	pixelperfect.monitorHeight = height
end

-- How large can we scale
function pixelperfect:calculateMaxScale()
	local w = pixelperfect.monitorWidth / pixelperfect.width
	local h = pixelperfect.monitorHeight / pixelperfect.height
	print(("Width %f | Height %f | Maxscale %f"):format(w,h,h))
	pixelperfect.maxScale = h
end

-- When we're in full screen how far do we have to move the canvas to make it centered?
function pixelperfect:calculateFullscreenOffset()
	local gamespace = (pixelperfect.width * pixelperfect.maxScale)
	local width = pixelperfect.monitorWidth
	local blackspace = width - gamespace
	pixelperfect.fullscreenOffset = math.floor(blackspace/2)
	print(("Gamespace: %d | Width: %d | BlackSpace: %d | Offset: %d"):format(gamespace,width,blackspace,pixelperfect.fullscreenOffset))
end


return pixelperfect
