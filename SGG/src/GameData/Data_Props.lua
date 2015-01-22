-- //道具


--南瓜导弹
Props_1001= {
    name="CarrotMissile",
    ID=1001,
    normalAtk={pic="wenyiguang1.png",damage=30,type=EnumPropskType.SINGLE,mask=EnumAttackType.MONSTER,
        duration=999,speed=400,isDOT=1,ratio=0.6},
}

--冰冻西瓜
Props_1002= {
    name="CarrotMissile",
    ID=1002,
    normalAtk={pic="reborn_1.png",damage=10,type=EnumPropskType.ANYTHING,mask=EnumAttackType.MONSTER,
        duration=0,isDOT=0,slowdown=0.5,delay=5},
}

--南瓜炸弹

Props_1003= {
    name="CushawBomblon",
    ID=1003,
    normalAtk={pic="chain_1.png",damage=10,type=EnumPropskType.ANYTHING,mask=EnumAttackType.MONSTER,
        duration=0,isDOT=0,},
}

--种子
Props_1004= {
    name="CarrotMissile",
    ID=1004,
    normalAtk={pic="fuze_1.png",damage=-100,type=EnumPropskType.SINGLE,mask=EnumAttackType.MONSTER,
        duration=0,isDOT=0,},
}

--道具动画
Props_ceche={
    ceche={"skill0","skill1"},
    
    propsAnimateKey={
        "wenyiguang","reborn","fuze","expl","fadong","chain"
    },
    
    propsAnimate={
        wenyiguang=9,
        reborn=12,
        expl=9,
        fuze=10,
        fadong=7,
        chain=6,
    },
}


local PropsTable={["Props_1001"]=Props_1001,["Props_1002"]=Props_1002,["Props_1003"]=Props_1003,["Props_1004"]=Props_1004}

function returnPropsTable(num)
    return PropsTable[num]
end