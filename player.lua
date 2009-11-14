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
	local maxspeed = 150
	local deccel = 3000
	
	local ax,ay = 0,0
	
	-- Compute speed
	
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
	
	if ax == 0 and ay == 0 then
		local norm = math.sqrt(self.vx^2 + self.vy^2)
		if norm == 0 then norm = 1 end
		
		ax = - deccel * self.vx/norm
		ay = - deccel * self.vy/norm
	end
	
	
	-- Integrate
	
	self.vx = self.vx + ax * dt
	self.vy = self.vy + ay * dt
	
	self.x = self.x + self.vx * dt
	self.y = self.y + self.vy * dt
	
	-- Check collision with scene borders
	
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
