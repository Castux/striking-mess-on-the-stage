require "class.lua"

Object = class()

-- List of sprites for objects, {tragi, comi}


objlist = {
	{"seal1", "seal2"},
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
	
	LG.draw(spr, x, y - spr:getHeight()/2*s, 0, s)
end
