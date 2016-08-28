
local Block		= {}
Block.images	= {}

function Block:prepareBlocks()
	for k,v in pairs(BlockTypes) do
		v.image	= self:createTileQuad(v.imageLocation.tileset, v.imageLocation.x, v.imageLocation.y)
	end

end


function Block:drawBlock(x, y, type)
	love.graphics.draw(BlockTypes[type].image.image, BlockTypes[type].image.quad, x * 16, y * 16)
end


-- Create a new tile quad based on tileset name, x, y
-- ASSUMES ALL TILES ARE 16x16 AND GRID ALIGNED
function Block:createTileQuad(filename, x, y)
	if not self.images[filename] then
		self.images[filename]	= love.graphics.newImage("assets/images/".. filename ..".png")
	end

	return {
			image	= self.images[filename],
			quad	= love.graphics.newQuad(x * 16, y * 16, 16, 16, self.images[filename]:getDimensions())
		}
end


-- Translate a character into a block type (id)
function Block:characterToBlock(char)
	if BlockTranslationTable[char] then
		return BlockTranslationTable[char]
	else
		error("Unknown leveldata block type: ".. char)
	end
end


return Block
