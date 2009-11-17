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

require "Muse.lua"

-- Make Player inherit from Muse and overload its default behavior (AI)

Player = class(Muse)

function Player:init(x,y)
	
	Player.super.init(self,x,y)
	
	self.side = team
	
	-- Player is even faster than muse
	
	self.maxspeed = 300
	
	-- tragi-comi bar: -1..1
	self.bar = 0
	
	
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


-- swapdist and swapcost defined in Muse.lua

function Player:tryswap()

	local candidate

	for i,v in ipairs(actors) do
		
		-- check only foes
		if v.side == foes then
			local dist = self:distance(v)	
			
			if dist < swapdist then
				candidate = v
				break
			end
		end
	end
	
	if candidate then
		
		-- consume some energy
		if team == 1 then	-- comi->tragi "spends" tragi so augments comi
			dir = 1
		else
			dir = -1	-- tragi->comi "spends" comi so aumgents tragi
		end
		
		self.bar = self.bar + dir * swapcost
		
		candidate:swap()
	end

end
