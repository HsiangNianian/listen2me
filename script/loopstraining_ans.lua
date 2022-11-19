if msg.fromMsg:match("^o[3-6][a-g].*") then
    --回答
    return msg.fromMsg
else
    return
end