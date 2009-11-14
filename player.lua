require "Character"


-- Make Player inherit from Character

Player = class(Character)

function Player:init(x,y)
	
	Player.super.init(self,x,y)
	
	-- Specific sprite
	self.sprite = img.bonus2
	
	return self
end

-- Specific movement: from keyboard

function Player:update(dt)
	
	local ax,ay = 0,0
	
	-- Compute accel from keys
	
	if LK(love.key_left) then
		ax = ax - 1
	end
	if LK(love.key_right) then
		ax = ax + 1
	end
	if LK(love.key_up) then
		ay = ay - 1
	end
	if LK(love.key_down) then
		ay = ay + 1
	end
	
	-- Move in consequence
	self:accelerate(ax,ay,dt)
end
