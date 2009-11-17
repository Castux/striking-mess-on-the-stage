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

Object = class()

-- List of sprites for objects, {tragi, comi}

objlist = {
	{"dec1t","dec1c"},
	{"dec2t","dec2c"},
	{"dec3t","dec3c"},
	{"dec4t","dec4c"},
	{"dec5t","dec5c"},
	{"dec6t","dec6c"},
	{"dec7t","dec7c"},
	{"dec8t","dec8c"},
}

function Object:init(x,y,side)
	
	self.x = x or (rand(W) - 1)
	self.y = y or (rand(H) - 1)
	
	self.side = side or rand(2)
	
	self.type = rand(#objlist)
	
	return self
end

function Object:getsprite()
	
	return img[objlist[self.type][self.side]]
end

function Object:draw()

	local x,y,s = game.game2screen(self.x, self.y)
	local spr = self:getsprite()
	
	local alpha = 215
	
	if self.side == 1 then
		CLR(181,215,234,alpha)
	else
		CLR(255,182,230,alpha)
	end
	
	LG.setColorMode(love.color_modulate)
	LG.draw(spr, x, y - spr:getHeight()/2*s, 0, s)
	LG.setColorMode(love.color_normal)
end

function Object:swap()
	
	self.side = self.side == 1 and 2 or 1
end
