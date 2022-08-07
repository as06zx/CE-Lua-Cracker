local opcodes = require "opcodes"
local types   = require "types"
local log     = require "log"

local function bp_Opcode()
   local data   = RAX
   --printf("Opcode -> %s", opcodes[data])
   --log.writef("opcode -> %s", opcodes[data])
end

local function bp_OpMOVE()
   local p        = R12+RAX*8
   local dataType = memhelp.getType(p)
   local data     = memhelp.getData(p)

   --log.writef("[MOVE] -> (%s) %s", dataType, data)

   local A = RSI -- R14//8==0 and 0 or R14//8//2
   local B = RAX==0 and 0 or RAX//2
   local variable1 = var..A
   local variable2 = var..B
   log.writef("local %s = %s", variable1, variable2)
end

local function bp_OpLOADK()
   local p        = R10+RAX*8
   local dataType = memhelp.getType(p)
   local data     = memhelp.getData(p)
   --log.writef("[LOADK] -> (%s) %s", dataType, data)
   local A = RSI
   local variable = var..A
   data = type(data)=="string" and ("\"%s\""):format(data) or data -- move to memhelper later!
   log.writef("local %s = %s", variable, data)
end

local function bp_OpEQ()
   local lua = RCX
   local val1 = readQword(RDX)
   local val2 = readQword(R8)
   local result = val1 == val2
   --printf("[EQ] -> %s == %s (%s)", val1, val2, result)
   log.writef("[EQ] -> %s == %s (%s)", val1, val2, result)
end

local function bp_OpLOADKX()
   -- i don't know how call this
   log.write("[LOADKX] called.")
end

local function bp_OpLOADBOOL()
   local A = RSI
   local B = RAX
   -- R(A) := (Bool)B; if (C) pc++
   local var1 = var .. A
   local bool = B==1
   log.writef("local %s = %s", var1, bool)
end


local function bp_OpLOADNIL()
   local A = RSI
   local B = RDI
   -- R(A), R(A+1), ..., R(A+B) := nil
   local left = "" 
   for i=A, A+B do
      left = left .. (var..i)
      if i~=A+B then
         if #left ~= 0 then
            left = left .. ", "
         else
            left = left .. " "
         end
      end
   end
   log.writef("local %s= nil", left)
end

local function bp_OpGETUPVAL()
   local A = RSI
   local B = RAX
   -- R(A) := UpValue[B]
   log.write("[GETUPVAL] called")
end

local function bp_OpGETTABUP()
   local p = readPointer(R8)
   local data = readString(p+0x20, 6000)
   --printf("[GETTABUP] -> %s", data)
   --log.writef("[GETTABUP] -> %s", data)
   
   local A = RSI
   local variable = var..A
   log.writef("local %s = _ENV[\"%s\"]", variable, data)
end


local function bp_OpGETTABLE()
   local A = RSI
   local B = RDX
   local C = readInteger(R8)
   -- R(A) := R(B)[RK(C)] 
   local var1 = var .. A
   local var2 = var .. B
   log.writef("local %s = %s[%s]", var1, var2, C)
end

local function bp_OpSETTABUP()

end

local function bp_OpSETTABLE()
   -- A B C   R(A)[RK(B)] := RK(C)      
   local RA = var .. RSI
   local RKB = readInteger(R8)
   local RKC = readInteger(R9) --> need make real RKC function
   log.writef("%s[%s] = %s", RA, RKB, RKC)
end

local function bp_OpNEWTABLE()
   --  A B C   R(A) := {} (size = B,C)   
   local A = RSI
   local var1 = var .. A
   log.writef("local %s = {}", var1)
end

local function bp_OpCALL()
   local A = RSI
   local B = RAX
   local C = RDI
   -- R(A), ... ,R(A+C-2) := R(A)(R(A+1), ... ,R(A+B-1))
   local variable = var
   local left = ""
   for i=A, A+C-2 do
      left = left .. (variable..i)
      if i~=A+C-2 then
         if #left ~= 0 then
            left = left .. ", "
         else
            left = left .. " "
         end
      else
         left = left .. " = "
      end
   end

   local mid   = (variable..A) 
   local right = ""
   for i=A+1, A+B-1 do
      right = right .. (variable..i)
      if i~=A+B-1 then
         right = right .. ", "
      end
   end

   log.writef("%s%s(%s)", left, mid, right)
end


--- -----

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

local function bp_Internet()
   local data     = readString(RDX, 300)
   log.writef("getURL -> %s", data)
end


return{
Load = bp_Load,
DecodeFunction = bp_Decode,
Internet       = bp_Internet,
---------------------------------------

Opcode      =  bp_Opcode,
-----------------------
MOVE        =  bp_OpMOVE,
LOADK       =  bp_OpLOADK,
LOADKX      =  bp_OpLOADKX,
LOADBOOL    =  bp_OpLOADBOOL,
LOADNIL     =  bp_OpLOADNIL,

GETUPVAL    =  bp_OpGETUPVAL,
GETTABUP    =  bp_OpGETTABUP,
GETTABLE    =  bp_OpGETTABLE,

SETTABUP    =  bp_OpSETTABUP,
SETTABLE    =  bp_OpSETTABLE,

NEWTABLE    =  bp_OpNEWTABLE,

EQ          =  bp_OpEQ,
CALL        =  bp_OpCALL,
}
