local addr_Opcode               = "lua53-64.dll+31902"
local addr_Opcode_MOVE          = "lua53-64.dll+31925"

local addr_Opcode_LOADK         = "lua53-64.dll+3193C"
local addr_Opcode_LOADKX        = "lua53-64.dll+3195E"
local addr_Opcode_LOADBOOL      = "lua53-64.dll+31977"
local addr_Opcode_LOADNIL       = "lua53-64.dll+3198A"

local addr_Opcode_GETUPVAL      = "lua53-64.dll+319BC" -- not sure can with end part addr
local addr_Opcode_GETTABUP      = "lua53-64.dll+319DD"
local addr_Opcode_GETTABLE      = "lua53-64.dll+31A30"

local addr_Opcode_SETTABUP      = "lua53-64.dll+31AA8"
local addr_Opcode_SETTABLE      = "lua53-64.dll+31B42" -- lua53-64.dll+31AFC

local addr_Opcode_NEWTABLE      = "lua53-64.dll+31B79"


local addr_Opcode_EQ            = "lua53-64.dll+3294C"
local addr_Opcode_CALL          = "lua53-64.dll+32C05"
--- constants = lua53-64.dll+3187C 
-- lua53-64.dll+31863  / lua53-64.dll+3186E  inst proto check below

local addr_Load                 = "lua53-64.luaL_checkversion_+1906"
local addr_AutoAssemble         = "cheatengine-x86_64-SSE4-AVX2.exe+264DBA" --48 8B 55 A8 48 8b 4D E8 48 8B 45 E8 48 8B 00 FF ?? ?? ?? ?? ?? 83 7D F0 01
local addr_DecodeFunction       = "cheatengine-x86_64-SSE4-AVX2.exe+27F585"
local addr_ShallExecute         = "cheatengine-x86_64-SSE4-AVX2.exe+272B56"
local addr_CreateProcess        = "cheatengine-x86_64-SSE4-AVX2.exe+2682CD"
local addr_Internet             = "cheatengine-x86_64-SSE4-AVX2.exe+36E65A"

return{
Opcode 	    = 	addr_Opcode,
LOADK       =   addr_Opcode_LOADK,
EQ        	= 	addr_Opcode_EQ,
GETTABUP   	=	  addr_Opcode_GETTABUP,

Load 			      = 	addr_Load,
AutoAssemble   	= 	addr_AutoAssemble,
DecodeFunction 	= 	addr_DecodeFunction,
ShallExecute 	  = 	addr_ShallExecute,
CreateProcess 	= 	addr_CreateProcess
Internet        =   addr_Internet,
}
