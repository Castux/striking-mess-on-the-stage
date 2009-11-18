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

require "Character.lua"

Actor = class(Character)

function Actor:init(x,y,side)
	
	Actor.super.init(self,x,y,side)
	
	self.x = x or rand(W) - 1
	self.y = y or rand(H) - 1
	
	-- Pick a random destination
	self:randtarget()
	
	-- Ce qu'il dit
	self.parole = ""
	self.tps_parole = 0
		
	return self
end

function Actor:randtarget()

	local margin = 10
	
	-- Make list of candidate objects
	local list = {}
	
	for i,v in ipairs(objects) do
		if v.side ~= self.side then
			TI(list, {v,self:distance(v)})
		end
	end
	
	-- If there are not, walk to random location
	if #list == 0 then

		self.targetx = rand(margin, W-margin)
		self.targety = rand(margin, H-margin)
		self.targetobj = nil
	
	
	--If there are, with half probability, pick the closest or a random one
	else
		local obj
		
		if rand() < 0.5 then
			table.sort(list, function(a,b)
				return a[2] < b[2]
			end)
			
			obj = list[1][1]
		else
			obj = list[rand(#list)][1]
		end
		
		self.targetx = obj.x
		self.targety = obj.y
		self.targetobj = obj
	end
	

end

function Actor:update(dt)
	
	local epsi = 5

	-- If reached target, try to swap object (if it's still swapable),
	-- and get new one
	if (self.x - self.targetx)^2 + (self.y - self.targety)^2 < epsi^2 then
		
		if self.targetobj and self.targetobj.side ~= self.side then
			self.targetobj:swap()
		end
		
		self:randtarget()
	else
	
		-- Get direction to target
		local dx = self.targetx - self.x
		local dy = self.targety - self.y
		
		local norm = math.sqrt(dx^2 + dy^2)
		--self:speedto(dx/norm, dy/norm, dt)
		self:accelerate(dx/norm, dy/norm, dt)
	
	end
	
	-- Pour que l'acteur se taise au bout d'un moment
	self.tps_parole = self.tps_parole - dt

end


function Actor:swap()
	
	LA.play(snd.drums)
	
	-- will maybe have fancy animation later
	
	self.side = self.side == 1 and 2 or 1
	
	-- get a new target if we change side
	self:randtarget()
end

function Actor:getsprite()
	
	return self.side == 1 and img.tragi or img.comi
end

function Actor:says(truc)

	-- pour quand l'acteur dit un truc
	-- on affiche le truc au-dessus (ou à coté) de sa tete, dans une bulle par ex.

	self.parole = truc

	self.tps_parole = 2 -- possible de le passer en argument selon la longueur des répliques

end

function Actor:draw()
	
	local x,y,s = game.game2screen(self.x, self.y)
	
	if self.side == 1 then
		CLR(0,0,255,80) -- tragi ?
	elseif self.side == 2 then
		CLR(255,0,240,80) -- comi ?
	end
	
	-- on n'affiche quelque chose que s'il a quelque chose à dire
	if self.parole ~= "" and self.tps_parole > 0 then
		LG.rectangle(0,x - 5, y - 75, 110, 43)
		CLR(0,0,0)
		LG.drawf(self.parole,x,y - 65,100,2)
	end
	
	
	-- On dessine l'acteur par-dessus la bulle
	Actor.super.draw(self)

end
