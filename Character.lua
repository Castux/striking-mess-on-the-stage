--[[
	Striking Mess On The Stage (Because Of The Jealousy Of A Cute Divine Girl)
	Copyright © 2009 Agnès Haasser & Noé Falzon

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

require "class.lua"

Character = class()




function Character:init(x,y,side)

	self.x = x or (rand(W) - 1)
	self.y = y or (rand(H) - 1)
	
	self.vx = 0
	self.vy = 0
	
	self.side = side or rand(2)
	
	-- Movement params
	
	self.accel = 5000
	self.maxspeed = 100

	self.drag = 0.9
	
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
		self.vx = self.vx * self.drag
		self.vy = self.vy * self.drag
	
	-- Otherwise, integrate speed normally
	
	else
		self.vx = self.vx + ax * self.accel * dt
		self.vy = self.vy + ay * self.accel * dt
	end
	
	-- Speed limit
	
	local v = math.sqrt(self.vx^2 + self.vy^2)
	
	if v > self.maxspeed then
		self.vx = self.vx * self.maxspeed / v
		self.vy = self.vy * self.maxspeed / v
	end
	
	
	self:integratePosition(dt)
	
end

-- Set directly speed (in range -1,1)

function Character:speedto(vx,vy,dt)
	
	self.vx = vx * self.maxspeed
	self.vy = vy * self.maxspeed
	
	self:integratePosition(dt)
end

function Character:draw()
	
	local x,y,s = game.game2screen(self.x, self.y)
	local spr = self:getsprite()
	
	LG.draw(spr, x, y - spr:getHeight()/2*s, 0, s)
end


function Character:distance(b)
	
	return math.sqrt((self.x - b.x)^2 + (self.y - b.y)^2)
end
