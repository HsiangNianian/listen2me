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

local nargs = string.split(msg.fromMsg,'>')
local timidity_cfg_path = getDiceDir()..'\\mod\\listen2me\\timidity'
local cfg_text1 = read_file(timidity_cfg_path..'\\timidity.cfg')

if #nargs == 3 then return cfg_text1 end

for k,v in ipairs(nargs) do
    if v == 'dir' then
        return 'dir'
    end
end