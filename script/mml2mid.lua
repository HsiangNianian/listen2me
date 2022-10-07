-------------------Declaration-------------------
-- @listen2me 使用mml作曲~
-- @author Hsiang Nianian,简律纯.
-- @License MIT.
-- @git htps://github.com/cypress0522/listen2me
-------------------------------------------------

--------------------settings---------------------
_ONEFILE = false --是否将每次的乐谱记录在同一个文件内
_WARNING = true  --是否开启音频文件过多报警
_AUTOCLR = 20 --音频文件过多自动清理，为-1时不清理
-------------------------------------------------

----------------------Defs-----------------------
-- @Defs 脚本的函数和常量定义.
--
-- @func string.split(str,split_char)
-- 根据split_char分割str并存入table.
--
-- @func delete_file(path)
-- 删除path(必须是一个存在的文件夹或文件).
--
-- @func getFileList(path)
-- 将path(必须是一个存在的文件夹)下所有文件存入table.
--
-- @func clr(path)
-- 递归方式删除path(必须是存在的文件夹)内所有文件.
-- !!!Warning: path目录下不能有文件夹存在,否则报错.
-------------------------------------------------
string = require('string')

write_file = function(path, text, mode)
    file = io.open(path, mode)
    file.write(file, text)
    io.close(file)
end

read_file = function(path, mode)
    local text = ""
    local file = io.open(path, mode)
    if (file ~= nil) then
        text = file.read(file, "*a")
        io.close(file)
    else
        return "没有该文件或文件内容为空哦"
    end
    return text
end

string.split = function(str,split_char)
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

getFileList = function(path)
	
	local a = io.popen("dir "..path.."/b");
	local fileTable = {};
	
	if a==nil then
		
	else
		for l in a:lines() do
			table.insert(fileTable,l)
		end
	end
	return fileTable;
end

clr = function(path)
    file_list = getFileList(path)
    if #file_list ~= 0 then
        for k,v in pairs(file_list) do
            if file_list[v] ~= 'init' then
                delete_file(path.."\\"..v)
            end
        end
        return '{self}音频缓存已清理完毕√'
    else
        return '{self}清理音频缓存失败x'
    end
end

local time = os.date('%Y%m%d%H%M%S-')
local nargs = string.split(msg.fromMsg,'>')
local rest = string.sub(msg.fromMsg,#'l2m>'+1)
local mml2mid_path = getDiceDir()..'\\mod\\listen2me\\mml2mid'
local timidity_path = getDiceDir()..'\\mod\\listen2me\\timidity'
local fileName = mml2mid_path..'\\project\\'..time..'-'..msg.fromQQ
local mml_file_path = fileName..'.mml'
local wav_file_path = fileName..'.wav'
local mid_file_path = fileName..'.mid'

-------------------------------------------------
-- @script run 脚本运行过程
-------------------------------------------------
if not getUserConf(getDiceQQ(),'l2m:state') then
    os.execute("setx \"path\" \""..mml2mid_path..";"..timidity_path..";%path%\"")
    setUserConf(getDiceQQ(),'l2m:state',true)
    return os.date('%X')..' '..os.date('%x')..'\n>listen2me: 初始化成功~\n请重启框架使环境变量生效!'
end

-- return nargs[2]

if nargs[2] ~= 'clr' then
    write_file(mml_file_path,rest,'w+')
    mml2mid_stat,_ = os.execute('mml2mid '..mml_file_path..' '..mid_file_path)
    if mml2mid_stat then
        mid2wav_stat,_ = os.execute('timidity '..mid_file_path..' -Ow -o '..wav_file_path)
        if mid2wav_stat then
            return '[CQ:record,file='..wav_file_path..']\f'..'mml2mid_stat:'..tostring(mml2mid_stat)..'\nmid2wav_stat:'..tostring(mid2wav_stat)
        else
            return '>timidity: 转换音频格式错误!'
        end
    else
        return '>mml2mid: mml语法错误!'
    end
else
    def = clr(mml2mid_path..'\\project')
    write_file(mml2mid_path..'\\project\\init','','w+')
    return def
end