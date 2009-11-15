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

	-- Pour que l'acteur se taise au bout d'un moment
	self.tps_parole = self.tps_parole - dt
	-- il fait a ˆ chaque dt : problme ? Ajout d'un test ?

end


function Actor:swap()
	
	-- will maybe have fancy animation later
	
	self.side = self.side == 1 and 2 or 1
end

function Actor:getsprite()
	
	return self.side == 1 and img.tragi or img.comi
end

function Actor:says(truc)

	-- pour quand l'acteur dit un truc
	-- on affiche le truc au-dessus (ou ˆ cotŽ) de sa tete, dans une bulle par ex.

	self.parole = truc
	self.tps_parole = 2 -- possible de le passer en argument selon la longueur des rŽpliques

end

function Actor:draw()
	
	local x,y,s = game.game2screen(self.x, self.y)
	
	if self.side == 1 then
		CLR(0,0,255,80) -- tragi ?
	elseif self.side == 2 then
		CLR(255,0,240,80) -- comi ?
	end
	
	-- on n'affiche quelque chose que s'il a quelque chose ˆ dire
	if self.parole ~= "" and self.tps_parole > 0 then
		LG.rectangle(0,x - 5, y - 75, 110, 43)
		CLR(0,0,0)
		LG.drawf(self.parole,x,y - 65,100,2)
	end
	
	
	-- On dessine l'acteur par-dessus la bulle
	Actor.super.draw(self)
end
