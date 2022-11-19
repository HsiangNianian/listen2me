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
local MML_FILE_PATH = getDiceDir() .. "\\mod\\listen2me\\mml2mid\\project\\" .. "loopstraning.mml"
local SINGLE_STAT = getUserConf(getDiceQQ(), "loopstraning:SINGLE_STAT" .. msg.fromQQ)
local MUTI_STAT = getUserConf(getDiceQQ(), "loopstraning:MUTI_STAT" .. msg.fromGroup)
------------------------------------------------------
local note = {
    "c",
    "d",
    "e",
    "f",
    "g",
    "a",
    "b"
}
local function generate(note_tbl, count)
    local sub = ""
    for i = 1, count do
        local pitch = tostring(ranint(3, 6)):match("%d+")
        local note = note_tbl[ranint(1,#note_tbl)]
        sub = sub .. "o" .. pitch .. note .. " "
    end
    local mml = "l2m>A t200 " .. sub
    -- return mml
    eventMsg(mml, msg.fromGroup, msg.fromQQ)
end

-----------------------------------------------------
if msg.fromMsg:match("^个人(.*)") then
    --个人
    if SINGLE_STAT then
        return "个人听音练习已经有人在玩了哦~还请{nick}稍等呢~"
    else
        --开始游戏
        return generate(note, 1)
    end

elseif msg.fromMsg:match("^团队(.*)") then
    --To-Do List:团队
    if MUTI_STAT then
        return "听音练习已经开始了哦~不可以再另起一个游戏！"
    else
        --开始游戏
    end
else
    --显示帮助
    return "loops_training(" .. VERSION .. ")\n基于listen2me的听音训练娱乐模块"
end

------------------------------------------------------
--#region generate loops. 生成旋律
------------------------------------------------------


------------------------------------------------------
--#region return loops. 写曲并返回
------------------------------------------------------
