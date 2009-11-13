-- Just a fake game mode to test stuff around

test = {}

function test.draw()
	
	LG.draw(img.bonus1, LM.getX(), 20)
	LG.draw(img.bonus3, 200, LM.getY())

end

function test.mousepressed(x,y,b)
	
	LA.play(snd.explo3)
	
	if b == love.mouse_right then
		print(mus.arcticum)
		LA.play(mus.arcticum)
	end
end
