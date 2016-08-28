-- Translates level data into block IDs
BlockTranslationTable	= {
	['.']		= 0,
	['#']		= 1,
	['H']		= 2
	}

-- Block collision data.
-- ImageLocation is done in loading step
BlockTypes		= {
	[0]	= { imageLocation = { tileset = "tileset", x = "0", y = "0" }, type = "empty" },
	[1]	= { imageLocation = { tileset = "tileset", x = "1", y = "0" }, type = "solid" },
	[2]	= { imageLocation = { tileset = "tileset", x = "0", y = "1" }, type = "ladder"},
	[3]	= { imageLocation = { tileset = "tileset", x = "1", y = "1" }, type = "solid" }
	}


-- Translate a character into a block type (id)
function characterToBlock(char)
	if BlockTranslationTable[char] then
		return BlockTranslationTable[char]
	else
		error("Unknown leveldata block type: ".. char)
	end
end
