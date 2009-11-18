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

endgame = {}

function endgame.init()
	
end

function endgame.draw()
	
	local spr = game.winner == 1 and img.win_tragi or img.win_comi

	LG.draw(spr, W/2, H/2)
end

function endgame.mousepressed()
	
	setGameState(menu)
end

function endgame.keypressed()
	
	setGameState(menu)
end
