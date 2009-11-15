require "class.lua"

Dionysos = class()

function Dionysos:init(target)
	
	self.pos = 0
	self.spr = img.musetragi
	self.target = target
	
	self.fadeinit = 5
	self.fadecount = self.fadeinit
	
	return self
end

function Dionysos:update(dt)
	
	local speed = 60
	
	if not self.strike and self.pos < self.spr:getHeight() then
	
		self.pos = self.pos + speed * dt
	else
		self.strike = true
	end
	
	if self.strike then
		self.fadecount = self.fadecount - dt
		
		if self.fadecount < 0 then
			return true	-- tell to terminate this game
		end
	end
	
end


function Dionysos:draw()

	local x,y = W/2, 30	-- adjust from picture
				-- we could even draw two, one from each hand

	LG.draw(self.spr, W/2, self.pos - self.spr:getHeight()/2)
	
	if self.strike then
		CLR(0,255,255)
		LG.line(x,y,self.target.x, self.target.y)
	
		-- fade screen
		CLR(0,0,0, (self.fadeinit - self.fadecount)/self.fadeinit * 255)
		LG.rectangle(love.draw_fill, 0, 0, W-1, H-1)
	end
	
	
	
end
