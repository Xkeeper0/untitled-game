
local Player	= Class{
	
	-- Based on...
	__includes	= Objects.Basic,

	-- Current position in stage
	position	= Vector(0, 0),
	-- Current acceleration
	movement	= Vector(0, 0),
	-- Hitbox dimensions
	hitbox		= false,

	maxSpeed	= { h =  64, v = 128 },
	accelRate	= { h = 128, v = 128 },
	decelRate	= { h =  64, v =   0 },

}



-- Called when created
function Player:init(position)
	self.position	= position
end


function Player:update(dt)
	local moved	= self:handleInput(dt)
	--if not moved then
	--	self.movement.x	= self.movement.x - math.ceil(self.movement.x * 0.1)
	--	self.movement.y	= self.movement.y - math.ceil(self.movement.y * 0.1)
	--end

	self:updatePosition(dt)
end


function Player:draw()
	love.graphics.print("P", self.position:unpack())
	love.graphics.print(string.format("%6.3f %6.3f\n%6.3f %6.3f", self.position.x, self.position.y, self.movement.x, self.movement.y), 0, 20)
end


function Player:drawHitbox()
end


function Player:handleInput(dt)
	local moved	= false
	if heldKeys.left then
		self.movement.x	= self.movement.x - self.accelRate.h * dt
		moved			= true
	end
	if heldKeys.right then
		self.movement.x	= self.movement.x + self.accelRate.h * dt
		moved			= true
	end


	if heldKeys.up then
		self.movement.y	= self.movement.y - self.accelRate.v * dt
		moved			= true
	end
	if heldKeys.down then
		self.movement.y	= self.movement.y + self.accelRate.v * dt
		moved			= true
	end

	self.movement.x		= math.min(math.max(self.movement.x, -1 * self.maxSpeed.h), self.maxSpeed.h)
	self.movement.y		= math.min(math.max(self.movement.y, -1 * self.maxSpeed.v), self.maxSpeed.v)


	return moved

end


return Player