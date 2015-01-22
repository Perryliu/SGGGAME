--怪物


--怪物

-- ///////////////////////////////////////////近战怪物////////////////////////////
MONSTERINFO = {}

--狸猫
MONSTERINFO["am0001"]={
    name="am0001",
    pic="am0001.png",
    idle=0.1,
    under=0.3,
    die=0.2,
    foot=0.2,
    physicsBodyRatio=0.65,
}
--兔子
MONSTERINFO["am0002"]={
    name="am0002",
    pic="am0002.png",
    idle=0.1,
    under=0.15,
    die=0.15,
    foot=0.1,
    physicsBodyRatio=0.65,
}
-- ///////////////////////////////////////////近战怪物////////////////////////////


-- ///////////////////////////////////////////远程怪物////////////////////////////
--猴子
MONSTERINFO["arm0011"]={
    name="arm0011",
    pic="arm0011.png",
    idle=0.15,
    atk=0.15,
    under=0.15,
    die=0.15,
    foot=0.15,
    physicsBodyRatio=0.6,
}

--松鼠
MONSTERINFO["arm0012"]={
    name="arm0012",
    pic="arm0012.png",
    idle=0.1,
    atk=0.12,
    under=0.1,
    die=0.05,
    foot=0.07,
    physicsBodyRatio=0.6,
}

--松鼠
MONSTERINFO["arm0013"]={
    name="arm0013",
    pic="arm0013.png",
    idle=0.1,
    atk=0.12,
    under=0.1,
    die=0.05,
    foot=0.07,
    physicsBodyRatio=0.6,
}

-- ///////////////////////////////////////////远程怪物////////////////////////////

-- ///////////////////////////////////////////中立怪物////////////////////////////
--羊
MONSTERINFO["sheep"]={
    name="sheep",
    pic="sheep.png",
    under=0.1,
    die=0.1,
    foot=0.13,
    physicsBodyRatio=0.65,
}
-- ///////////////////////////////////////////中立怪物////////////////////////////


-- ///////////////////////////////////////////boss////////////////////////////
--熊boss
MONSTERINFO["bear"]={
    name="bear",
    pic="bear.png",
    idle=0.1,
    under=0.15,
    die=0.17,
    foot=0.1,
    atk=0.2,
    underbee=0.15,
    physicsBodyRatio=0.65,
}
-- ///////////////////////////////////////////boss///////////////////////////


function getMonsterInfo(taskId)
    if MONSTERINFO[taskId] then
        return MONSTERINFO[taskId]
    else
        return false
    end
end

