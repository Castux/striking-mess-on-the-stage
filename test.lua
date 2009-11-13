-- Just a fake game mode to test stuff around

test = {}

function test.draw()
	
	LG.draw(img.bonus1, LM.getX(), 20)
	LG.draw(img.bonus3, 200, LM.getY())

end

function test.mousepressed(b,x,y)
	
	LA.play(snd.explo3)
end
