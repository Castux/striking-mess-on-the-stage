-- Just a fake game mode to test stuff around

require "map"
require "tiled"

test = {}

function test.init()

	convert_map(map)
end

function test.draw()
	
	draw_layer(map.layers[1])
	
	LG.draw(img.bonus2, LM.getX(), 200)
	LG.draw(img.bonus3, 200, LM.getY())

end

function test.mousepressed(x,y,b)
	
	
	if b == love.mouse_left then
		LA.play(snd.explo3)
	elseif b == love.mouse_right then
		LA.play(mus.arcticum)
	end
end
