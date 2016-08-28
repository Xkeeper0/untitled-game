
local thisState	= {}

thisState.stage	= nil

-- Called on first-time entry into this state
function thisState:init()
	-- Game setup should start here
end

-- Called every time entering; ... can be specified by the previous state
function thisState:enter(previous, ...)
	local arg = {...}
	-- First extra argument in this case should be the room name to move to
	if true then
		junkbox	= arg
	end
	if not arg[1] then
		error("Missing room name to transfer into")
	end

	self.stage	= StageHandler:get(arg[1])
end

-- Called when leaving the state
function thisState:leave()
end

-- Called when resuming this state (from another state's .pop())
function thisState:resume()
end

-- Called when window gains/loses focus
function thisState:focus()
end

-- Called when the game quits
function thisState:quit()
end


-- ----------------------------------------------------------------------------
-- "Main" callbacks

-- Same as love.update callback
function thisState:update(dt)
end

-- Same as love.draw callback
function thisState:draw()

	love.graphics.print(self.stage.name, 1, 1)

	for x = 0, 19 do
		for y = 0, 13 do
			Block:drawBlock(x, y, self.stage.layout[y][x])
		end
	end
end

-- Called when key is pressed
function thisState:keypressed(key)
end

-- Called when key is released
function thisState:keyreleased(key)
end


return thisState
