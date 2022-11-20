-------------------Declaration-------------------
-- @listen2me 使用mml作曲~
-- @author O'MIZUSORA,简律纯.
-- @License MIT.
-- @git htps://github.com/cypress0522/listen2me
-------------------------------------------------
--------------------settings---------------------
Settings = {
    _FRAMWORK = "Gocq", -- "Mirai",
    -- 框架名称,必填,可选参数:'Mirai'或'Gocq'(默认).

    _ONEFILE = "xx", -- os.date("%A"),
    -- 是否将每次的乐谱记录在同一个文件内.

    _WARNING = 18,
    -- 音频文件过多报警上限,未填时默认18

    _AUTOCLR = 21,
    -- 音频文件自动清理，未填时默认21

    _SUBNAME = ".mp3", -- ".wav",
    -- 规定输出格式,填写mp3时需要安装ffmpeg.

    _UPLOAD = false, -- false,
    -- 是否在发出语音同时上传mid文件(仅限Gocq).
    -- 对应下参数_APIPORT.

    _APIPORT = 15700 -- nil
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
local string = require("string")
local json = require("json")

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
        for l in a:lines() do table.insert(fileTable, l) end
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
Time = os.date("%Y%m%d%H%M%S")
Nargs = string.split(msg.fromMsg, ">")
Rest = string.sub(msg.fromMsg, #"l2m>" + 1)
Mml2mid_path = getDiceDir() .. "\\mod\\listen2me\\mml2mid"
File_list = getFileList(Mml2mid_path .. "\\project")
Timidity_path = getDiceDir() .. "\\mod\\listen2me\\timidity"
Sf2_list = getFileList(getDiceDir() .. "\\mod\\listen2me\\timidity",
    "*.sf2")

if Settings._ONEFILE then
    fileName = Mml2mid_path .. "\\project\\" .. Settings._ONEFILE
else
    fileName = Mml2mid_path .. "\\project\\" .. msg.fromQQ .. Time
end

Mml_file_path = fileName .. ".mml"
Audio_file_path = fileName .. Settings._SUBNAME
Mid_file_path = fileName .. ".mid"
Os_mml2mid =
"mml2mid " .. Mml_file_path .. " " .. Mid_file_path .. " > " .. Mml2mid_path ..
    "\\os_mml2mid.err"

if Settings._SUBNAME == ".mp3" then
    Os_mid2audio = "timidity " .. Mid_file_path ..
        " -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k " ..
        Audio_file_path .. " > " .. Timidity_path ..
        "\\os_mid2audio.err"
elseif Settings._SUBNAME == ".wav" then
    Os_mid2audio =
    "timidity " .. Mid_file_path .. " -Ow -o " .. Audio_file_path .. " > " ..
        Timidity_path .. "\\os_mid2audio.err"
end
-- 'timidity '..mid_file_path..' -Ow -o '..audio_file_path
-- 'timidity '..mid_file_path..' -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k '..audio_file_path

----------------------Proc-----------------------
-- @Proc run 脚本运行过程
-------------------------------------------------
if not getUserConf(getDiceQQ(), "l2m:state") then
    if #Sf2_list ~= 0 then
        Sf2_selected = Sf2_list[ranint(1, #Sf2_list)]
        Sf2_list_text = ""
        for k, v in ipairs(Sf2_list) do
            Sf2_list_text = v .. "\n\t" .. Sf2_list_text
        end
    else
        return ">timidity: 笨蛋你好像没有装音源(*.sf2)哦...\n甩给你一个链接https://github.com/cypress0522/listen2me"
    end

    local Cfg_text = [[dir "]] .. Timidity_path .. [["

soundfont "]] .. Sf2_selected .. [["

#extension opt -U]]
    os.execute('setx "path" "' .. Mml2mid_path .. ";" .. Timidity_path ..
        ';%path%"')
    setUserConf(getDiceQQ(), "l2m:state", true)
    write_file(Timidity_path .. "\\timidity.cfg", Cfg_text, "w+")
    return os.date("%X") .. " " .. os.date("%x") ..
        "\n>listen2me: 初始化成功~\n\t已将以下路径添加到用户变量(path):\n\t" ..
        Mml2mid_path .. "\n\t" .. Timidity_path ..
        "\n>timidity:已自动生成cfg文件~\n\t可用音源" ..
        #Sf2_list .. "个\n\t" .. Sf2_list_text .. "选择了音源【" ..
        Sf2_selected .. "】\n请重启框架使环境变量生效!"
end

-- return nargs[2]

if Nargs[2] ~= "clr" then
    if Settings._ONEFILE then
        clr(Mml2mid_path .. "\\project")
        write_file(Mml2mid_path .. "\\project\\init", "", "w+")
    end

    if #File_list >= Settings._WARNING then
        sendMsg(
            "{self}处音频和乐谱缓存有点多了哦，要及时处理呢~",
            msg.fromGroup, msg.fromQQ)
    end

    if #File_list >= Settings._AUTOCLR then
        clr(Mml2mid_path .. "\\project")
        write_file(Mml2mid_path .. "\\project\\init", "", "w+")
    end

    write_file(Mml_file_path, Rest, "w+")
    Mml2mid_stat, _ = os.execute(Os_mml2mid)
    if Mml2mid_stat then
        Mid2audio_stat, _ = os.execute(Os_mid2audio)
        if Mid2audio_stat then
            if Settings._FRAMWORK == "Gocq" then
                if Settings._UPLOAD and msg.gid then
                    para = {
                        ["group_id"] = msg.gid,
                        ["file"] = Mid_file_path,
                        ["name"] = fileName:match(".+\\(.+)$") .. ".mid"
                    }
                    url = "http://127.0.0.1:" .. Settings._APIPORT ..
                        "/upload_group_file"
                    http.post(url, json.encode(para))
                end
                return "[CQ:record,file=file:///" .. Audio_file_path .. "]"
            elseif Settings._FRAMWORK == "Mirai" then
                return "[CQ:record,file=" .. Audio_file_path .. "]"
            else
                return '请填写正确的_FRAMWORK配置哦~\n比如"Mirai"或者"Gocq"。'
            end
        else
            return ">timidity: 转换音频格式错误!\n请检查timidity路径是否在环境变量内。"
        end
    else
        return ">mml2mid: mml语法错误!\n笨蛋你真的有了解过mml或者读过纯子写的mml教程吗?\n错误详情:"
            ..
            readFileStringLine(Mml2mid_path .. "\\os_mml2mid.err", 2)
    end
else
    status = clr(Mml2mid_path .. "\\project")
    write_file(Mml2mid_path .. "\\project\\init", "", "w+")
    return status
end
