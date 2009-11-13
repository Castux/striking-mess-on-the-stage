-- A few functions to read data from Tiled lua maps

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

-- 
function draw_layer(layer)
	
	for i,v in ipairs(layer.data) do	
		draw_tile(v)
	end
end

function draw_tile(t)
	
	local gid = t.gid
	
	if not gid then
		return
	end
	
	LG.draws(gid.img, t.x, t.y, gid.x, gid.y, gid.w, gid.h)
	
end
