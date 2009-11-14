require "player"

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
		-- we'll project later, mmmkay?
	
	-- Make an entity list (entities are updated and drawn automatically)
	
	entities = {}
	
	-- Make a player!
	
	player = Player()
	
	TI(entities, player)	-- register it for updating/drawing
	
	
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
	
	-- Draw all entities
	-- (Later we will need to sort objects and characters back to front)
	for i,v in ipairs(entities) do
		if v.draw then
			v:draw()
		end
	end
	
end
