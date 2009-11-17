require "class.lua"

Dionysos = class()

function Dionysos:init(target)
	
	self.spr = img.dionysos
	self.target = target
	
	self.wait = 2
	self.waitcount = self.wait
	
	self.fadeinit = 5
	self.fadecount = self.fadeinit
	
	self.strike = false
	
	return self
end

function Dionysos:update(dt)
	
	
	if not self.strike then
		self.waitcount = self.waitcount - dt
	
		if self.waitcount < 0 then
			self.waitcount = 0
			self.strike = true
		end
	
	else
		self.fadecount = self.fadecount - dt
		
		if self.fadecount < 0 then
			return true	-- tell to terminate this game
		end
	end
	
end


function Dionysos:draw()

	local x,y,s = game.game2screen(self.target.x, self.target.y)
	
	local fadein = (self.wait - self.waitcount)/self.wait
	
	CLR(255,255,255, fadein*255)
	LG.setColorMode(love.color_modulate)
	LG.draw(self.spr, x - 50*s, y - self.target:getsprite():getHeight()*s - 20 - self.spr:getHeight()/2/3, 0, 0.33)
	LG.setColorMode(love.color_normal)
	
	if self.strike then
		local sc = 1 + rand()*0.1
		local ang = (rand() - 0.5)*10
		
		-- kaboom
		LG.draw(img.kaboum, x, y - self.target:getsprite():getHeight()/2*s, ang, s*sc*0.3)

		-- fade screen
		CLR(0,0,0, (self.fadeinit - self.fadecount)/self.fadeinit * 255)
		LG.rectangle(love.draw_fill, 0, 0, W-1, H-1)
	end
	
	
	
end
