require "Character"

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
	
	return self
end

function Actor:update(dt)
	
	local epsi = 5
	
	-- For now, just make them move randomly
	
	-- If no target, make one
	self.targetx = self.targetx or rand(W) - 1
	self.targety = self.targety or rand(H) - 1
	
	-- If reached target, remove it
	if self.x - self.targetx < epsi and self.y - self.targety < epsi then
		self.targetx = nil
		self.targety = nil
		
		return
	end
	
	-- Get direction to target
	local dx = self.targetx - self.x
	local dy = self.targety - self.y
	
	local norm = math.sqrt(dx^2 + dy^2)
	--self:speedto(dx/norm, dy/norm, dt)
	self:accelerate(dx/norm, dy/norm, dt)
end
