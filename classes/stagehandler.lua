
-- Stage decoder/storage/management class
local StageHandler = {}

-- All loaded stages
StageHandler.stages	= {}

-- All "global" objects
StageHandler.objects	= {}


function StageHandler:load(name)
	-- Load level data from file
	-- and replace \r\n (windows) with \n (everything else)
	local data	= love.filesystem.read("assets/stages/".. name ..".txt")
	if not data then
		error("Failed to load stage assets/stages/".. name ..".txt")
	end
	data		= data:gsub("\r\n", "\n")

	-- Split data file into 3 parts
	-- Room name, Level Data (as text), Object Data
	local dataTable	= explode("\n\n", data)


	for k,v in pairs(dataTable) do
		print(k, v)
	end


	return {
		name	= dataTable[1],
		layout	= self:parseLayoutData(dataTable[2]),
		objects	= dataTable[3],
		}

end


-- Get a stage (or load it if it doesn't exist yet)
function StageHandler:get(name)
	print("StageHandler: fetching ".. name)
	if self.stages[name] then
		return self.stages[name]
	end

	-- Stage isn't loaded, load it now
	self.stages[name]	= self:load(name)
	return self.stages[name]
end



-- Parse a block of level data
-- Expected to be 20 characters, 14 lines
function StageHandler:parseLayoutData(data)
	local levelData	= {}

	-- Explode into individual lines
	local dataArray	= explode("\n", data)
	if #dataArray ~= 14 then
		error("Expected 14 lines of stage layout data, got ".. #dataArray)
	end

	-- Go through each line, make sure they have the right # of characters
	-- Convert into level data array
	for line = 1, #dataArray do
		if string.len(dataArray[line]) ~= 20 then
			error("Line ".. line ..": Expected 20 characters , got ".. string.len(dataArray[line]))
		end

		-- Indexed from 0 despite what Lua wants
		levelData[line - 1]	= {}


		-- Iterate every character, put into array
		for i = 1, #dataArray[line] do
			local c = dataArray[line]:sub(i,i)
			levelData[line - 1][i - 1]	= Block:characterToBlock(c)
		end


	end

	return levelData
end




function StageHandler:getCurrent()
end


return StageHandler
