require "class"

Player = class()

function Player:init(x,y)

	self.x = x or W/2
	self.y = y or H/2
	
	self.vx = 0
	self.vy = 0
	
	return self
end

function Player:update(dt)
	
	local accel = 1000
	local maxspeed = 300

	local drag = 0.9
	
	local ax,ay = 0,0
	
	-- Compute speed from keys
	
	if LK(love.key_left) then
		ax = ax - accel
	end
	if LK(love.key_right) then
		ax = ax + accel
	end
	if LK(love.key_up) then
		ay = ay - accel
	end
	if LK(love.key_down) then
		ay = ay + accel
	end
	

	-- If no keys are pressed, deccelerate
	
	if ax == 0 and ay == 0 then
		self.vx = self.vx * drag
		self.vy = self.vy * drag
	
	-- Otherwise, integrate speed normally
	
	else
		self.vx = self.vx + ax * dt
		self.vy = self.vy + ay * dt
	end
	
	-- Speed limit
	
	if self.vx > maxspeed then
		self.vx = maxspeed
	elseif self.vx < - maxspeed then
		self.vx = - maxspeed
	end
	
	if self.vy > maxspeed then
		self.vy = maxspeed
	elseif self.vy < - maxspeed then
		self.vy = - maxspeed
	end
	
	-- Integrate position
	
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt
	
	-- Position limits
	
	if self.x < 0 then
		self.x = 0
		self.vx = 0
	elseif self.x > W - 1 then
		self.x = W - 1
		self.vx = 0
	end
	
	if self.y < 0 then
		self.y = 0
		self.vy = 0
	elseif self.y > H - 1 then
		self.y = H - 1
		self.vy = 0
	end
	
end



function Player:draw()

	LG.draw(img.bonus1, self.x, self.y)
end
