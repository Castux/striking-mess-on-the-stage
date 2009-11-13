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

--[[
love.filesystem.require("game.lua")
love.filesystem.require("menu.lua")
love.filesystem.require("win.lua")
--]]

clr = love.graphics.newColor
LG = love.graphics
TI = table.insert
rand = math.random

answer = 42

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

function load()

	--menu.load()
	--game.load()
	--win.load()
	
end

--setGameState(menu)
