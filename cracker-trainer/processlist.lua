local form = processForm
local list    = form.processList
local process = {}

local function open()
   form.show()
end

local function clear()
   list.items.clear()
end

local function update()
   clear()
   local sl = createStringlist()
   getProcesslist(sl)

   for i=0, strings_getCount(sl)-1 do
      local entry = sl[i]
      local processname = entry:sub(10,255)
      local pid = tonumber('0x'..entry:sub(1,8))
      process[i] = {pid, processname}
   end

   local idx = 0
   for i in pairs(process) do
      idx = idx+1
   end

   for i=0, idx-1 do
      if process[i] ~= "" and process[i] ~= nil then
         list.items.add(process[i][1].."  ".. process[i][2])
      end
   end
   list.TopIndex = idx-1
end

function form.OnClose()
   form.hide()
end

function form.processList.OnDblClick()
   local pid = list.ItemIndex
   if pid ~= -1 then
      if process[pid][1] ~= nil then
         openProcess(process[pid][1])
         debugProcess()
         form.hide()
      else
         error("Failed to open the select process")
      end
   else
      error("Please choose a process from the list")
   end
end


return {
open = open,
update = update,


}
