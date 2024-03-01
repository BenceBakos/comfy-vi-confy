require("os")
require("io")

Log = {}

Log.tableToString = function (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. Log.tableToString(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end

Log.log = function (msg)
	if type(msg) == "table" then msg = Log.tableToString(msg) end

	local f = io.open(os.getenv("HOME") .. "/nvim.error", "a")
	if msg and f then
		io.output(f)
		f.write(f, msg .. "\n")
		io.close(f)
	end

end

Log.err = function (msg)
	if type(msg) == "table" then msg = Log.tableToString(msg) end

	print(msg)
	Log.log(msg)
end

return Log
