require "class"

Player = class()

function Player:init(x,y)

	self.x = x or W/2
	self.y = y or H/2
	
	return self
end

function Player:update(dt)
	
	local speed = 150
	local sx,sy = 0,0

	
	-- Compute speed
	
	if LK(love.key_left) then
		sx = sx - speed
	end
	if LK(love.key_right) then
		sx = sx + speed
	end
	if LK(love.key_up) then
		sy = sy - speed
	end
	if LK(love.key_down) then
		sy = sy + speed
	end
	
	-- Integrate
	
	self.x = self.x + sx * dt
	self.y = self.y + sy * dt
	
	-- Check collision with scene borders
	
	if self.x < 0 then self.x = 0 end
	if self.x > W - 1 then self.x = W - 1 end
	if self.y < 0 then self.y = 0 end
	if self.y > H - 1 then self.y = H - 1 end
	
end



function Player:draw()

	LG.draw(img.bonus1, self.x, self.y)
end
