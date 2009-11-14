require "Character.lua"

Muse = class(Character)

-- The default Muse class is the ennemy AI one.
-- (Overload for player)

function Muse:init(x,y)

	Muse.super.init(self,x,y,foes)
	
	return self
end

function Muse:getsprite()
	
	return self.side == 1 and img.musetragi or img.musecomi
end

-- Da super AI
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
		
		--local norm = math.sqrt(dx^2 + dy^2)
		local norm = candidates[1][2]
		
		ax,ay = dx/norm, dy/norm
	end
	
	self:accelerate(ax, ay, dt)
end
