menu = {}

imgui = {
	mx = 0,
	my = 0,
	mdown = false,
	
	hot = nil,
	active = nil
}

function sin01(T)
	local t = love.timer.getTime()
	return math.sin(t * math.pi * 2 / T) / 2 + 0.5
end

function regionhit(x,y,w,h)
	
	return imgui.mx >= x and imgui.mx < x + w and
		imgui.my >= y and imgui.my < y + h
end

function button(id, x, y, spr)

	-- hot or not
	if regionhit(x, y, spr:getWidth(), spr:getHeight()) then
	
		imgui.hot = id
		if not imgui.active and imgui.mdown then
			imgui.active = id
		end	
	end
	
	-- render
	local s = 1
	
	
	if imgui.hot == id then
		s = 1.1
	end
	
	if imgui.active == id then
		CLR(255,255,255,200)
	else
		CLR(255,255,255)
	end
	
	LG.setColorMode(love.color_modulate)
	LG.draw(spr, x + spr:getWidth()/2, y + spr:getHeight()/2,  0 , s)
	LG.setColorMode(love.color_normal)
	
	-- clicky?
	
	if not imgui.mdown and imgui.hot == id and imgui.active == id then
		return true
	end
	
	return false
end

function imgui_prepare()
	
	imgui.hot = nil
end

function imgui_finish()
	
	if not imgui.mdown then
		imgui.active = nil
	else
		if imgui.active == nil then
			imgui.active = -1
		end
	end

end


function menu.init()

end

function menu.mousepressed(x,y,b)
	
	if b == love.mouse_left then
		imgui.mdown = true
	end
end

function menu.mousereleased(x,y,b)
	
	if b == love.mouse_left then
		imgui.mdown = false
	end
end

function menu.update(dt)
	
	-- update imgui
	imgui.mx = LM.getX()
	imgui.my = LM.getY()
	
	
	
end


function menu.draw()
	
	imgui_prepare()
	
	-- Background
	CLR(200,100,50)
	LG.rectangle(love.draw_fill,0,0,LG.getWidth()-1,LG.getHeight()-1)
	
	-- Difficulty selection

	if button(1, 200, 300, img.comi) then
		setGameState(game, 3, 10)
	end
	
	if button(2, 300, 300, img.comi) then
		setGameState(game, 6, 15)
	end

	if button(3, 400, 300, img.comi) then
		setGameState(game, 10, 20)
	end

	
	imgui_finish()
end
