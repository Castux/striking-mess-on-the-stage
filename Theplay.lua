require "class.lua"
require "thescripts.lua"

Theplay = class()
-- The term "play" can refer to both the written works of playwrights
-- and to their complete theatrical performance. (Wikipedia)

-- This class is for generating and "playing" the text of the play.

function Theplay:init()

	self.cycle = 5 -- une nouvelle réplique tous les xx
	
	self.thescript = {} -- À afficher à la fin (ou pendant ?)
	
	return self -- Mandatory
end

function Theplay:update(dt)
	
	if self.cycle < 0 then
	
		-- On choisit un acteur au hasard
		local i = rand(nb_actors)
		
		-- choix de la réplique
		local replique = ""
		
		if actors[i].side == 1 then
			local j = rand(lg_tragiscript)
			replique = tragiscript[j]
			
		elseif actors[i].side == 2 then
			local j = rand(lg_comiscript)
			replique = comiscript[j]
			
		end
		
		-- L'acteur dit sa réplique
		actors[i]:says(replique)
		self.cycle = 5
		
		-- On stocke la réplique dans le script de la pièce
		TI(self.thescript,{replique,actors[i].side})
	
	else
		self.cycle = self.cycle - dt
	end
	
end

function Theplay:draw() -- Useful ?
	
	-- :)
end

