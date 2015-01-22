--挡板
--挡板ID 1000 开头

Scratch={}
Scratch["2001"]={
    name="scratch001",
    mogu="scratchmogu",
    --挡板的最小长度
    minLength=50,
    --实际最小生成长度
    realMinLength=80,
    --挡板的最大长度
    maxLength=500,
    --实际最小生成长度
    realMaxLength=500,

    --挡板的最大攻击比率
    maxAtk=2.0,
    --挡板的最小攻击比率
    minAtk=1.0,

    --最小速度
    minReboundSpeed=1.5,
    --最大速度
    maxReboundSpeed=2.0,
    --暴击长度
    critLength=150,
}
function getScratchInfo(taskId)
    if Scratch[taskId] then
        if Scratch[taskId] then
            return Scratch[taskId]
        end

    else
        return false
    end

end;