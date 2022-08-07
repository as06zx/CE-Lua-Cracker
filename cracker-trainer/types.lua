local t={
[-1] = "NONE",
[0]  = "NIL",
"BOOLEAN",
"LIGHTUSERDATA",
"NUMBER",
"STRING",
"TABLE",
"FUNCTION",
"USERDATA",
"THREAD",
"NUMTAGS",

------ i added variant tags here because no want to add new files for that right now ---
--- numbers ---
[19] = "NUMINT", -- NUMFLT is still 3

--- strings ---
[20] = "LNGSTR", -- SHRSTR is still 4

--- functions ---
[22] = "TLCF", -- light C function
[38] = "TCCL", -- regular C function (closure)

--- i dont know but memory teached me ---
[68] = "STRING2",
[84] = "LNGSTR2",
}

return t
