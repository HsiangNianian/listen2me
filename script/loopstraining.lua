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
local SINGLE_STAT = getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT")
local MUTI_STAT = getUserConf(getDiceQQ(), "listen2me:loopstraining_MUTI_STAT" .. msg.fromGroup)
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
    local ans = ""
    for i = 1, count do
        local pitch = "o" .. tostring(ranint(3, 6)):match("%d+")
        local note = note_tbl[ranint(1, #note_tbl)]
        ans = ans..pitch..note
    end
    local mml = "l2m>A t200 " .. ans
    -- return mml
    eventMsg(mml, msg.fromGroup, msg.fromQQ)
    setUserConf(msg.fromQQ,"listen2me:loopstraining_SINGLE_ANS",ans)
end

-----------------------------------------------------
if msg.fromMsg:match("^个人(.*)") then
    --个人
    if SINGLE_STAT then
        return "个人听音练习已经开始了哦~还请{nick}作答呢~"
    else
        --开始游戏
        generate(note, 1)
        -- setUserConf(getDiceQQ(),"listen2me:loopstraining_STAT",true)
        setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT",true)
        return "请{nick}仔细聆听这段语音，然后将答案发送出来哦~\ntips:比如发送这样的——o6a"
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
    return "loops_training " ..
        VERSION ..
        "\n基于listen2me的听音训练娱乐模块\n"..
        "1.开始:发送【个人听音练习】or【团队听音练习】\n"..
        "2.答题:发送【音区+音调】，举个例子：o6a\n"..
        "3.tips:\n\t"..
        "【o】语法规定了后面音调的音区，答题范围的o是3-6。\n\t"..
        "可选择的音调为【cdefgab】。"

end

------------------------------------------------------
--#region generate loops. 生成旋律
------------------------------------------------------


------------------------------------------------------
--#region return loops. 写曲并返回
------------------------------------------------------
