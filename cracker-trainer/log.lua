local log         = Cracker.Log

local function clearLog()
   log.lines.Clear()
end

local function writeLog(s)
   log.lines.add(s)
end

local function writeLogFormat(f,...)
   log.lines.add(f:format(...))
end

return{
clear  = clearLog,
write  = writeLog,
writef = writeLogFormat 
}