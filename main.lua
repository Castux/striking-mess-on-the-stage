--[[
	Copyright © 2009 Noé Falzon

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


-- Include other files

require "test"
require "game"

------------------------------------------------------------------------
--[[ Some shortcuts ]]--------------------------------------------------
------------------------------------------------------------------------

LG = love.graphics
LM = love.mouse
LA = love.audio
LK = love.keyboard.isDown

CLR = love.graphics.setColor

TI = table.insert
rand = math.random
floor = math.floor

function sign(x)
	if x == 0 then
		return 0
	else
		return x > 0 and 1 or -1
	end
end

answer = 42

------------------------------------------------------------------------
--[[ Game state system ]]-----------------------------------------------
------------------------------------------------------------------------

function setGameState(state)

	--load = state.load 
	--not sure we should do that. let's have a init() instead,
	-- and only one load() for the whole game
	-- no point reloading everything it you want to start another round
	
	update = state.update or no_op
	draw = state.draw or no_op
	mousepressed = state.mousepressed or no_op
	mousereleased = state.mousereleased or no_op
	keypressed = state.keypressed or no_op
	keyreleased = state.keyreleased or no_op
	
	init = state.init or no_op

	init()
end

function no_op() end


------------------------------------------------------------------------
--[[ Assets loading system ]]-------------------------------------------
------------------------------------------------------------------------

-- Load all elements of folder "folder" using function "func", and put them
-- in the global table "folder"
-- If ext_filter is provided, load only files with this extension

function autoload(folder, func, ext_filter)

	-- make global table with name "folder"
	
	local tab = {}
	_G[folder] = tab
		
	local folder = folder .. "/"
	
	-- get all files in it
	local list = love.filesystem.enumerate(folder)
	
	for _,path in ipairs(list) do
		
		-- Get the name without the extension
		local name,ext = path:match("^(.*)%.([^%.]+)$")
		
		-- For all matches, apply function
		if name and ext_filter == nil or ext_filter == ext then
			tab[name] = func(folder .. path)
			print("Loaded " .. folder .. path)
		end
		
	end
end


--[[ Automatic loading. Not sure if the load() callback is useful ]]

-- Images
autoload("img", LG.newImage)
	
-- Sounds
autoload("snd", LA.newSound)

-- Music
autoload("mus", LA.newMusic)

--[[ Some things to take care of ]]

math.randomseed(os.time())

--[[ Set initial game state ]]

setGameState(game)

