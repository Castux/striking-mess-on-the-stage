require "class.lua"

Character = class()

local accel = 1000
local maxspeed = 300

local drag = 0.9


function Character:init(x,y)

	self.x = x or W/2
	self.y = y or H/2
	
	self.vx = 0
	self.vy = 0
	
	-- Default sprite
	self.sprite = img.bonus1
	
	return self
end

function Character:integratePosition(dt)
	
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

-- Compute movement, given acceleration (given as -1,0, or 1)

function Character:accelerate(ax,ay,dt)
	
	-- If no acceleration, deccelerate
	
	if ax == 0 and ay == 0 then
		self.vx = self.vx * drag
		self.vy = self.vy * drag
	
	-- Otherwise, integrate speed normally
	
	else
		self.vx = self.vx + ax * accel * dt
		self.vy = self.vy + ay * accel * dt
	end
	
	-- Speed limit
	
	local v = math.sqrt(self.vx^2 + self.vy^2)
	
	if v > maxspeed then
		self.vx = self.vx * maxspeed / v
		self.vy = self.vy * maxspeed / v
	end
	
	
	self:integratePosition(dt)
	
end

-- Set directly speed (in range -1,1)

function Character:speedto(vx,vy,dt)
	
	self.vx = vx * maxspeed
	self.vy = vy * maxspeed
	
	self:integratePosition(dt)
end

function Character:draw()
	
	local x,y,s = game.game2screen(self.x, self.y)
	
	LG.draw(self.sprite, x, y, 0, s)
end


function Character:distance(b)
	
	return math.sqrt((self.x - b.x)^2 + (self.y - b.y)^2)
end
