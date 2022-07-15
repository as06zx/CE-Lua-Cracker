local opcodes = require "opcodes"
local types   = require "types"
local log     = require "log"

local function bp_Load()
   local length = readInteger(RAX+0x10)
   local addr   = RAX+0x20
   local data = ""
   for i=0, length-1 do
      data = data .. string.char(readByte(addr+i))
   end
   --printf("load -> %s", data)
   log.writef("load -> %s", data)
end

local function bp_Decode()
   local data = readString(RAX, 6000)
   --printf("decodeFunction -> %s", data)
   log.writef("decodeFunction -> %s", data)
end

local function bp_Opcode()
   local data   = RAX
   --printf("Opcode -> %s", opcodes[data])
   log.writef("opcode -> %s", opcodes[data])
end

local function bp_OpEQ()
   local lua = RCX
   local val1 = readQword(RDX)
   local val2 = readQword(R8)
   local result = val1 == val2
   --printf("[EQ] -> %s == %s (%s)", val1, val2, result)
   log.writef("[EQ] -> %s == %s (%s)", val1, val2, result)
end

local function bp_OpGETTABUP()
   local p = readPointer(R8)
   local data = readString(p+0x20, 6000)
   --printf("[GETTABUP] -> %s", data)
   log.writef("[GETTABUP] -> %s", data)
end

local function bp_OpLOADK()
   local p        = R10+RAX*8
   local dataType = types[readInteger(p+8)]
   local data
   -- i will move method to get data/type later!
   if dataType == "NUMINT" then
      data     = readQword(p)
      dataType = "integer" 
   elseif dataType == "STRING" or dataType == "LNGSTR" then
      local pStr = readPointer(p)
      data       = readString(pStr)
      dataType   = "string"
   elseif dataType == "NUMBER" or dataType == "NUMFLT" then
      data     = readDouble(p)
      dataType = "float"
   elseif dataType == "STRING2" then
      p        = readPointer(p)
      data     = readString(p+0x20)
      dataType = "string"
   end
   log.writef("[LOADK] -> (%s) %s", dataType, data) 
end


--- -----
local function bp_Asm()
   local p = readPointer(RCX)
   local length = readInteger(p-0x8)
   local data   = readString(p, length)
   printf("autoAssemble -> %s", data)
end


local function bpShell()
   local length = readInteger(RDX-0x8)
   local data   = readString(RDX, length)
   printf("shellExecute -> %s", data)
end

local function bpCreate()
   local length = readInteger(RCX-0x8)
   local data   = readString(RCX, length)
   printf("createProcess -> %s", data)
end


return{
Load = bp_Load,
DecodeFunction = bp_Decode,

Opcode      =  bp_Opcode,
LOADK       =  bp_OpLOADK,
EQ          =  bp_OpEQ,
GETTABUP    =  bp_OpGETTABUP,
}
