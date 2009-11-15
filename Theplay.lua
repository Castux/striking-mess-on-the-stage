require "class.lua"

Theplay = class()
-- The term "play" can refer to both the written works of playwrights
-- and to their complete theatrical performance. (Wikipedia)

-- This class is for generating and "playing" the text of the play.

function Theplay:init()

	-- No idea of what I'm going to put here.
	
	return self -- Mandatory
end

function Theplay:update(dt)
	
	-- On choisit un acteur au hasard
	local i = rand(0, nb_actors - 1)
	local parole = ""
	
	--if actors[i].side == 1 then
	--parole = "Tragi"
	--elseif actors[i].side == 2 then
	--parole = "Comi"
	--end
	
	-- ...puis une réplique de son camp
	-- Stocker la réplique dans le texte de la pièce
	-- et la faire dire à l'acteur
	actors[4]:says("Coucou")

	
end

function Theplay:draw() -- Useful ?
	
	-- :)
end

