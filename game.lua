--[[
	Striking Mess On The Stage (Because Of The Jealousy Of A Cute Divine Girl)
	Copyright © 2009 Agnès Haasser & Noé Falzon

	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

require "Player.lua"
require "Actor.lua"
require "Muse.lua"
require "Theplay.lua"
require "Object.lua"
require "Dionysos.lua"

game = {}



function game.init(nactors, nobjects)
	
	-- Pick a random side to be in
	
	sides = {"Tragi", "Comi"}
	
	team = rand(2)
	foes = team == 1 and 2 or 1
	
	print("Starting game as " .. sides[team])
	
	-- Decide scene dimension (game coords) : screen size, in fact
	W = LG.getWidth()
	H = LG.getHeight()
		
	-- Decide scene dimensions (screen coords) : any trapezoid
	trap = {
		x = 290,
		y = 225,
		w = 430,
		W = 820,
		h = 390
	}
	
	-- Make an entity list (entities are updated and drawn automatically)
	-- Entities should have an y field, for sorting/drawing purposes
	entities = {}
	
	-- Make a player!
	
	player = Player()
	TI(entities, player)	-- register it for updating/drawing
	
	
	-- And ennemy muse
	muse = Muse()
	TI(entities, muse)
	
	-- Objects
	nb_objects = nobjects
	objects = {}
	for i = 1,nb_objects do
		local tmp = Object()
		TI(objects, tmp)
		TI(entities, tmp)
	end
	
	-- Make some actors
	nb_actors = nactors
	actors = {}
	for i = 1,nb_actors do
		local tmp = Actor()
		TI(actors, tmp)
		TI(entities, tmp)
	end
	
	-- Wrong objects
	game.badobjs = 0	-- set at each update

	-- Make a play
	
	theplay = Theplay()
	
	-- Game state
	game.state = 'NORMAL'
		-- 'ENDGAME'
	
	-- Start the Muse-ic!
	local tracks = {"Melpomene","Thalie"}
	LA.play(mus[tracks[team]])
		
end

function game.keypressed(k)
	
	if k == love.key_escape then
		love.system.exit()
	elseif k == love.key_space then
		player:tryswap()
	end
	
	
end

function game.update(dt)
	
	if game.state == 'ENDGAME' then
		game.updateend(dt)
		return
	end
	
	-- Update all entities
	for i,v in ipairs(entities) do
		if v.update then
			v:update(dt)
		end
	end
	
	-- Update the play
	theplay:update(dt)
	
	-- Count the remaining objects to swap
	game.badobjs = 0
	for i,v in ipairs(objects) do
		if v.side == foes then
			game.badobjs = game.badobjs + 1
		end
	end
	
	-- Check da win
	if game.badobjs == 0 or LK(love.key_b) then
		
		game.state = 'ENDGAME'
		game.winner = team
		
		-- Create D, and direct it at the other muse
		dionysos = Dionysos(muse)
	
	-- Check da lose
	elseif game.badobjs == nb_objects then
		
		game.state = 'ENDGAME'
		game.winner = foes
		
		-- Create D, and direct it at the player muse
		dionysos = Dionysos(player)
	end
end

function game.updateend(dt)
	
	local terminate = dionysos:update(dt)
	
	-- check if he's done striking, and go back to title
		
	if terminate then
		--love.system.restart()
		setGameState(endgame, game.winner)
	end
end

function game.draw()
	
	-- Background
	LG.draw(img.Decor, LG.getWidth()/2, LG.getHeight()/2)
	
	--[[ Scene boundaries
	
	CLR(0,0,255)
	
	for _,v in ipairs{{0,0},{W,0},{W,H},{0,H}} do
		local x,y = game.game2screen(v[1],v[2])
		LG.circle(love.draw_fill, x, y, 5)
	end]]
	
	-- Sort entities back to front (increasing y)
	
	table.sort(entities, function(a,b)
		return a.y < b.y
	end)
	
	-- And draw them all
	
	for i,v in ipairs(entities) do
		if v.draw then
			v:draw()
		end
	end
	
	-- HUD
	
	-- player:drawbar() --[[ FORGET THE PLAYER POWER? ]]
	
	game.drawmeter()
	
	
	-- Dionysos
	if game.state == 'ENDGAME' then
		dionysos:draw()
	end
	
end

-- Coordinates conversion
function game.game2screen(x,y)
	
	local u,v = x/W, y/H
	
	local Y = trap.y + v * trap.h
	
	local w = lerp(trap.w, trap.W, v)
	local X = trap.x + trap.w/2 - w/2 + u * w
	
	local scale = w/trap.W
	
	return X,Y,scale
end

function game.drawmeter()
	
	local x,y = 20,20
	local shift = 70	-- height of the masks at top and bottom of the scale
	
	local ratio = game.badobjs / nb_objects
	
	if team == 1 then
		ratio = 1 - ratio
	end
	
	LG.draw(img.scale, x + img.scale:getWidth()/2, y + img.scale:getHeight()/2)
	LG.draw(img.marker, x + 50, floor(y + shift + (img.scale:getHeight() - 2*shift)*ratio))
end
