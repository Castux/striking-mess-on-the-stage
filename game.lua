require "Player.lua"
require "Actor.lua"

game = {}



function game.init()
	
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
		x = 200,
		y = 100,
		w = 400,
		W = 700,
		h = 300
	}
	
	-- Make an entity list (entities are updated and drawn automatically)
	-- Entities should have an y field, for sorting/drawing purposes
	entities = {}
	
	-- Make a player!
	
	player = Player()
	TI(entities, player)	-- register it for updating/drawing
	
	-- Make some actors
	
	actors = {}
	for i = 1,10 do
		local tmp = Actor()
		TI(actors, tmp)
		TI(entities, tmp)
	end
end

function game.keypressed(k)
	
	if k == love.key_escape then
		love.system.exit()
	end
	
end

function game.update(dt)
	
	-- Update all entities
	for i,v in ipairs(entities) do
		if v.update then
			v:update(dt)
		end
	end
	
end

function game.draw()
	
	-- Background
	CLR(0,200,100)
	LG.rectangle(love.draw_fill, 0, 0, LG.getWidth(), LG.getHeight())
	
	-- Scene boundaries
	
	CLR(0,0,255)
	
	for _,v in ipairs{{0,0},{W,0},{W,H},{0,H}} do
		local x,y = game.game2screen(v[1],v[2])
		LG.circle(love.draw_fill, x, y, 5)
	end
	
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
	
	player:drawbar()
	
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
