-- Generic "game state" definer

local thisState	= {}



-- Called on first-time entry into this state
function thisState:init()
end

-- Called every time entering; ... can be specified by the previous state
function thisState:enter(previous, ...)
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
	love.graphics.setFont(fonts.big)
	love.graphics.printf("Untitled Ludum Dare 36 Game", 10, 20, 300, "center")
	love.graphics.setFont(fonts.main)
	love.graphics.printf("This doesn't do anything yet", 10, 100, 300, "center")
end

-- Called when key is pressed
function thisState:keypressed(key)
end

-- Called when key is released
function thisState:keyreleased(key)
end


return thisState
