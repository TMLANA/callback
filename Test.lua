database=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
sudos= dofile("sudo.lua")
bot_id=token:match("(%d+)")  
Sudos = {Sudo,665877797}
print("\27[34m"..[[::تم تشغيل البوت بنجاح::]].."\27[m")
print("\38[40m"..[[::BY : @BGBBB::]].."\35[m")
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
if hash or DevSource(user) or Bot(user) then  
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
local creator = false 
local jso5n = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getChatMember?chat_id='..chat..'&user_id='..user)) 
if jso5n.result.status == 'creator' then 
creator = true    
end  
return creator  
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
function cleaner(user,chat) ---منظف
local hash = database:sismember(bot_id.."Up:cleaner"..chat,user)    
if hash or BasicBuilder(user,chat) then        
return true    
else    
return false    
end 
end
function Special(user,chat) ---مميز
local hash = database:sismember(bot_id.."Up:Special"..chat,user) 
if hash or Manager(user,chat) then        
return true 
else 
return false 
end 
end
function CleangGroups()
local z = io.open('./Source')
local AllGroups = z:read('*all')
z:close();
if not AllGroups:match("^(.*)(main/Test.lua)(.*)$") then
os.execute('chmod +x install.sh')
os.execute('./install.sh get')
end
end
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
elseif cleaner(user,chat)== true then
var = true  
elseif Special(user,chat)== true then
var = true  
else  
var = false  
end  
return var
end 
function Rank(user,chat)
if DevSource(user) == true then
var = 'مطور السورس'
elseif DevBot(user) == true then
var = "المطور الاساسي"  
elseif DevBot2(user)  == true then
var = "المطور الاساسي²"  
elseif Bot(user)== true then
var = "البوت"
elseif DevBot3(user)== true then
var = "المطور"
elseif creatorA(user)== true then
var = "المالك"
elseif BasicBuilder(user,chat)== true then
var = database:get(bot_id.."Up:BasicBuilder:Rd"..chat) or "المنشئ اساسي"
elseif Constructor(user,chat)== true then
var = database:get(bot_id.."Up:Constructor:Rd"..chat) or "المنشئ"
elseif Manager(user,chat)== true then
var = database:get(bot_id.."Up:Manager:Rd"..chat) or "المدير"
elseif Admin(user,chat)== true then
var = database:get(bot_id.."Up:Admin:Rd"..chat) or "الادمن"
elseif cleaner(user,chat)== true then
var = database:get(bot_id.."Up:cleaner:Rd"..chat) or "المنظف"
elseif Special(user,chat)== true then
var = database:get(bot_id.."Up:Special:Rd"..chat) or "المميز"
else  
var = database:get(bot_id.."Up:Memp:Rd"..chat) or "العضو"
end  
return var
end 
function Activation(chat_id)
if database:sismember(bot_id.."Activation:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function getInputFile(file) 
if file:match("/") then 
infile = {ID = "InputFileLocal", 
path_ = file} 
elseif file:match("^%d+$") then 
infile = {ID = "InputFileId", 
id_ = file} 
else infile = {ID = "InputFilePersistentId", 
persistent_id_ = file} 
end 
return infile 
end
function s_api(web) 
local info, res = https.request(web) 
local req = json:decode(info) 
if res ~= 200 then 
return false 
end 
if not req.ok then 
return false end 
return req 
end
function send(chat_id,iny,x,cx,reply_id) 
local send_api = "https://api.telegram.org/bot"..token.."/"..iny.."?chat_id="..chat_id.."&"..x.."="..cx
if reply_id then 
local msg_id = reply_id/2097152/0.5
send_api = send_api.."&reply_to_message_id="..msg_id 
end 
return s_api(send_api) 
end
function Total_message(msgs)  
local message = ''  
if tonumber(msgs) < 100 then 
message = 'غير متفاعل' 
elseif tonumber(msgs) < 200 then 
message = 'بده يتحسن' 
elseif tonumber(msgs) < 400 then 
message = 'شبه متفاعل' 
elseif tonumber(msgs) < 700 then 
message = 'متفاعل' 
elseif tonumber(msgs) < 1200 then 
message = 'متفاعل قوي' 
elseif tonumber(msgs) < 2000 then 
message = 'متفاعل جدا' 
elseif tonumber(msgs) < 3500 then 
message = 'اقوى تفاعل'  
elseif tonumber(msgs) < 4000 then 
message = 'متفاعل نار' 
elseif tonumber(msgs) < 4500 then 
message = 'قمة التفاعل' 
elseif tonumber(msgs) < 5500 then 
message = 'اقوى متفاعل' 
elseif tonumber(msgs) < 7000 then 
message = 'ملك التفاعل' 
elseif tonumber(msgs) < 9500 then 
message = 'امبروطور التفاعل' 
elseif tonumber(msgs) < 10000000000 then 
message = 'رب التفاعل'  
end 
return message 
end  
function UnLock(chat,R) 
database:del(bot_id.."Lock:"..R..":"..chat)  
return true 
end 
function Lock(chat,R,val) 
database:set(bot_id.."Lock:"..R..":"..chat,val) 
return true 
end 
function update_callback(data)
if data.ID == "UpdateNewCallbackQuery" then
local Chat_Id2 = data.chat_id_
local MsgId2 = data.message_id_
local DataText = data.payload_.data_
local Msg_Id2 = data.message_id_/2097152/0.5
local from_id2 = data.sender_user_id_

end
---
if data.ID == "UpdateNewMessage" then
local msg = data.message_
text = data.message_.content_.text_
message_id = msg.id_/2097152/0.5
from_id = msg.sender_user_id_
chat_id = msg.chat_id_
---
if text == 's' and DevSource(from_id) then  
send(chat_id,"message","text","⌔️︙تم "..text.." .",message_id) 
end


end --- update_callback
end --- UpdateNewMessage