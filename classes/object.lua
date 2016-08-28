
local Object	= Class{
	
	-- Current position in stage
	position	= Vector(0, 0),
	-- Current acceleration
	movement	= Vector(0, 0),
	-- Hitbox dimensions
	hitbox		= false,
}



-- Called when created
function Object:init(position)
	self.position	= position
end


function Object:update(dt)
end

function Object:draw()
end

function Object:drawHitbox()
end


function Object:updatePosition(dt)
	self.position	= self.position + (self.movement * dt)
end


return Object