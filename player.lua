require "Character.lua"


-- Make Player inherit from Character

Player = class(Character)

function Player:init(x,y)
	
	Player.super.init(self,x,y)
	
	-- Specific sprite
	self.sprite = img.bonus2
	
	-- tragi-comi bar: -1..1
	self.bar = -0.5
	
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

function Player:drawbar()
	
	local w,h = 10,100
	local x,y = 20,20
	
	local off = 2
	
	-- background
	CLR(255,255,255)
	LG.rectangle(love.draw_fill, x - off, y - off, w + 2*off, h + 2*off)
	
	-- bar
	if self.bar > 0 then
		CLR(0,0,255)
		LG.rectangle(love.draw_fill, x, y + h/2, w, self.bar*h/2)
	elseif self.bar < 0 then
		CLR(255,0,255)
		LG.rectangle(love.draw_fill, x, y + h/2 + self.bar*h/2, w, -self.bar*h/2)
	end
	
end
