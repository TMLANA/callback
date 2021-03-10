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
io.popen("mkdir FilesBot")
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
function dl_cb(t,s)
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
local z = io.open('./Test')
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
local send_api = "https://api.telegram.org/bot"..token.."/"..iny.."?chat_id="..chat_id.."&"..x.."="..cx) 
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
function FilesBot(msg)
for v in io.popen('ls FilesBot'):lines() do
if v:match(".lua$") then
plugin = dofile("FilesBot/"..v)
if plugin.Test and msg then
pre_msg = plugin.Test(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end
function Started_Bot(msg,data) -- بداية العمل
if msg then
local msg = data.message_
local chat_id = msg.chat_id_
local text = msg.content_.text_
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'MessageUser'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'UsersBot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
function UnLock(chat,R) 
database:del(bot_id.."Lock:"..R..":"..chat)  
return true 
end 
function Lock(chat,R,val) 
database:set(bot_id.."Lock:"..R..":"..chat,val) 
return true 
end 
if Chat_Type == 'GroupBot' then
if Activation(msg.chat_id_) == true then
if text == "قفل الدردشه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"text","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الدردشه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"text","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الدردشه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"text","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"AddMempar","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاضافه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"AddMempar","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاضافه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"AddMempar","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Join","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الدخول بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Join","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الدخول بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Join","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Bot","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل البوتات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Bot","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل البوتات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Bot","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"tagservr","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاشعارات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"tagservr","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاشعارات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"tagservr","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل التثبيت" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"pin","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التثبيت بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"pin","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التثبيت بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"pin","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل التعديل" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"edit","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التعديل بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"edit","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التعديل بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"edit","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل تعديل الميديا" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"editMe","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل تعديل الميديا بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"editMe","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل تعديل الميديا بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"editMe","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل التكرار" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Repetition","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التكرار بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Repetition","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التكرار بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Repetition","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الصوت" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Voice","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الصوت بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Voice","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الصوت بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Voice","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكيبورد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Keyboard","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكيبورد بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Keyboard","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكيبورد بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Keyboard","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملصقات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Sticker","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملصقات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Sticker","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملصقات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Sticker","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التوجيه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"forward","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التوجيه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"forward","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التوجيه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"forward","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملفات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Document","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملفات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Document","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الملفات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Document","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل السيلفي" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Unsupported","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل السيلفي بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Unsupported","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل السيلفي بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Unsupported","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الماركداون" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Markdaun","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الماركداون بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Markdaun","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الماركداون بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Markdaun","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الجهات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Contact","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الجهات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Contact","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الجهات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Contact","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكلايش" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Spam","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكلايش بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Spam","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكلايش بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Spam","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الانلاين" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Inlen","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الانلاين بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Inlen","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الانلاين بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Inlen","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المعرفات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"UserName","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المعرفات بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"UserName","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المعرفات بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"UserName","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التاك" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"hashtak","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التاك بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"hashtak","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل التاك بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"hashtak","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الشارحه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Cmd","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الشارحه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Cmd","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الشارحه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Cmd","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل الصور" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Photo","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الصور بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Photo","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الصور بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Photo","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاباحي" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Xn","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاباحي بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Xn","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاباحي بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Xn","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفيديو" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Video","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفيديو بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Video","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفيديو بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Video","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المتحركه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Animation","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المتحركه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Animation","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل المتحركه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Animation","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الالعاب" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"geam","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الالعاب بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"geam","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الالعاب بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"geam","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاغاني" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Audio","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاغاني بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Audio","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الاغاني بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Audio","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل الفارسيه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fa","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفارسيه بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fa","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفارسيه بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fa","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end
if text == "قفل الفشار" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fshar","Del") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفشار بالكتم" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fshar","Mu") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الفشار بالتقييد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
Lock(msg.chat_id_,"Fshar","res") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "قفل الكل" and msg.reply_to_message_id_ == 0 and Constructor(msg.sender_user_id_) then  
list ={"Fa","Fshar","edit","editMe","tagservr","pin","Join","Bot","AddMempar","text","Cmd","Photo","Inlen","UserName","hashtak","Markdaun","Contact","Spam","forward","Document","Unsupported","Voice","Keyboard","Sticker","Repetition","text","Audio","geam","Video","Animation","Xn"}
for i,lock in pairs(list) do 
Lock(msg.chat_id_,lock,"del") 
end
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
--------------------------------------------------------------------------------------------------------------
if text == "فتح الدردشه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"text") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الاضافه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"AddMempar") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الدخول" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Join") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح البوتات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Bot") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الاشعارات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"tagservr") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح التثبيت" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"pin") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح التعديل" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"edit") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح تعديل الميديا" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"editMe") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح التكرار" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Repetition") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الصوت" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Voice") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الكيبورد" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Keyboard") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الملصقات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Sticker") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح التوجيه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"forward") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الملفات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Document") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح السيلفي" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Unsupported") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الماركداون" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Markdaun") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الجهات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Contact") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الكلايش" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Spam") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الانلاين" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Inlen") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح المعرفات" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"UserName") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح التاك" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"hashtak") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الشارحه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Cmd") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الصور" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Photo") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الاباحي" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Xn") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الفيديو" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Video") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح المتحركه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Animation") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الالعاب" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"geam") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الاغاني" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Audio") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الفشار" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Fshar") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "فتح الفارسيه" and msg.reply_to_message_id_ == 0 and Admin(msg.sender_user_id_) then 
UnLock(msg.chat_id_,"Fa") 
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end 
if text == "فتح الكل" and msg.reply_to_message_id_ == 0 and Constructor(msg.sender_user_id_) then  
list ={"Fa","Fshar","edit","editMe","tagservr","pin","Join","Bot","AddMempar","text","Cmd","Photo","Inlen","UserName","hashtak","Markdaun","Contact","Spam","forward","Document","Unsupported","Voice","Keyboard","Sticker","Repetition","text","Audio","geam","Video","Animation","Xn"}
for i,lock in pairs(list) do 
UnLock(msg.chat_id_,lock) 
end
send(msg.chat_id_,"message","text","⌔️︙تم "..text.." .",msg.id_) 
return false
end  
if text == "تحديث" and DevBot2(msg) then
dofile("Test.lua")  
send(msg.chat_id_,"message","text","⌔︙تم التحديث .",msg.id_) 
end

end ---- 'Activation' 
end ---- 'GroupBot' 

if text == 'تفعيل' and DevBot3(msg.sender_user_id_) then 
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,"message","text",'⌔︙البوت ليس ادمن يرجى ترقيتي !',msg.id_) 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
Activation(chat_id)
if database:sismember(bot_id..'Activation:Groups',msg.chat_id_) then
send(msg.chat_id_,"message","text",'⌔︙المجموعه مفعله سابقا ',msg.id_) 
else
send(msg.chat_id_,"message","text",'⌔︙تم تفعيل المجموعه ~ '..chat.title_,msg.id_) 
database:sadd(bot_id..'Activation:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '⌔︙تم تفعيل مجموعه جديده\n'..
'\n⌔︙بواسطة ~ '..Name..''..
'\n⌔︙ايدي المجموعه ~ `'..IdChat..'`'..
'\n⌔︙عدد اعضاء المجموعه *~ '..NumMember..'*'..
'\n⌔︙اسم المجموعه ~ ['..NameChat..']'..
'\n⌔︙الرابط ~ ['..LinkGp..']'
if not DevBot2(msg) then
send(Sudo,"message","text",Text,0) 
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and DevBot3(msg.sender_user_id_) then  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Activation:Groups',msg.chat_id_) then
send(msg.chat_id_,"message","text",'⌔︙المجموعه معطله سابقا ',msg.id_) 
else
send(msg.chat_id_,"message","text",'⌔︙تم تعطيل المجموعه ~ '..chat.title_..'',msg.id_) 
database:srem(bot_id..'Activation:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '⌔︙تم تعطيل مجموعه جديده\n'..
'\n⌔︙بواسطة ~ '..Name..''..
'\n⌔︙ايدي المجموعه ~ `'..IdChat..'`'..
'\n⌔︙اسم المجموعه ~ ['..NameChat..']'..
'\n⌔︙الرابط ~ ['..LinkGp..']'
if not DevBot2(msg) then
send(Sudo,"message","text",Text,0) 
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and not DevBot(msg.sender_user_id_) and not database:get(bot_id..'Free:Add:Bots') then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,"message","text",'⌔︙البوت ليس ادمن يرجى ترقيتي !',msg.id_) 
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = msg.chat_id_:gsub("-100","")}, function(arg,data)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'المشرف'
else 
var= 'عضو'
end
if database:sismember(bot_id..'Activation:Groups',msg.chat_id_) then
send(msg.chat_id_,"message","text",'⌔︙المجموعه مفعله سابقا ',msg.id_) 
else
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevBot2(msg.sender_user_id_) then
send(msg.chat_id_,"message","text",'⌔︙عدد اعضاء المجموعه اقل من *~ {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'* عضو',msg.id_) 
return false
end
send(msg.chat_id_,"message","text",'⌔︙تم تفعيل المجموعه ~ '..chat.title_..'',msg.id_) 
database:sadd(bot_id..'Activation:Groups',msg.chat_id_)  
database:sadd(bot_id..'Up:BasicBuilder'..msg.chat_id_, msg.sender_user_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub('"',"") 
NameChat = NameChat:gsub("`","") 
NameChat = NameChat:gsub("*","") 
NameChat = NameChat:gsub("{","") 
NameChat = NameChat:gsub("}","") 
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '⌔︙تم تفعيل مجموعه جديده\n'..
'\n⌔︙بواسطة ~ '..Name..''..
'\n⌔︙موقعه في المجموعه ~ '..AddPy..'' ..
'\n⌔︙ايدي المجموعه ~ `'..IdChat..'`'..
'\n⌔︙عدد اعضاء المجموعه *~ '..NumMember..'*'..
'\n⌔︙اسم المجموعه ~ ['..NameChat..']'..
'\n⌔︙الرابط ~ ['..LinkGp..']'
if not DevBot2(msg) then
send(Sudo,"message","text",Text,0) 
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
------------------------------------------------------------------------
Started_Bot(msg,data)
FilesBot(msg)
if (data.ID == "UpdateOption" and data.value_.value_ == "Ready") then
print("\27[34m"..[[The Bot is Running]].."\27[m")
local list = database:smembers(bot_id..'UsersBot')  
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end 
local list = database:smembers(bot_id..'Activation:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
database:srem(bot_id..'Activation:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Activation:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id.."Activation:Groups",v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id.."Activation:Groups",v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Activation:Groups",v)  
end end,nil)
end
CleangGroups()
end
end