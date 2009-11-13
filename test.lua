-- Just a fake game mode to test stuff around

require "map"
require "tiled"

test = {}

function test.init()

	local layer = map.layers[1]
	convert_layer(layer)

	for i = 1,502 do
		print(i,get_tile(map,i))
	end	
	
end

function test.draw()
	
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
