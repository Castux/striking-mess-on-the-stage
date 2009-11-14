require "Character.lua"

Muse = class(Character)

-- The default Muse class is the ennemy AI one.
-- (Overload for player)

function Muse:init(x,y)

	Muse.super.init(self,x,y,foes)
	
	-- Muses are faster
	
	self.maxspeed = 100
	
	return self
end

function Muse:getsprite()
	
	return self.side == 1 and img.musetragi or img.musecomi
end

-- Da super AI

swapdist = 50
swapcost = 0.4

function Muse:update(dt)

	-- Find closest actor to swap
	
	-- List candidates and their distance
	local candidates = {}
	
	for i,v in ipairs(actors) do
		if v.side == team then
			TI(candidates, {v, self:distance(v)} )
		end
	end
	
	-- If any, follow closest
	local ax,ay = 0,0
	
	if #candidates > 0 then
	
		table.sort(candidates, function(a,b)
			return a[2] < b[2]
		end)
		
		local closest = candidates[1][1]
		
		
		-- Get direction to target
		local dx = closest.x - self.x
		local dy = closest.y - self.y
		
		local norm = candidates[1][2]
		
		-- Also check if we're close enough to swap him
		if norm < swapdist then
			
			-- consume some energy
			if foes == 1 then	-- comi->tragi "spends" tragi so augments comi
				dir = 1
			else
				dir = -1	-- tragi->comi "spends" comi so aumgents tragi
			end
			
			player.bar = player.bar + dir * swapcost
			
			closest:swap()
			
			ax,ay = 0,0
		else
			ax,ay = dx/norm, dy/norm
		end
	end
	
	self:accelerate(ax, ay, dt)
end
