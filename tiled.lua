-- A few functions to read data from Tiled lua maps

require "base64"

-- Convert base64 string data into a list of GIDs
function convert_layer(layer)
	
	local data = layer.data.content
	
	-- Decode base64
	data = b64.dec(data)
	
	-- Read in tiles 4 bytes at a time (little endian Uint32)
	
	local gids = {}
	
	for i = 1,#data-4,4 do
		print(i)
		local gid = data:byte(i) +
			256 * data:byte(i+1) +
			256^2 * data:byte(i+2) +
			256^3 * data:byte(i+3)
		
		TI(gids, gid)
	end
	
	-- Replace original data
	layer.data = gids
end

-- Map GIDs to tilemap and index in it
function get_tile_ts_and_index(map, gid)

	-- Find which tileset
	
	local ts
	
	for i = 2, #map.tilesets do
		if gid < map.tilesets[i].firstgid then
			ts = i-1
			break	
		end
	end
	
	if not ts then ts = #map.tilesets end
	
	-- deduce index
	local ind = gid - ts
	
	return ts,ind
end
