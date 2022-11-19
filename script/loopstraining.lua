------------------------------------------------------
--@listen2me by 简律纯
--@loopstraning.lua 听音练习功能模块 by 简律纯
--@License MIT. 2022年11月20日
------------------------------------------------------
package.path = getDiceDir() .. "/mod/listen2me/script/?.lua"
require("mml2mid")
------------------------------------------------------
--@Const used in mml2mid.lua
local VERSION = "v1.0.0"
local SETTINGS = Settings
local MML2MID_PATH = Mml2mid_path
local TIMIDITY_PATH = Timidity_path
local MML_FILE_PATH = Mml_file_path
local AUDIO_FILE_PATH = Audio_file_path
local OS_MML2MID = Os_mml2mid
local OS_MID2AUDIO = Os_mid2audio
--@Function used in mml2mid.lua
local clr = clr
local write_file = write_file
local delete_file = delete_file
local getFileList = getFileList
local readFileStringLine = readFileStringLine
------------------------------------------------------
if msg.fromMsg:match("^个人(.*)") then
    --个人
    
elseif msg.fromMsg:match("^团队(.*)") then
    --To-Do List:团队
elseif msg.fromMsg:match("[CDEFGAB][34567]") then
    --回答
    return msg.fromMsg
else
    --显示帮助
    return "loops_training("..VERSION..")\n基于listen2me的听音训练娱乐模块"
end

------------------------------------------------------
--#region generate loops. 生成旋律
------------------------------------------------------


------------------------------------------------------
--#region return loops. 写曲并返回
------------------------------------------------------
