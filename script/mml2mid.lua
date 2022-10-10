-------------------Declaration-------------------
-- @listen2me 使用mml作曲~
-- @author Hsiang Nianian,简律纯.
-- @License MIT.
-- @git htps://github.com/cypress0522/listen2me
-------------------------------------------------

--------------------settings---------------------
settings = {
    ["_FRAMWORK"] = "Gocq", -- Mirai
    -- 框架名称,必填,可选参数:'Mirai'或'Gocq'(默认).

    _ONEFILE = os.date("%A"), -- false
    -- 是否将每次的乐谱记录在同一个文件内.

    -- ['_WARNING'] = 10,
    -- 音频文件过多报警上限,未填时默认10

    ["_AUTOCLR"] = 20,
    -- 音频文件自动清理，为-1时不清理,未填时默认20

    ["_SUBNAME"] = ".mp3", --.wav
    -- 规定输出格式,填写mp3时需要安装ffmpeg.

    ["_UPLOAD"] = true, --false
    -- 是否在发出语音同时上传mid文件(仅限Gocq).
    -- 对应下参数_APIPORT.

    ["_APIPORT"] = nil -- 15800
    -- Gocq 本地 API 端口,填nil时将自动搜寻,若报错请自行填入.
}
-------------------------------------------------

----------------------func-----------------------
-- @func 脚本的函数和常量定义.
-- @string.split(str,split_char)
-- 根据split_char分割str并存入table.
-- @delete_file(path)
-- 删除path(必须是一个存在的文件夹或文件).
-- @getFileList(path)
-- 将path(必须是一个存在的文件夹)下所有文件存入table.
-- @clr(path)
-- 递归方式删除path(必须是存在的文件夹)内所有文件.
-- !!!Warning: path目录下不能有文件夹存在,否则报错.
-- @readFileStringLine(url,line)
-- 读取文件指定行.
-------------------------------------------------
string = require("string")

write_file = function(path, text, mode)
    file = io.open(path, mode)
    file.write(file, text)
    io.close(file)
end

string.split = function(str, split_char)
    local str_tab = {}
    while (true) do
        local findstart, findend = string.find(str, split_char, 1, true)
        if not (findstart and findend) then
            str_tab[#str_tab + 1] = str
            break
        end
        local sub_str = string.sub(str, 1, findstart - 1)
        str_tab[#str_tab + 1] = sub_str
        str = string.sub(str, findend + 1, #str)
    end

    return str_tab
end

delete_file = function(path)
    local status = ""
    local file = io.open(path, "r")
    file:close(path)

    -- 关闭之后才能"删除"
    local status = os.remove(path)
    if (not status) then
        -- "删除"失败
        return
    end
    return status
end

getFileList = function(path, sub)
    local sub = sub or ""
    local a = io.popen("dir " .. path .. "\\" .. sub .. "/b")
    local fileTable = {}

    if a == nil then
    else
        for l in a:lines() do
            table.insert(fileTable, l)
        end
    end
    return fileTable
end

clr = function(path)
    file_list = getFileList(path)
    if #file_list >= 2 then
        for k, v in pairs(file_list) do
            if file_list[v] ~= "init" then
                delete_file(path .. "\\" .. v)
            end
        end
        return ">l2m>clr: {self}音频缓存已清理完毕√"
    else
        return ">l2m>clr: {self}清理音频缓存失败x"
    end
end

readFileStringLine = function(url, line)
    local str = ""
    local i = 1
    local file = io.open(url, "r")
    for l in file:lines() do
        if i == tonumber(line) then
            str = l
            break
        end
        i = i + 1
    end
    file:close()
    return str
end

----------------------Const----------------------
-- @Const 常量定义,一些路径和值.
-- @time _ONEFILE=true 时失效，作用于文件名.
-- @nargs ToDO-List 内容.
-- @rest 用户输入的 mml 内容.
-- @mml2mid_path 用于添加 mml2mid 环境变量的路径地址.
-- @timidity_path 作用同上.
-- @fileName 记录要生成的 mml 文件的名字.
-- @mml_file_path 生成 mml 的文件名(fileName.mml).
-- @wav_file_path 同上,无损波形文件(*.wav).
-- @mid_file_path 同上,生成的mid文件(*.mid).
-------------------------------------------------
local time = os.date("%Y%m%d%H%M%S")
local nargs = string.split(msg.fromMsg, ">")
local rest = string.sub(msg.fromMsg, #"l2m>" + 1)
local mml2mid_path = getDiceDir() .. "\\mod\\listen2me\\mml2mid"
local file_list = getFileList(mml2mid_path .. "\\project")
local timidity_path = getDiceDir() .. "\\mod\\listen2me\\timidity"
local sf2_list = getFileList(getDiceDir() .. "\\mod\\listen2me\\timidity", "*.sf2")

if settings._ONEFILE then
    fileName = mml2mid_path .. "\\project\\" .. settings._ONEFILE
else
    fileName = mml2mid_path .. "\\project\\" .. msg.fromQQ .. time
end

local mml_file_path = fileName .. ".mml"
local audio_file_path = fileName .. settings._SUBNAME
local mid_file_path = fileName .. ".mid"
local os_mml2mid = "mml2mid " .. mml_file_path .. " " .. mid_file_path .. " > " .. mml2mid_path .. "\\os_mml2mid.err"

if settings._SUBNAME == ".mp3" then
    os_mid2audio =
        "timidity " ..
        mid_file_path ..
            " -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k " ..
                audio_file_path .. " > " .. timidity_path .. "\\os_mid2audio.err"
elseif settings._SUBNAME == ".wav" then
    os_mid2audio =
        "timidity " .. mid_file_path .. " -Ow -o " .. audio_file_path .. " > " .. timidity_path .. "\\os_mid2audio.err"
end
-- 'timidity '..mid_file_path..' -Ow -o '..audio_file_path
-- 'timidity '..mid_file_path..' -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k '..audio_file_path

----------------------Proc-----------------------
-- @Proc run 脚本运行过程
-------------------------------------------------
if not getUserConf(getDiceQQ(), "l2m:state") then
    if #sf2_list ~= 0 then
        sf2_selected = sf2_list[ranint(1, #sf2_list)]
        sf2_list_text = ""
        for k, v in ipairs(sf2_list) do
            sf2_list_text = v .. "\n\t" .. sf2_list_text
        end
    else
        return ">timidity: 笨蛋你好像没有装音源(*.sf2)哦...\n甩给你一个链接https://github.com/cypress0522/listen2me#%E9%9F%B3%E6%BA%90%E4%B8%8B%E8%BD%BD"
    end

    local cfg_text = [[dir "]] .. timidity_path .. [["

soundfont "]] .. sf2_selected .. [["

#extension opt -U]]
    os.execute('setx "path" "' .. mml2mid_path .. ";" .. timidity_path .. ';%path%"')
    setUserConf(getDiceQQ(), "l2m:state", true)
    write_file(timidity_path .. "\\timidity.cfg", cfg_text, "w+")
    return os.date("%X") ..
        " " ..
            os.date("%x") ..
                "\n>listen2me: 初始化成功~\n\t已将以下路径添加到用户变量(path):\n\t" ..
                    mml2mid_path ..
                        "\n\t" ..
                            timidity_path ..
                                "\n>timidity:已自动生成cfg文件~\n\t可用音源" ..
                                    #sf2_list ..
                                        "个\n\t" .. sf2_list_text .. "选择了音源【" .. sf2_selected .. "】\n请重启框架使环境变量生效!"
end

-- return nargs[2]

if nargs[2] ~= "clr" then
    if settings._ONEFILE then
        clr(mml2mid_path .. "\\project")
        write_file(mml2mid_path .. "\\project\\init", "", "w+")
    end
    --
    --[[
    if #file_list >= settings._WARNING then
        return '{self}音频文件过多辣，不想干活了！'
    end
]] if
        #file_list >= settings._AUTOCLR
     then
        clr(mml2mid_path .. "\\project")
        write_file(mml2mid_path .. "\\project\\init", "", "w+")
    end

    write_file(mml_file_path, rest, "w+")
    mml2mid_stat, _ = os.execute(os_mml2mid)
    if mml2mid_stat then
        mid2audio_stat, _ = os.execute(os_mid2audio)
        if mid2audio_stat then
            if settings._FRAMWORK == "Gocq" then
                return "[CQ:record,file=file:///" .. audio_file_path .. "]"
            elseif settings._FRAMWORK == "Mirai" then
                return "[CQ:record,file=" .. audio_file_path .. "]"
            else
                return '请填写正确的_FRAMWORK配置哦~\n比如"Mirai"或者"Gocq"。'
            end
        else
            return ">timidity: 转换音频格式错误!\n请检查timidity路径是否在环境变量内。"
        end
    else
        return ">mml2mid: mml语法错误!\n笨蛋你真的有了解过mml或者读过纯子写的mml教程吗?\n错误详情:" ..
            readFileStringLine(mml2mid_path .. "\\os_mml2mid.err", 2)
    end
else
    status = clr(mml2mid_path .. "\\project")
    write_file(mml2mid_path .. "\\project\\init", "", "w+")
    return status
end
