require "Character.lua"

Actor = class(Character)

function Actor:init(x,y,side)
	
	Actor.super.init(self,x,y)
	
	self.x = x or rand(W) - 1
	self.y = y or rand(H) - 1
	
	-- Pick a side
	self.side = side or rand(2)
	
	-- Choose sprite accordingly
	if self.side == 1 then
		self.sprite = img.bonus1
	else
		self.sprite = img.bonus2
	end
	
	-- Pick a random destination
	self:randtarget()
	
	return self
end

function Actor:randtarget()

	local margin = 10

	self.targetx = rand(margin, W-margin)
	self.targety = rand(margin, H-margin)
end

function Actor:update(dt)
	
	local epsi = 5

	-- If reached target, make new one
	if self.x - self.targetx < epsi and self.y - self.targety < epsi then
		
		self:randtarget()
	end
	
	-- Get direction to target
	local dx = self.targetx - self.x
	local dy = self.targety - self.y
	
	local norm = math.sqrt(dx^2 + dy^2)
	--self:speedto(dx/norm, dy/norm, dt)
	self:accelerate(dx/norm, dy/norm, dt)

end

function Actor:draw()
	
	Actor.super.draw(self)
	
	local x,y,s = game.game2screen(self.x, self.y)
	
	if self.targetx and self.targety then
		CLR(0,0,0)
		LG.draw(self.targetx .. ":" .. self.targety, x, y)
		LG.draw(floor(self.x) .. ":" .. floor(self.y), x, y + 12)
		LG.draw(floor(self.vx) .. ":" .. floor(self.vy), x, y + 2*12)
		
		CLR(200,0,0)
		LG.setLineWidth(5)
		LG.line(self.x, self.y, self.targetx, self.targety)
	end
end
