if msg.fromMsg:match("^o[3-6][a-g].*") then
    --回答
    if getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT") then
        local rep = msg.fromMsg
        local ans = getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_ANS")
        if rep == ans then
            --答对
            setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT", false)
            return "答对啦"
        else
            --答错
            if getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT_times", 3) > 1 then
                setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT_times",
                    getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT_times", 3) - 1)
                return "答错了呢x\n{nick}还有" ..
                    getUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT_times", 0) .. "次机会哦~再听听！"
            else
                setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT_times", false)
                setUserConf(msg.fromQQ, "listen2me:loopstraining_SINGLE_STAT", false)
                return ":s 答案是" .. ans .. "哦\n{nick}还需多加练习呀，机会用完了！"
            end
        end
    else
        --未开始游戏
        return "{nick}发的什么呀！你还未开始游戏呢。"
    end

else
    return
end
