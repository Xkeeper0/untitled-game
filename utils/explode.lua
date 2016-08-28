-- Shamelessly copied from http://lua-users.org/wiki/SplitJoin

local explode = function(sep, str, limit)
	if not sep or sep == "" then return false end
	if not str then return false end
	limit = limit or math.huge
	if limit == 0 or limit == 1 then return {str},1 end

	local r = {}
	local n, init = 0, 1

	while true do
		local s,e = string.find(str, sep, init, true)
		if not s then break end
		r[#r+1] = string.sub(str, init, s - 1)
		init = e + 1
		n = n + 1
		if n == limit - 1 then break end
	end

	if init <= string.len(str) then
		r[#r+1] = string.sub(str, init)
	else
		r[#r+1] = ""
	end
	n = n + 1

	if limit < 0 then
		for i=n, n + limit + 1, -1 do r[i] = nil end
		n = n + limit
	end

	return r, n
end

return explode