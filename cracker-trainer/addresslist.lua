local addr_Opcode               = "lua53-64.dll+31902"
local addr_Opcode_LOADK         = "lua53-64.dll+3193C"
local addr_Opcode_EQ            = "lua53-64.dll+3294C"
local addr_Opcode_GETTABUP      = "lua53-64.dll+319DD"
--- constants = lua53-64.dll+3187C 
-- lua53-64.dll+31863  / lua53-64.dll+3186E  inst proto check below

local addr_Load                 = "lua53-64.luaL_checkversion_+1906"
local addr_AutoAssemble         = "cheatengine-x86_64-SSE4-AVX2.exe+264DBA" --48 8B 55 A8 48 8b 4D E8 48 8B 45 E8 48 8B 00 FF ?? ?? ?? ?? ?? 83 7D F0 01
local addr_DecodeFunction       = "cheatengine-x86_64-SSE4-AVX2.exe+27F585"
local addr_ShallExecute         = "cheatengine-x86_64-SSE4-AVX2.exe+272B56"
local addr_CreateProcess        = "cheatengine-x86_64-SSE4-AVX2.exe+2682CD"

return{
Opcode 	= 	addr_Opcode,
LOADK       =   addr_Opcode_LOADK,
EQ        	= 	addr_Opcode_EQ,
GETTABUP 	=	addr_Opcode_GETTABUP,

Load 			= 	addr_Load,
AutoAssemble 	=	addr_AutoAssemble,
DecodeFunction 	= 	addr_DecodeFunction,
ShallExecute 	= 	addr_ShallExecute,
CreateProcess 	= 	addr_CreateProcess

}