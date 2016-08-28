-- Translates level data into block IDs
BlockTranslationTable	= {
	['.']		= 0,
	['#']		= 1,
	['H']		= 2
	}

-- Block appearance and collision data.
-- imageLocation is the location of the tile:
-- tileset = assets/images/??????.png
-- x, y = 16x16-offset of the tile; so one right and down,
-- (16,16)-(31,31) would just be "1,1"
-- "type" is a little nebulous right now but "solid", "ladder", "empty"
-- mean basically what you would expect.
-- @todo In $future these will be procedurally fixed up for corners, etc. maybe
BlockTypes		= {
	[0]	= { imageLocation = { tileset = "tileset", x = "0", y = "0" }, type = "empty" },
	[1]	= { imageLocation = { tileset = "tileset", x = "1", y = "0" }, type = "solid" },
	[2]	= { imageLocation = { tileset = "tileset", x = "0", y = "1" }, type = "ladder"},
	[3]	= { imageLocation = { tileset = "tileset", x = "1", y = "1" }, type = "solid" }
	}
