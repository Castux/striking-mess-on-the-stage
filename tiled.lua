--[[
A few functions to read data from Tiled lua maps

BEWARE: in Tiled, maps must be saved (of course) using the Lua export,
but be sure to check the following things:

- in Preferences->Saving, check "Use binary encoding" but NOT "Compress
layer data"

- the tileset options have no incidence (not complete plugin)

- all tilesets must be created with "Reference tileset image" checked,
and of course a valid image there. The name of the image must be the same
as the one autoloaded. Tilespacing and margins are not supported.

- all tilesets must be embedded, external tsx files are not supported

WARNING: Tiled cannot load Lua files, so be sure to keep a native file too.
]]


require "base64"


-- Use the image size info to compute stuff
-- Add all its tiles to the gid_tab

function convert_tileset(ts, gid_tab)
	
	local image = ts[1].source
	
	-- remove extension
	image = image:gsub("%.[^%.]-$","")
	
	local sprite = img[image]
	
	if not sprite then
		error("Image " .. image .. " not loaded, cannot convert tileset.")
	end
	
	-- add some info to the tileset table
	
	-- image size
	ts.w, ts.h = sprite:getWidth(), sprite:getHeight()
	ts.img = sprite
	
	-- image size in tiles
	ts.nw = floor(ts.w/ts.tilewidth)
	ts.nh = floor(ts.h/ts.tileheight)
	
	-- number of tiles
	ts.N = ts.nw*ts.nh

	-- Fill gid_tab
	local gid = ts.firstgid
	
	
	for v = 0,ts.nh-1 do
		for u = 0,ts.nw-1 do
			local tile = {
				x = u * ts.tilewidth,
				y = v * ts.tileheight,
				w = ts.tilewidth,
				h = ts.tileheight,
				
				img = ts.img,
				
				-- props = 
			}
			
			gid_tab[gid] = tile
			gid = gid + 1
		end
	end
	
	-- (Hopefully Tiled counts firstgids correctly and it won't overlap)
	
	-- Add properties to tiles
	
end

-- Convert base64 string data into a list of GIDs
function convert_layer(layer, gid_tab, tw, th)
	
	local data = layer.data.content
	
	-- Decode base64
	data = b64.dec(data)
	
	-- Read in tiles 4 bytes at a time (little endian Uint32)
	
	local gids = {}
	
	for i = 1,#data-4,4 do
	
		local gid = data:byte(i) +
			256 * data:byte(i+1) +
			256^2 * data:byte(i+2) +
			256^3 * data:byte(i+3)
		
		TI(gids, gid)
	end
	
	-- add some info
	
	layer.tilewidth = tw
	layer.tileheight = th
	
	-- take care of layer offset
	
	layer.x = layer.x or 0
	layer.y = layer.y or 0
	
	-- Now replace these with more useful data, that is a pointer to
	-- the tile in the gid table, and position of the tile.
	
	for i,gid in ipairs(gids) do
		
		local tmp = {}
		tmp.gid = gid_tab[gid]
				
		tmp.u = (i-1) % layer.width + layer.x
		tmp.v = floor((i-1)/layer.width) + layer.y
			
		tmp.x = tmp.u * tw
		tmp.y = tmp.v * th
		
		gids[i] = tmp
	end
	
	
	-- Replace original data
	layer.data = gids
end


function convert_map(map)

	map.gids = {}
	
	for i,ts in ipairs(map.tilesets) do
		convert_tileset(ts, map.gids)
	end
	
	for i,la in ipairs(map.layers) do
		convert_layer(la, map.gids, map.tilewidth, map.tileheight)
	end

end

function draw_map(map, offx, offy)
	
	for _,layer in ipairs(map, layers) do
		draw_layer(layer, offx, offy)
	end
	
end

function draw_layer(layer, offx, offy)
	
	for _,v in ipairs(layer.data) do	
		draw_tile(v, offx, offy)
	end
end

function draw_tile(t, offx, offy)
	
	local gid = t.gid
	
	if not gid then
		return
	end
	
	local offx,offy = offx or 0, offy or 0
	
	LG.draws(gid.img, t.x + offx, t.y + offy, gid.x, gid.y, gid.w, gid.h)	
end
