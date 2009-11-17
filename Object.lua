require "class.lua"

Object = class()

-- List of sprites for objects, {tragi, comi}


objlist = {
	{"decor1tragi","decor1comi"},
	{"decor2tragi","decor2comi"},
	{"decor3tragi","decor3comi"},
	{"decor4tragi","decor4comi"},
	{"decor5tragi","decor5comi"}
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
	
	CLR(255,255,255,100)
	LG.setColorMode(love.color_modulate)
	LG.draw(spr, x, y - spr:getHeight()/2*s, 0, s)
	LG.setColorMode(love.color_normal)
end

function Object:swap()
	
	self.side = self.side == 1 and 2 or 1
end
