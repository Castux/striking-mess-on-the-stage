require "Character.lua"


-- Make Player inherit from Character

Player = class(Character)

function Player:init(x,y)
	
	Player.super.init(self,x,y)
	
	-- Specific sprite
	self.sprite = img.bonus2
	
	-- tragi-comi bar: -1..1
	self.bar = 0
	
	-- set of close actors (we might need to keep the info from 
	-- frame to frame later. And also for drawing)
	
	self.close = {}
	
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
	
	-- Check proximity with actors
	local prox = 200
		
	for i,v in ipairs(actors) do
		local dist = self:distance(v)	
		
		if dist < prox then
			self.close[v] = true
		else
			self.close[v] = nil
		end
	end
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

function Player:draw()
	
	Player.super.draw(self)
	
	local x,y = game.game2screen(self.x, self.y)
	
	-- Make lines to close dudes
	for k,_ in pairs(self.close) do
		
		local x2,y2 = game.game2screen(k.x, k.y)
		
		CLR(0,0,0)
		LG.setLineWidth(4)
		LG.line(x,y,x2,y2)
	end
end
