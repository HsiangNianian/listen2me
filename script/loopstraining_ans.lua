if msg.fromMsg:match("^o[3-6][a-g].*") then
    --回答
    if getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGEL_STAT") then
        local rep = msg.fromMsg
        local ans = getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_ANS")
        if rep == ans then
            --答对
            return "答对啦"
        else
            --答错
            setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGEL_STAT",false)
            return "答错了呢x"
        end
    end

else
    return
end