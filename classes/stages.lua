
-- Stage decoder/storage/management class
local Stages = {}

-- All loaded stages
Stages.stages	= {}

-- All "global" objects
Stages.objects	= {}


function Stages:load(name)
	-- Load level data from file
	-- and replace \r\n (windows) with \n (everything else)
	local data	= love.filesystem.read("stages/".. name ..".txt")
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


-- Parse a block of level data
-- Expected to be 20 characters, 14 lines
function Stages:parseLayoutData(data)
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
			levelData[line - 1][i - 1]	= c
		end


	end

	return levelData
end




function Stages:getCurrent()
end


return Stages