require "Character.lua"

Muse = class(Character)

-- The default Muse class is the ennemy AI one.
-- (Overload for player)

function Muse:init(x,y)

	Muse.super.init(self,x,y,foes)
	
	return self
end

function Muse:getsprite()
	
	return self.side == 1 and img.tragi or img.comi
end
