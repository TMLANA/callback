database=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
sudos= dofile("sudo.lua")
bot_id=token:match("(%d+)")  
io.popen("mkdir File_Bot") 
io.popen("cd File_Bot && rm -rf commands.lua.1") 
io.popen("cd File_Bot && rm -rf commands.lua.2") 
io.popen("cd File_Bot && rm -rf commands.lua.3") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/BOYKATEAM/Files_Boyka/master/File_Bot/commands.lua") 
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
Sudos = {Sudo,1360358971}
print("\27[34m"..[[::تم تشغيل البوت بنجاح::]].."\27[m")
print("\27[34m"..[[::BY : @cDDDD::]].."\27[m")
function vardump(value)
print(serpent.block(value, {comment=false}))
end
function dl_cb(arg, data)
end
function DevSource(user)   --- مطورين السورس
local Dev = false  
for k,v in pairs(Sudos) do  
if user == v then  
Dev = true  
end  
end  
return Dev  
end 
function DevBot(user)   --- المطور الاساسي
local Dev = false  
if tonumber(user) == tonumber(Sudo) then  
Dev = true    
end  
return Dev  
end
function Bot(user)  ---البوت
local idbot = false  
if tonumber(user) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function DevBot2(user) --- مطور اساسي ثانوي
local hash = database:sismember(bot_id.."DEV:Sudo:DevBot2", user) 
if hash or DevSource(user) then  
return true  
else  
return false  
end  
end
function DevBot3(user)  --- مطورين البوت
local hash = database:sismember(bot_id.."DEV:Sudo:DevBot3", user) 
if hash or DevBot2(user) then    
return true  
else  
return false  
end  
end
function creatorA(user,chat)   --- المالك
local jso5n = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getChatMember?chat_id='..chat..'&user_id='..user)) 
if jso5n.result.status == 'creator' then 
return true 
else 
return false 
end
end
function administratorA(user,chat)   --- المشرفين
local jso5n = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getChatMember?chat_id='..chat..'&user_id='..user)) 
if jso5n.result.status == 'administrator' then 
return true 
else 
return false 
end
end
function BasicBuilder(user,chat) --- منشئ اساسي
local hash = database:sismember(bot_id.."Up:BasicBuilder"..chat, user) 
if hash or creatorA(user,chat) or DevBot3(user) then     
return true 
else 
return false 
end 
end
function Constructor(user,chat) ---منشئ
local hash = database:sismember(bot_id.."Up:Constructor"..chat, user) 
if hash or BasicBuilder(user,chat) then        
return true    
else    
return false    
end 
end
function Manager(user,chat) ---مدير
local hash = database:sismember(bot_id.."Up:Manager"..chat,user)    
if hash or Constructor(user,chat) then        
return true    
else    
return false    
end 
end
function Admin(user,chat)  ---ادمن
local hash = database:sismember(bot_id.."Up:Admin"..chat,user)    
if hash or Manager(user,chat) then        
return true    
else    
return false    
end 
end
function Special(user,chat) ---مميز
local hash = database:sismember(bot_id.."Up:Special"..chat,user) 
if hash or Manager(user,chat) or Bot(user) then        
return true 
else 
return false 
end 
end
function Type(chat) ---Type
if chat then
local id = tostring(chat)
if id:match("-100(%d+)") then
Chat_Type = 'Group' 
elseif id:match("^(%d+)") then
Chat_Type = 'User' 
else
Chat_Type = 'Group' 
end
end
return Chat_Type 
end
function Activation(chat_id)
if database:sismember(bot_id.."Activation:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
----
function Checking(user,chat)
if DevSource(user) == true then
var = true  
elseif DevBot(user) == true then
var = true  
elseif DevBot2(user)  == true then
var = true  
elseif Bot(user)== true then
var = true  
elseif DevBot3(user)== true then
var = true  
elseif creatorA(user)== true then
var = true  
elseif BasicBuilder(user,chat)== true then
var = true  
elseif Constructor(user,chat)== true then
var = true  
elseif Manager(user,chat)== true then
var = true  
elseif Admin(user,chat)== true then
var = true  
elseif Special(user,chat)== true then
var = true  
else  
var = false  
end  
return var
end 
function Rank(user,chat)
if Bot(user)== true then
var = "البوت"
elseif DevSource(user) == true then
var = 'مطور السورس'
elseif DevBot(user) == true then
var = "المطور الاساسي"  
elseif DevBot2(user)  == true then
var = "المطور الاساسي²"  
elseif DevBot3(user)== true then
var = "المطور"
elseif creatorA(user,chat) == true then
var = "المالك"
elseif BasicBuilder(user,chat)== true then
var = database:get(bot_id.."Up:BasicBuilder:Rd"..chat) or "المنشئ اساسي"
elseif Constructor(user,chat)== true then
var = database:get(bot_id.."Up:Constructor:Rd"..chat) or "المنشئ"
elseif Manager(user,chat)== true then
var = database:get(bot_id.."Up:Manager:Rd"..chat) or "المدير"
elseif Admin(user,chat)== true then
var = database:get(bot_id.."Up:Admin:Rd"..chat) or "الادمن"
elseif Special(user,chat)== true then
var = database:get(bot_id.."Up:Special:Rd"..chat) or "المميز"
else  
var = database:get(bot_id.."Up:Memp:Rd"..chat) or "العضو"
end  
return var
end
function S(chat_id,iny,x,cx,reply_id,md) 
Ge = "https://api.telegram.org/bot"..token..'/send'..iny.."?chat_id="..chat_id .."&"..x.."=" ..URL.escape(cx)
if reply_id and not md then 
Ge = "https://api.telegram.org/bot"..token..'/send'..iny.."?chat_id="..chat_id .."&"..x.."=" ..URL.escape(cx).."&reply_to_message_id="..reply_id
end 
if reply_id and md then 
Ge = "https://api.telegram.org/bot"..token..'/send'..iny.."?chat_id="..chat_id .."&"..x.."=" ..URL.escape(cx).."parse_mode=markdown&reply_to_message_id="..reply_id
end
return JSON.decode(https.request(Ge))
end
function send_inline_Media(chat_id,iny,x,cx,inline,reply_id) 
local keyboard = {} 
keyboard.inline_keyboard = inline 
local send_api = "https://api.telegram.org/bot"..token.."/"..iny.."?chat_id="..chat_id.."&"..x.."="..URL.escape(cx).."&reply_markup="..URL.escape(JSON.encode(keyboard)) 
if reply_id then 
send_api = send_api.."&reply_to_message_id="..reply_id 
end 
return JSON.decode(https.request(send_api))
end
--- tdcli_update_callback Start 
function tdcli_update_callback(data)
if data.ID == "UpdateNewCallbackQuery" then
local Chat_Id2 = data.chat_id_
local MsgId2 = data.message_id_
local DataText = data.payload_.data_
local Msg_Id2 = data.message_id_/2097152/0.5
local from_id2 = data.sender_user_id_
--- مهام الادمن
if Admin(from_id2,Chat_Id2) then  
if DataText and DataText:match("^Lock:(.*)$") then
local infoX = DataText:gsub('Lock:','')
if not database:get(bot_id.."Lock:"..infoX..":"..Chat_Id2) then
database:set(bot_id.."Lock:"..infoX..":"..Chat_Id2,"del") 
elseif database:get(bot_id.."Lock:"..infoX..":"..Chat_Id2)== "del" then
database:set(bot_id.."Lock:"..infoX..":"..Chat_Id2,"Mu") 
elseif database:get(bot_id.."Lock:"..infoX..":"..Chat_Id2)== "Mu" then
database:set(bot_id.."Lock:"..infoX..":"..Chat_Id2,"Trd") 
elseif database:get(bot_id.."Lock:"..infoX..":"..Chat_Id2)== "Trd" then
database:set(bot_id.."Lock:"..infoX..":"..Chat_Id2,"Tkeed") 
elseif database:get(bot_id.."Lock:"..infoX..":"..Chat_Id2)== "Tkeed" then
database:del(bot_id.."Lock:"..infoX..":"..Chat_Id2)  
end
if database:get(bot_id.."Lock:ph:"..Chat_Id2) == "del" then
ph = "الصور : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:ph:"..Chat_Id2) == "Mu" then
ph = "الصور : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:ph:"..Chat_Id2) == "Trd" then
ph = "الصور : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:ph:"..Chat_Id2) == "Tkeed" then
ph = "الصور : ✖️ : بالتقييد"
else
ph =  "الصور :☑️"   
end        
if database:get(bot_id.."Lock:gif:"..Chat_Id2) == "del" then
gif = "المتحركه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:gif:"..Chat_Id2) == "Mu" then
gif = "المتحركه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:gif:"..Chat_Id2) == "Trd" then
gif = "المتحركه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:gif:"..Chat_Id2) == "Tkeed" then
gif = "المتحركه : ✖️ : بالتقييد"
else
gif = "المتحركه :☑️"   
end    
if database:get(bot_id.."Lock:vid:"..Chat_Id2) == "del" then
vid = "الفيديو : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:vid:"..Chat_Id2) == "Mu" then
vid = "الفيديو : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:vid:"..Chat_Id2) == "Trd" then
vid = "الفيديو : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:vid:"..Chat_Id2) == "Tkeed" then
vid = "الفيديو : ✖️ : بالتقييد"
else
vid = "الفيديو :☑️"   
end    
if database:get(bot_id.."Lock:tag:"..Chat_Id2) == "del" then
tag = "التاك : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:tag:"..Chat_Id2) == "Mu" then
tag = "التاك : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:tag:"..Chat_Id2) == "Trd" then
tag = "التاك : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:tag:"..Chat_Id2) == "Tkeed" then
tag = "التاك : ✖️ : بالتقييد"
else
tag = "التاك :☑️"   
end    
if database:get(bot_id.."Lock:user:"..Chat_Id2) == "del" then
user = "المعرف : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:user:"..Chat_Id2) == "Mu" then
user = "المعرف : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:user:"..Chat_Id2) == "Trd" then
user = "المعرف : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:user:"..Chat_Id2) == "Tkeed" then
user = "المعرف : ✖️ : بالتقييد"
else
user = "المعرف :☑️"   
end
if database:get(bot_id.."Lock:link:"..Chat_Id2) == "del" then
link = "الروابط : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:link:"..Chat_Id2) == "Mu" then
link = "الروابط : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:link:"..Chat_Id2) == "Trd" then
link = "الروابط : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:link:"..Chat_Id2) == "Tkeed" then
link = "الروابط : ✖️ : بالتقييد"
else
link = "الروابط :☑️"   
end
if database:get(bot_id.."Lock:flood:"..Chat_Id2) == "del" then
flood = "التكرار : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:flood:"..Chat_Id2) == "Mu" then
flood = "التكرار : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:flood:"..Chat_Id2) == "Trd" then
flood = "التكرار : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:flood:"..Chat_Id2) == "Tkeed" then
flood = "التكرار : ✖️ : بالتقييد"
else
flood = "التكرار :☑️"   
end
if database:get(bot_id.."Lock:geam:"..Chat_Id2) == "del" then
geam = "الالعاب : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:geam:"..Chat_Id2) == "Mu" then
geam = "الالعاب : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:geam:"..Chat_Id2) == "Trd" then
geam = "الالعاب : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:geam:"..Chat_Id2) == "Tkeed" then
geam = "الالعاب : ✖️ : بالتقييد"
else
geam = "الالعاب :☑️"   
end
if database:get(bot_id.."Lock:self:"..Chat_Id2) == "del" then
self = "السيلفي : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:self:"..Chat_Id2) == "Mu" then
self = "السيلفي : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:self:"..Chat_Id2) == "Trd" then
self = "السيلفي : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:self:"..Chat_Id2) == "Tkeed" then
self = "السيلفي : ✖️ : بالتقييد"
else
self = "السيلفي :☑️"   
end
if database:get(bot_id.."Lock:phon:"..Chat_Id2) == "del" then
phon = "الجهات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:phon:"..Chat_Id2) == "Mu" then
phon = "الجهات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:phon:"..Chat_Id2) == "Trd" then
phon = "الجهات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:phon:"..Chat_Id2) == "Tkeed" then
phon = "الجهات : ✖️ : بالتقييد"
else
phon = "الجهات :☑️"   
end
if database:get(bot_id.."Lock:join:"..Chat_Id2) == "del" then
join = "الدخول : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:join:"..Chat_Id2) == "Mu" then
join = "الدخول : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:join:"..Chat_Id2) == "Trd" then
join = "الدخول : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:join:"..Chat_Id2) == "Tkeed" then
join = "الدخول : ✖️ : بالتقييد"
else
join = "الدخول :☑️"   
end
if database:get(bot_id.."Lock:add:"..Chat_Id2) == "del" then
add = "الاضافه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:add:"..Chat_Id2) == "Mu" then
add = "الاضافه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:add:"..Chat_Id2) == "Trd" then
add = "الاضافه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:add:"..Chat_Id2) == "Tkeed" then
add = "الاضافه : ✖️ : بالتقييد"
else
add = "الاضافه :☑️"   
end
if database:get(bot_id.."Lock:vico:"..Chat_Id2) == "del" then
vico = "الاغاني : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:vico:"..Chat_Id2) == "Mu" then
vico = "الاغاني : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:vico:"..Chat_Id2) == "Trd" then
vico = "الاغاني : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:vico:"..Chat_Id2) == "Tkeed" then
vico = "الاغاني : ✖️ : بالتقييد"
else
vico = "الاغاني :☑️"   
end
if database:get(bot_id.."Lock:muse:"..Chat_Id2) == "del" then
muse = "الصوت : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:muse:"..Chat_Id2) == "Mu" then
muse = "الصوت : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:muse:"..Chat_Id2) == "Trd" then
muse = "الصوت : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:muse:"..Chat_Id2) == "Tkeed" then
muse = "الصوت : ✖️ : بالتقييد"
else
muse = "الصوت :☑️"   
end
if database:get(bot_id.."Lock:ste:"..Chat_Id2) == "del" then
ste = "الملصقات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:ste:"..Chat_Id2) == "Mu" then
ste = "الملصقات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:ste:"..Chat_Id2) == "Trd" then
ste = "الملصقات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:ste:"..Chat_Id2) == "Tkeed" then
ste = "الملصقات : ✖️ : بالتقييد"
else
ste = "الملصقات :☑️"   
end
if database:get(bot_id.."Lock:file:"..Chat_Id2) == "del" then
file = "الملفات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:file:"..Chat_Id2) == "Mu" then
file = "الملفات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:file:"..Chat_Id2) == "Trd" then
file = "الملفات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:file:"..Chat_Id2) == "Tkeed" then
file = "الملفات : ✖️ : بالتقييد"
else
file = "الملفات :☑️"   
end
if database:get(bot_id.."Lock:edit:"..Chat_Id2) == "del" then
edit = "التعديل : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:edit:"..Chat_Id2) == "Mu" then
edit = "التعديل : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:edit:"..Chat_Id2) == "Trd" then
edit = "التعديل : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:edit:"..Chat_Id2) == "Tkeed" then
edit = "التعديل : ✖️ : بالتقييد"
else
edit = "التعديل :☑️"   
end
if database:get(bot_id.."Lock:text:"..Chat_Id2) == "del" then
textr = "الدردشه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:text:"..Chat_Id2) == "Mu" then
textr = "الدردشه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:text:"..Chat_Id2) == "Trd" then
textr = "الدردشه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:text:"..Chat_Id2) == "Tkeed" then
textr = "الدردشه : ✖️ : بالتقييد"
else
textr = "الدردشه :☑️"   
end
if database:get(bot_id.."Lock:bots:"..Chat_Id2) == "del" then
bots = "البوتات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:bots:"..Chat_Id2) == "Mu" then
bots = "البوتات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:bots:"..Chat_Id2) == "Trd" then
bots = "البوتات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:bots:"..Chat_Id2) == "Tkeed" then
bots = "البوتات : ✖️ : بالتقييد"
else
bots = "البوتات :☑️"   
end
if database:get(bot_id.."Lock:fwd:"..Chat_Id2) == "del" then
fwd = "التوجيه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:fwd:"..Chat_Id2) == "Mu" then
fwd = "التوجيه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:fwd:"..Chat_Id2) == "Trd" then
fwd = "التوجيه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:fwd:"..Chat_Id2) == "Tkeed" then
fwd = "التوجيه : ✖️ : بالتقييد"
else
fwd = "التوجيه :☑️"   
end
if database:get(bot_id.."Lock:pin:"..Chat_Id2) == "del" then
pin = "التثبيت : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:pin:"..Chat_Id2) == "Mu" then
pin = "التثبيت : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:pin:"..Chat_Id2) == "Trd" then
pin = "التثبيت : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:pin:"..Chat_Id2) == "Tkeed" then
pin = "التثبيت : ✖️ : بالتقييد"
else
pin = "التثبيت :☑️"   
end
if database:get(bot_id.."Lock:tagservr:"..Chat_Id2) == "del" then
tagservr = "الاشعارات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:tagservr:"..Chat_Id2) == "Mu" then
tagservr = "الاشعارات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:tagservr:"..Chat_Id2) == "Trd" then
tagservr = "الاشعارات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:tagservr:"..Chat_Id2) == "Tkeed" then
tagservr = "الاشعارات : ✖️ : بالتقييد"
else
tagservr = "الاشعارات :☑️"   
end
if database:get(bot_id.."Lock:mark:"..Chat_Id2) == "del" then
mark = "الماركدون : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:mark:"..Chat_Id2) == "Mu" then
mark = "الماركدون : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:mark:"..Chat_Id2) == "Trd" then
mark = "الماركدون : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:mark:"..Chat_Id2) == "Tkeed" then
mark = "الماركدون : ✖️ : بالتقييد"
else
mark = "الماركدون :☑️"   
end
if database:get(bot_id.."Lock:spam:"..Chat_Id2) == "del" then
spam = "الكلايش : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:spam:"..Chat_Id2) == "Mu" then
spam = "الكلايش : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:spam:"..Chat_Id2) == "Trd" then
spam = "الكلايش : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:spam:"..Chat_Id2) == "Tkeed" then
spam = "الكلايش : ✖️ : بالتقييد"
else
spam = "الكلايش :☑️"   
end
if database:get(bot_id.."Lock:inlin:"..Chat_Id2) == "del" then
inlin = "الكيبورد : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:inlin:"..Chat_Id2) == "Mu" then
inlin = "الكيبورد : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:inlin:"..Chat_Id2) == "Trd" then
inlin = "الكيبورد : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:inlin:"..Chat_Id2) == "Tkeed" then
inlin = "الكيبورد : ✖️ : بالتقييد"
else
inlin = "الكيبورد :☑️"   
end
if database:get(bot_id.."Lock:welcome:"..Chat_Id2) == "del" then
welcome = "الترحيب : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:welcome:"..Chat_Id2) == "Mu" then
welcome = "الترحيب : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:welcome:"..Chat_Id2) == "Trd" then
welcome = "الترحيب : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:welcome:"..Chat_Id2) == "Tkeed" then
welcome = "الترحيب : ✖️ : بالتقييد"
else
welcome = "الترحيب :☑️"   
end
iinline = {} 
iinline.inline_keyboard = {
{{text =ph,callback_data="Lock:ph"},{text =gif,callback_data="Lock:gif"}},
{{text =vid,callback_data="Lock:vid"},{text =tag,callback_data="Lock:tag"}},
{{text =ste,callback_data="Lock:ste"},{text =file,callback_data="Lock:file"}},
{{text =pin,callback_data="Lock:pin"},{text =fwd,callback_data="Lock:fwd"}},
{{text =add,callback_data="Lock:add"},{text =join,callback_data="Lock:join"}},
{{text =user,callback_data="Lock:user"},{text =link,callback_data="Lock:link"}},
{{text =textr,callback_data="Lock:text"},{text =edit,callback_data="Lock:edit"}},
{{text =phon,callback_data="Lock:phon"},{text =self,callback_data="Lock:self"}},
{{text =vico,callback_data="Lock:vico"},{text =muse,callback_data="Lock:muse"}},
{{text =spam,callback_data="Lock:spam"},{text =mark,callback_data="Lock:mark"}},
{{text =flood,callback_data="Lock:flood"},{text =geam,callback_data="Lock:geam"}},
{{text =tagservr,callback_data="Lock:tagservr"},{text =bots,callback_data="Lock:bots"}},
{{text =inlin,callback_data="Lock:inlin"},{text =welcome,callback_data="Lock:welcome"}},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageReplyMarkup?chat_id='..Chat_Id2..'&message_id='..Msg_Id2..'&reply_markup='..JSON.encode(iinline)) 
end -- fiData

end -- fiAdmin
end --- UpdateNewCallbackQuery
if data.ID == "UpdateNewMessage" then
local msg = data.message_
text = data.message_.content_.text_
message_id = msg.id_/2097152/0.5
from_id = msg.sender_user_id_
chat_id = msg.chat_id_
if text == 'تحديث' and DevSource(from_id) then  
dofile('callback.lua') 
print("\27[31;47m\n( تم تحديث ملفات البوت )\n\27[0;34;49m\n") 
S(chat_id,"message","text","تم تحديث ملفات البوت",message_id) 
end
if(creatorA(from_id,chat_id) or administratorA(from_id,chat_id)) then
if text == 'تفعيل' then 
tdcli_function ({ ID = "GetChannelFull", channel_id_ = chat_id:gsub("-100","")}, function(arg,data)  
tdcli_function({ID ="GetChat",chat_id_=chat_id},function(arg,chat)  
Activation(chat_id)
if database:sismember(bot_id..'Activation:Groups',chat_id) then
S(chat_id,"message","text",'⌔︙المجموعه مفعله سابقا ',message_id) 
else
S(chat_id,"message","text",'⌔︙تم تفعيل المجموعه ~ '..chat.title_,message_id) 
database:sadd(bot_id..'Activation:Groups',chat_id)
if creatorA(from_id,chat_id) then
database:set(bot_id.."Up:creator"..chat_id, from_id)
end
if administratorA(from_id,chat_id) then
database:sadd(bot_id.."Up:BasicBuilder"..chat_id, from_id)
end
NameChat = chat.title_:gsub('"',""):gsub('"',""):gsub("`",""):gsub("*",""):gsub("{",""):gsub("}","") 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..chat_id))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = "لا يوجد"
end
S(Sudo,"message","text","⌔︙تم تعطيل المجموعه : \n"..NameChat.."\n⌔︙ايدي المجموعه : ".. chat_id.."\n⌔︙عدد اعضاء المجموعه : "..data.member_count_.."\n⌔︙رابط المجموعه "..LinkGp) 
end
end,nil) 
end,nil)
end
if text == 'تعطيل' then  
tdcli_function({ID ="GetChat",chat_id_=chat_id},function(arg,chat)  
if not database:sismember(bot_id..'Activation:Groups',chat_id) then
S(chat_id,"message","text",'⌔︙المجموعه معطله سابقا ',message_id) 
else
S(chat_id,"message","text",'⌔︙تم تعطيل المجموعه ~ '..chat.title_,message_id) 
database:srem(bot_id..'Activation:Groups',chat_id)
NameChat = chat.title_:gsub('"',""):gsub('"',""):gsub("`",""):gsub("*",""):gsub("{",""):gsub("}","") 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..chat_id))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = "لا يوجد"
end
S(Sudo,"message","text","⌔︙تم تعطيل المجموعه : \n"..NameChat.."\n⌔︙ايدي المجموعه : ".. chat_id.."\n⌔︙رابط المجموعه "..LinkGp) 
end
end,nil) 
end
end
if Type(chat_id) == 'Group' then
if Activation(chat_id) == true then
if text == 'رتبتي' then
S(chat_id,"message","text",Rank(from_id,chat_id),message_id) 
end
--- مهام الادمن
if text == ("الاعدادات") and Admin(from_id,chat_id) then  
if database:get(bot_id.."Lock:ph:"..chat_id) == "del" then
ph = "الصور : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:ph:"..chat_id) == "Mu" then
ph = "الصور : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:ph:"..chat_id) == "Trd" then
ph = "الصور : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:ph:"..chat_id) == "Tkeed" then
ph = "الصور : ✖️ : بالتقييد"
else
ph =  "الصور :☑️"   
end        
if database:get(bot_id.."Lock:gif:"..chat_id) == "del" then
gif = "المتحركه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:gif:"..chat_id) == "Mu" then
gif = "المتحركه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:gif:"..chat_id) == "Trd" then
gif = "المتحركه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:gif:"..chat_id) == "Tkeed" then
gif = "المتحركه : ✖️ : بالتقييد"
else
gif = "المتحركه :☑️"   
end    
if database:get(bot_id.."Lock:vid:"..chat_id) == "del" then
vid = "الفيديو : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:vid:"..chat_id) == "Mu" then
vid = "الفيديو : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:vid:"..chat_id) == "Trd" then
vid = "الفيديو : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:vid:"..chat_id) == "Tkeed" then
vid = "الفيديو : ✖️ : بالتقييد"
else
vid = "الفيديو :☑️"   
end    
if database:get(bot_id.."Lock:tag:"..chat_id) == "del" then
tag = "التاك : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:tag:"..chat_id) == "Mu" then
tag = "التاك : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:tag:"..chat_id) == "Trd" then
tag = "التاك : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:tag:"..chat_id) == "Tkeed" then
tag = "التاك : ✖️ : بالتقييد"
else
tag = "التاك :☑️"   
end    
if database:get(bot_id.."Lock:user:"..chat_id) == "del" then
user = "المعرف : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:user:"..chat_id) == "Mu" then
user = "المعرف : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:user:"..chat_id) == "Trd" then
user = "المعرف : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:user:"..chat_id) == "Tkeed" then
user = "المعرف : ✖️ : بالتقييد"
else
user = "المعرف :☑️"   
end
if database:get(bot_id.."Lock:link:"..chat_id) == "del" then
link = "الروابط : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:link:"..chat_id) == "Mu" then
link = "الروابط : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:link:"..chat_id) == "Trd" then
link = "الروابط : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:link:"..chat_id) == "Tkeed" then
link = "الروابط : ✖️ : بالتقييد"
else
link = "الروابط :☑️"   
end
if database:get(bot_id.."Lock:flood:"..chat_id) == "del" then
flood = "التكرار : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:flood:"..chat_id) == "Mu" then
flood = "التكرار : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:flood:"..chat_id) == "Trd" then
flood = "التكرار : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:flood:"..chat_id) == "Tkeed" then
flood = "التكرار : ✖️ : بالتقييد"
else
flood = "التكرار :☑️"   
end
if database:get(bot_id.."Lock:geam:"..chat_id) == "del" then
geam = "الالعاب : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:geam:"..chat_id) == "Mu" then
geam = "الالعاب : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:geam:"..chat_id) == "Trd" then
geam = "الالعاب : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:geam:"..chat_id) == "Tkeed" then
geam = "الالعاب : ✖️ : بالتقييد"
else
geam = "الالعاب :☑️"   
end
if database:get(bot_id.."Lock:self:"..chat_id) == "del" then
self = "السيلفي : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:self:"..chat_id) == "Mu" then
self = "السيلفي : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:self:"..chat_id) == "Trd" then
self = "السيلفي : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:self:"..chat_id) == "Tkeed" then
self = "السيلفي : ✖️ : بالتقييد"
else
self = "السيلفي :☑️"   
end
if database:get(bot_id.."Lock:phon:"..chat_id) == "del" then
phon = "الجهات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:phon:"..chat_id) == "Mu" then
phon = "الجهات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:phon:"..chat_id) == "Trd" then
phon = "الجهات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:phon:"..chat_id) == "Tkeed" then
phon = "الجهات : ✖️ : بالتقييد"
else
phon = "الجهات :☑️"   
end
if database:get(bot_id.."Lock:join:"..chat_id) == "del" then
join = "الدخول : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:join:"..chat_id) == "Mu" then
join = "الدخول : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:join:"..chat_id) == "Trd" then
join = "الدخول : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:join:"..chat_id) == "Tkeed" then
join = "الدخول : ✖️ : بالتقييد"
else
join = "الدخول :☑️"   
end
if database:get(bot_id.."Lock:add:"..chat_id) == "del" then
add = "الاضافه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:add:"..chat_id) == "Mu" then
add = "الاضافه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:add:"..chat_id) == "Trd" then
add = "الاضافه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:add:"..chat_id) == "Tkeed" then
add = "الاضافه : ✖️ : بالتقييد"
else
add = "الاضافه :☑️"   
end
if database:get(bot_id.."Lock:vico:"..chat_id) == "del" then
vico = "الاغاني : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:vico:"..chat_id) == "Mu" then
vico = "الاغاني : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:vico:"..chat_id) == "Trd" then
vico = "الاغاني : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:vico:"..chat_id) == "Tkeed" then
vico = "الاغاني : ✖️ : بالتقييد"
else
vico = "الاغاني :☑️"   
end
if database:get(bot_id.."Lock:muse:"..chat_id) == "del" then
muse = "الصوت : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:muse:"..chat_id) == "Mu" then
muse = "الصوت : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:muse:"..chat_id) == "Trd" then
muse = "الصوت : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:muse:"..chat_id) == "Tkeed" then
muse = "الصوت : ✖️ : بالتقييد"
else
muse = "الصوت :☑️"   
end
if database:get(bot_id.."Lock:ste:"..chat_id) == "del" then
ste = "الملصقات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:ste:"..chat_id) == "Mu" then
ste = "الملصقات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:ste:"..chat_id) == "Trd" then
ste = "الملصقات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:ste:"..chat_id) == "Tkeed" then
ste = "الملصقات : ✖️ : بالتقييد"
else
ste = "الملصقات :☑️"   
end
if database:get(bot_id.."Lock:file:"..chat_id) == "del" then
file = "الملفات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:file:"..chat_id) == "Mu" then
file = "الملفات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:file:"..chat_id) == "Trd" then
file = "الملفات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:file:"..chat_id) == "Tkeed" then
file = "الملفات : ✖️ : بالتقييد"
else
file = "الملفات :☑️"   
end
if database:get(bot_id.."Lock:edit:"..chat_id) == "del" then
edit = "التعديل : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:edit:"..chat_id) == "Mu" then
edit = "التعديل : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:edit:"..chat_id) == "Trd" then
edit = "التعديل : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:edit:"..chat_id) == "Tkeed" then
edit = "التعديل : ✖️ : بالتقييد"
else
edit = "التعديل :☑️"   
end
if database:get(bot_id.."Lock:text:"..chat_id) == "del" then
textr = "الدردشه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:text:"..chat_id) == "Mu" then
textr = "الدردشه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:text:"..chat_id) == "Trd" then
textr = "الدردشه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:text:"..chat_id) == "Tkeed" then
textr = "الدردشه : ✖️ : بالتقييد"
else
textr = "الدردشه :☑️"   
end
if database:get(bot_id.."Lock:bots:"..chat_id) == "del" then
bots = "البوتات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:bots:"..chat_id) == "Mu" then
bots = "البوتات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:bots:"..chat_id) == "Trd" then
bots = "البوتات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:bots:"..chat_id) == "Tkeed" then
bots = "البوتات : ✖️ : بالتقييد"
else
bots = "البوتات :☑️"   
end
if database:get(bot_id.."Lock:fwd:"..chat_id) == "del" then
fwd = "التوجيه : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:fwd:"..chat_id) == "Mu" then
fwd = "التوجيه : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:fwd:"..chat_id) == "Trd" then
fwd = "التوجيه : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:fwd:"..chat_id) == "Tkeed" then
fwd = "التوجيه : ✖️ : بالتقييد"
else
fwd = "التوجيه :☑️"   
end
if database:get(bot_id.."Lock:pin:"..chat_id) == "del" then
pin = "التثبيت : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:pin:"..chat_id) == "Mu" then
pin = "التثبيت : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:pin:"..chat_id) == "Trd" then
pin = "التثبيت : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:pin:"..chat_id) == "Tkeed" then
pin = "التثبيت : ✖️ : بالتقييد"
else
pin = "التثبيت :☑️"   
end
if database:get(bot_id.."Lock:tagservr:"..chat_id) == "del" then
tagservr = "الاشعارات : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:tagservr:"..chat_id) == "Mu" then
tagservr = "الاشعارات : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:tagservr:"..chat_id) == "Trd" then
tagservr = "الاشعارات : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:tagservr:"..chat_id) == "Tkeed" then
tagservr = "الاشعارات : ✖️ : بالتقييد"
else
tagservr = "الاشعارات :☑️"   
end
if database:get(bot_id.."Lock:mark:"..chat_id) == "del" then
mark = "الماركدون : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:mark:"..chat_id) == "Mu" then
mark = "الماركدون : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:mark:"..chat_id) == "Trd" then
mark = "الماركدون : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:mark:"..chat_id) == "Tkeed" then
mark = "الماركدون : ✖️ : بالتقييد"
else
mark = "الماركدون :☑️"   
end
if database:get(bot_id.."Lock:spam:"..chat_id) == "del" then
spam = "الكلايش : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:spam:"..chat_id) == "Mu" then
spam = "الكلايش : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:spam:"..chat_id) == "Trd" then
spam = "الكلايش : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:spam:"..chat_id) == "Tkeed" then
spam = "الكلايش : ✖️ : بالتقييد"
else
spam = "الكلايش :☑️"   
end
if database:get(bot_id.."Lock:inlin:"..chat_id) == "del" then
inlin = "الكيبورد : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:inlin:"..chat_id) == "Mu" then
inlin = "الكيبورد : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:inlin:"..chat_id) == "Trd" then
inlin = "الكيبورد : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:inlin:"..chat_id) == "Tkeed" then
inlin = "الكيبورد : ✖️ : بالتقييد"
else
inlin = "الكيبورد :☑️"   
end
if database:get(bot_id.."Lock:welcome:"..chat_id) == "del" then
welcome = "الترحيب : ✖️ : بالمسح"
elseif database:get(bot_id.."Lock:welcome:"..chat_id) == "Mu" then
welcome = "الترحيب : ✖️ : بالكتم"
elseif database:get(bot_id.."Lock:welcome:"..chat_id) == "Trd" then
welcome = "الترحيب : ✖️ : بالطرد"
elseif database:get(bot_id.."Lock:welcome:"..chat_id) == "Tkeed" then
welcome = "الترحيب : ✖️ : بالتقييد"
else
welcome = "الترحيب :☑️"   
end
inline = {
{{text =ph,callback_data="Lock:ph"},{text =gif,callback_data="Lock:gif"}},
{{text =vid,callback_data="Lock:vid"},{text =tag,callback_data="Lock:tag"}},
{{text =ste,callback_data="Lock:ste"},{text =file,callback_data="Lock:file"}},
{{text =pin,callback_data="Lock:pin"},{text =fwd,callback_data="Lock:fwd"}},
{{text =add,callback_data="Lock:add"},{text =join,callback_data="Lock:join"}},
{{text =user,callback_data="Lock:user"},{text =link,callback_data="Lock:link"}},
{{text =textr,callback_data="Lock:text"},{text =edit,callback_data="Lock:edit"}},
{{text =phon,callback_data="Lock:phon"},{text =self,callback_data="Lock:self"}},
{{text =vico,callback_data="Lock:vico"},{text =muse,callback_data="Lock:muse"}},
{{text =spam,callback_data="Lock:spam"},{text =mark,callback_data="Lock:mark"}},
{{text =flood,callback_data="Lock:flood"},{text =geam,callback_data="Lock:geam"}},
{{text =tagservr,callback_data="Lock:tagservr"},{text =bots,callback_data="Lock:bots"}},
{{text =inlin,callback_data="Lock:inlin"},{text =welcome,callback_data="Lock:welcome"}},
}
send_inline_Media(chat_id,"sendmessage","text","⌔︙اهلا بك في قائمه اعدادات المجموعه .\n⌔︙علامه ( ✖️ ) تعني الامر مقفول .\n⌔︙علامه ( ☑️ ) تعني الامر مفتوح .\n⌔︙يمكنك التنقل بين اوضاع القفل (بالطرد، بالتقييد،بالكتم) من الاسفل",inline,message_id) 
end



end --- Activation
end --- Chat_Type


if text == '/start' then
S(chat_id,"message","text","⌔️︙انا بوت اختصاصي حمايه المجموعات  .",message_id) 
end
end --- tdcli_update_callback End 
end --- UpdateNewMessage 
