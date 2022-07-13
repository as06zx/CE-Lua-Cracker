local opcodes = require "opcodes"

local function bpLoad()
   local length = readInteger(RAX+0x10)
   local data   = readString(RAX+0x20, length)
   printf("load -> %s", data)
end

local function bpAsm()
   local p = readPointer(RCX)
   local length = readInteger(p-0x8)
   local data   = readString(p, length)
   printf("autoAssemble -> %s", data)
end

local function bpDecode()
   local data = readString(RAX, 6000)
   printf("decodeFunction -> %s", data)
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

local function bpOpcode()
   local data   = RAX
   printf("Opcode -> %s", opcodes[data])
end

local function bpOpEQ()
   local lua = RCX
   local val1 = readQword(RDX)
   local val2 = readQword(R8)
   local result = val1 == val2
   printf("[EQ] -> %s == %s (%s)", val1, val2, result)
end

local function bpOpGetTabUp()
   local p = readPointer(R8)
   local data = readString(p+0x20, 6000)
   printf("[GETTABUP] -> %s", data)
end

debugProcess()
debug_setBreakpoint("lua53-64.luaL_checkversion_+1906", bpLoad)
debug_setBreakpoint("cheatengine-x86_64-SSE4-AVX2.exe+264DBA", bpAsm)
debug_setBreakpoint("cheatengine-x86_64-SSE4-AVX2.exe+27F585", bpDecode)
debug_setBreakpoint("cheatengine-x86_64-SSE4-AVX2.exe+272B56", bpShell)
debug_setBreakpoint("cheatengine-x86_64-SSE4-AVX2.exe+2682CD", bpCreate)


debug_setBreakpoint("lua53-64.dll+31902", bpOpcode)
debug_setBreakpoint("lua53-64.dll+3294C", bpOpEQ)
debug_setBreakpoint("lua53-64.dll+319DD", bpOpGetTabUp)
