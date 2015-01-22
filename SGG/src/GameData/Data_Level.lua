require "GlobalVariables"
require "Data_Bullet"

--//////////////////////进战怪物三种类型/////////////////////////////////////
GameType={
    Game_Type_Normal = 1,           --默认战斗类型
    Game_Type_Apple = 2,            --苹果战斗类型
    Game_Type_Pause =3,             --暂停战斗类型

    Game_Type_boss_1 = 100,         --第一boss关卡
    Game_Type_boss_2 = 101,         --第二boss关卡
    Game_Type_boss_3 = 101,         --第三boss关卡
    Game_Type_boss_4 = 101,         --第四boss关卡
}

--//////////////////////进战怪物三种类型/////////////////////////////////////

--中立怪物触发条件
neutralMonsterCondition={
    notlife=1,           --击中一下没有生命值
    Endlife=2,           --被攻击至生命值为0（有生命值）
--    refreshNotHit=4,     --从刷新开始n秒内没被攻击（无生命值）
--    refreshNotDie=5,     --从刷新开始n秒内没被杀死（有生命值）
}

--中立怪物触发效果
neutralMonsterResult={
    deductLife=1,       --我方直接扣生命值（可设置怪物依旧存在或消失）
    changeMdie=2,       --变为近战敌人攻击我方（可被攻击杀死）
    changeMNotHit=3,    --变为近战敌人攻击我方（不可被攻击）
    changeMNotDie=4,    --变为近战敌人攻击我方（可被攻击不会死）
    changeWdie=5,       --变成远程敌人攻击我方（可以被攻击杀死）
    randomHit=6,        --随机攻击一个敌人
    hitTargetEnemy=7,   --攻击指定的一个敌人
    recoverLife=8,      --回复我方的生命值（可以设置加成数值）
    addScratch=9,       --增加挡板反弹的伤害（可以设置加成数值）
    blowHurt=10,        --爆炸造成范围伤害(可以设置范围数值)
}


guide1001={
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=0,isMove=0,point={450,950},movespeed=60,hp=8,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=3,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={65,0},isRandom=0}},
        },
        --中立怪物
        scratch={
            name="scratch001",
        },

        plants={
            hp=20,
            meisu="shucai1",
        },
gametype=GameType.Game_Type_Pause,
        backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
}

SggGameCeche={
    ceche={"arm0011","arm0012","am0001","sheep","bear","honeyBee","am0002"
        ,"arm0013","monsterBullet","duckBullet"},
    sggAnimate={
        arm0011={atk=10,under=1,die=5,foot=4,idle=5},
        arm0012={atk=11,under=2,die=11,foot=8,},
        arm0013={atk=5,under=4,die=6,foot=5,},
        am0001={under=2,die=6,foot=4,},
        sheep={under=3,die=7,foot=5,},
        bear={atk=7,under=3,underbee=4,die=7,foot=7},
        honeyBee={under=5,foot=2,atk=2},
        am0002={under=2,die=6,foot=5,},
        xiaoniao={fly=2,hit=1,plume=5,},
        duckBullet={fly=2,hit=1,plume=4,},
    },
}


--胜利条件              普通关卡使用   限定3种
GameCondition ={
    Condition_Type_ScratchLength=2,         --消耗挡板长度                           --ScratchMainlength={800},
    Condition_Type_ScratchTimes=3,          --命中率                                           --levelhitrate={0.5},
    Condition_Type_ScratchCritRate=4,       --暴击率                                           --levelcritrate={0.2},
    Condition_Type_PlantsGold=5,            --植物得分                                      --PlantsGoal={0.8,1},
    Condition_Type_KillMonsterNum=6,        --击杀某种怪物数量                  --KillMonster={monstertype={"arm0011"},amount={10}}
    Condition_Type_NotKillMonster=7,        --不可击杀怪物                             -- NotKillMonster={monstertype={"arm0011"},amount={12},}
    Condition_Type_BeKillMonsterMainNum=8,  --击杀怪物总量                            --KillMonsterMainNum = {10,20}
    Condition_Type_WinGameTotalTime=9,      --游戏胜利时间                            --wingametotaltime={10,20}
}



level1_1={

        battery={
 },

        monster={
       
        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={150,1200},endpoint={150,800},movespeed=80,hp=2,attackspeed=3,
             normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
   --    leaveTime=10,leavePoint={700,800},
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=12,isMove=1,point={400,1200},endpoint={400,800},movespeed=80,hp=2,attackspeed=3,
             normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}}, 
            


        },
        --中立怪物
        neutralMonster={},
        bossMonster={ },
        honeyBee={  },
        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },
        backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        -- 条件
        gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_PlantsGold,       --植物得分
        },
        KillMonster={monstertype={"arm0011"},amount={2}},
        PlantsGoal={1},
   
}

level1_2={

        battery={
--            {point={200,1140},attackspeed={0,5,10,15,20,25,30,35,40,45},
--                refreshtime=1,count=10,normalAtk={bulletInfo=bu3,damage=1,
--                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1,1,1,1,1,1}}},
        },

        monster={
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={320,1200},movespeed=40.0,isRandom=0,endpoint={320,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
            
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=9,point={320,1200},movespeed=40.0,isRandom=0,endpoint={320,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        
        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=2,isMove=1,point={170,1200},endpoint={170,1000},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0},},leaveTime=16,leavePoint={-100,1100}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=18,isMove=1,point={170,1200},endpoint={170,1000},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={320,0},}},
                
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={450,1200},endpoint={450,1000},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=15,leavePoint={700,1000}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=16,isMove=1,point={450,1200},endpoint={450,1000},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
                
            --         {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=15,isMove=1,point={350,1200},endpoint={300,1000},movespeed=50,hp=2,attackspeed=2,
            --             normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
            
--            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=13,isMove=1,point={400,1200},endpoint={320,950},movespeed=80,hp=2,attackspeed=3,
--                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0},}},
           
        },
        --中立怪物
        neutralMonster={},
        bossMonster={ },
        honeyBee={  },
        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

        backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},
        gametype=GameType.Game_Type_Normal,

        gameTime=0,
  
        -- 条件
        gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量               
        },
   
        KillMonster={monstertype={"arm0011","am0001"},amount={2,2}},

  
}

level1_3={

        battery={
           
        },

        monster={
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={350,1200},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=7,point={320,1200},movespeed=50.0,isRandom=0,endpoint={320,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={320,1200},movespeed=50.0,isRandom=0,endpoint={320,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={400,1200},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={250,1200},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=23,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=23,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=3,isMove=1,point={400,1200},endpoint={550,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0}},leaveTime=14,leavePoint={660,1000}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=17,isMove=1,point={400,1200},endpoint={550,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0}}},
                
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=6,isMove=1,point={200,1200},endpoint={100,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=10,leavePoint={-10,1000}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=16,isMove=1,point={200,1200},endpoint={100,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
        --         {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=15,isMove=1,point={350,1200},endpoint={300,1000},movespeed=50,hp=2,attackspeed=2,
        --             normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},



        },
        --中立怪物
        neutralMonster={},
        bossMonster={ },
        honeyBee={  },
        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },


backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        
                 gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量               
            },
  
        KillMonster={monstertype={"arm0011","am0002"},amount={2,4}},


}




level1_4={

        battery={
--            {point={200,1140},attackspeed={0,3,6,9,12,15,20,24,27,29},
--                refreshtime=12,count=10,normalAtk={bulletInfo=bu3,damage=1,
--                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1,1,1,1,1,1}}},
 },

        monster={
           -- {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={150,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={550,1200},movespeed=50.0,isRandom=0,endpoint={550,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={100,1200},movespeed=40.0,isRandom=0,endpoint={100,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={100,1200},movespeed=40.0,isRandom=0,endpoint={100,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
--            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=13,point={550,1200},movespeed=50.0,isRandom=0,endpoint={550,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={550,1200},movespeed=50.0,isRandom=0,endpoint={550,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
--            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
--            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,-10},hp=1,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},


        },
        remotemonster={
             {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={320,1200},endpoint={320,950},movespeed=80,hp=2,attackspeed=3,
                 normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
                 
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=9,isMove=1,point={170,1200},endpoint={170,950},movespeed=50,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=9,isMove=1,point={450,1200},endpoint={450,1000},movespeed=50,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},


        },
        --中立怪物
        neutralMonster={},
        bossMonster={ },
        honeyBee={  },
        scratch={
        name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        
        gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量               
        },

        KillMonster={monstertype={"am0001","am0002"},amount={2,4}},

}


level1_5={

        battery={
            {point={200,1140},attackspeed={1,2,4,5,8,11,12,15},
                refreshtime=1,count=8,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1,1,1}}},

        },

        monster={
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=2,point={300,1200},movespeed=50.0,isRandom=0,endpoint={300,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=15,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=24,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=11,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={100,1200},movespeed=40.0,isRandom=0,endpoint={100,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={100,1200},movespeed=40.0,isRandom=0,endpoint={100,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=35,point={100,1200},movespeed=40.0,isRandom=0,endpoint={100,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
    
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=48,point={320,1200},movespeed=50.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=50,point={320,1200},movespeed=50.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=52,point={320,1200},movespeed=50.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
            
            
            
            

        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=10,isMove=1,point={550,1200},endpoint={500,900},movespeed=50,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=14,leavePoint={660,950}},
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=22,isMove=1,point={550,1200},endpoint={500,900},movespeed=50,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=12,leavePoint={660,950}},
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=32,isMove=1,point={550,1200},endpoint={500,900},movespeed=50,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=14,isMove=1,point={600,1200},endpoint={550,1000},movespeed=60,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=15,leavePoint={660,1000}},
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=28,isMove=1,point={600,1200},endpoint={550,1000},movespeed=60,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0}},


        },
        --中立怪物
        neutralMonster={

        },

        bossMonster={ },

        honeyBee={  },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        
        gameCondition={
            GameCondition.Condition_Type_PlantsGold, 
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
    
        },

        KillMonster={monstertype={"arm0011"},amount={8}},
        PlantsGoal={0.5},
}


level1_19={
 
    battery={
    
--            {point={200,1140},attackspeed={2,5,7,10,46},
--            refreshtime=1,count=5,normalAtk={bulletInfo=bu3,damage=1,
--            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1}}},

            {point={250,1140},attackspeed={1},refreshtime=3,count=1,normalAtk={bulletInfo=bu3,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={1},refreshtime=3,count=1,normalAtk={bulletInfo=bu3,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
                
        {point={100,1140},attackspeed={1},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={100,0},isRandomTable={0}}},
            {point={150,1140},attackspeed={1.6},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={150,0},isRandomTable={0}}},
            {point={200,1140},attackspeed={2.2},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
               mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},     
            {point={250,1140},attackspeed={2.8},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={3.4},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},
                
               --26- 29
           
            {point={500,1140},attackspeed={1.6},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={2.1},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},     
            {point={400,1140},attackspeed={2.6},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={3.1},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
                
          
            {point={500,1140},attackspeed={4.5},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},     
            {point={450,1140},attackspeed={3.0},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.0},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={1.0},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={1.5},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
            {point={250,1140},attackspeed={2.5},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={200,1140},attackspeed={3.5},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={150,1140},attackspeed={5.0},refreshtime=35,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={150,0},isRandomTable={0}}},
                
            {point={450,1140},attackspeed={1.6},refreshtime=41,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.1},refreshtime=41,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},     
            {point={350,1140},attackspeed={2.6},refreshtime=41,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
    },
 
   monster={
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=2,point={250,1200},movespeed=40.0,isRandom=0,endpoint={250,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=2,point={400,1200},movespeed=40.0,isRandom=0,endpoint={400,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
         
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={350,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
                
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={550,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
          
             
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={150,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={550,1200},movespeed=40.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},  
               
    -- {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=30,point={150,1200},movespeed=50.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
               
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={600,1200},endpoint={600,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={500,1200},endpoint={500,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={400,1200},endpoint={400,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={300,1200},endpoint={300,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={200,1200},endpoint={200,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
   {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={100,1200},endpoint={100,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            

   },
   remotemonster={
      {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=7,isMove=1,point={100,1200},endpoint={100,1000},movespeed=90,hp=4,attackspeed=5,
         normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
      
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=3,isMove=1,point={500,1200},endpoint={500,900},movespeed=80,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0}},

        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=25,isMove=1,point={200,1200},endpoint={250,900},movespeed=80,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0}},


   },
   --中立怪物
   neutralMonster={
   },
   
   bossMonster={
   },
   
   honeyBee={ },
   
   scratch={
       name="scratch001",
   },

   plants={
        hp=5,
        meisu="shucai1",
   },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},
    
        gametype=GameType.Game_Type_Normal,
    
    gameTime=0,
    
        gameCondition={         
           GameCondition.Condition_Type_PlantsGold,
            GameCondition.Condition_Type_PlantsGold,
  },
        PlantsGoal={0.5,1},

}
-- 2
level1_6={
--杀4只猴子

        battery={

            {point={300,1140},attackspeed={2,5},
                refreshtime=1,count=2,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1}}},
      
                    
            {point={250,1140},attackspeed={2.3},refreshtime=18,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},     
            {point={300,1140},attackspeed={3.0},refreshtime=18,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={3.7},refreshtime=18,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},

            {point={200,1140},attackspeed={1.6},refreshtime=10,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={2.3},refreshtime=10,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},     
            {point={300,1140},attackspeed={3.0},refreshtime=10,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={3.7},refreshtime=10,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},

       
            {point={150,1140},attackspeed={2.1},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={150,0},isRandomTable={0}}},     
            {point={200,1140},attackspeed={2.7},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={3.3},refreshtime=23,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},


        },

        monster={
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=3,point={150,1200},movespeed=50.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

           {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={350,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=15,point={150,1200},movespeed=50.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
           {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={140,1200},endpoint={140,0},movespeed=60.0,isRandom=0,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
          {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={230,1200},endpoint={230,0},movespeed=60.0,isRandom=0,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
           {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={300,1200},endpoint={300,0},movespeed=60.0,isRandom=0,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

 



        },
        remotemonster={
--            {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=8,isMove=1,point={200,1200},endpoint={250,800},movespeed=50,hp=4,attackspeed=5,
--                normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
--   
--            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=2,isMove=1,point={100,1200},endpoint={100,1000},movespeed=80,hp=2,attackspeed=3,
--                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandom=0}},
           {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=24,isMove=1,point={160,1200},endpoint={160,1000},
           movespeed=80,hp=2,attackspeed=3,leaveTime=19,leavePoint={160,1300},normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandom=1,}},
               
           {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=26,isMove=1,point={320,1200},endpoint={320,1000},movespeed=80,hp=2,attackspeed=3,
           leaveTime=19,leavePoint={320,1300},normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={320,0},isRandom=1}},
                
           {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=27,isMove=1,point={480,1200},endpoint={480,1000},movespeed=80,hp=2,attackspeed=3,
            leaveTime=21,leavePoint={400,1300},normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandom=1}},
              
           {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=28,isMove=1,point={600,1200},endpoint={600,1000},movespeed=80,hp=2,attackspeed=3
            ,leaveTime=21,leavePoint={550,1300}, normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandom=1}},
        },
        
        --中立怪物
        neutralMonster={
        --m名字（素材名字） refreshtime刷新时间 isMove是否移动 point刷新点坐标 moveForever(1永远重复移动)endpointType终点坐标类型(0-不移动,1-只移动一个坐标或者 移动多个坐标)
        --endpointTable移动坐标和速度和位置(number-第几点坐标) ExitTime(0-无时间限制，大于0-限定时间)存在时间 condition触发条件 result触发效果
        --       
--            {m="sheep",refreshtime=20,isMove=1,point={800,500},ExitTime=0,hp=0,moveForever=0,
--                endpointTable={{endpoint={800,800},movespeed=80,number=1},{endpoint={150,900},movespeed=80,number=2},
--                    {endpoint={0,700},movespeed=80,number=3},{endpoint={800,400},movespeed=80,number=4},},
--                condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},

        },

        bossMonster={},

        honeyBee={},

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

     

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        
    gametype=GameType.Game_Type_Normal,

    gameTime=0,

    gameCondition={         
        GameCondition.Condition_Type_PlantsGold,
        GameCondition.Condition_Type_PlantsGold,
    },
    PlantsGoal={0.5,1},

}

level1_8={

        battery={
--            {point={200,1140},attackspeed={2,4,10,30,34,38},
--                refreshtime=1,count=6,normalAtk={bulletInfo=bu3,damage=1,
--                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1,1}}},

            {point={450,1140},attackspeed={3.0},refreshtime=3,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.0},refreshtime=3,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={1.0},refreshtime=3,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={1.5},refreshtime=3,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
            {point={250,1140},attackspeed={2.5},refreshtime=3,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
         



        },

        monster={
            
            
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1200},movespeed=50.0,isRandom=0,endpoint={300,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={200,1200},movespeed=40.0,isRandom=0,endpoint={200,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={350,1200},movespeed=40.0,isRandom=0,endpoint={350,-10},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
     {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={250,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

    
       
       {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={300,1200},movespeed=50.0,isRandom=0,endpoint={300,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={450,1200},movespeed=50.0,isRandom=0,endpoint={450,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
     {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={200,1200},movespeed=50.0,isRandom=0,endpoint={200,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},      

        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=4,isMove=1,point={100,1200},endpoint={150,1000},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=18,leavePoint={-20,1100}},
     
            {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=6,isMove=1,point={500,1200},endpoint={550,900},movespeed=90,hp=4,attackspeed=1.3,
                normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=18,leavePoint={700,1100}},
                
            {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=24,isMove=1,point={50,1200},endpoint={80,950},movespeed=80,hp=4,attackspeed=1.3,
                normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=20,leavePoint={-100,1200}},

  

        },
        --中立怪物
        neutralMonster={

        },

        bossMonster={},

        honeyBee={ },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        gametype=GameType.Game_Type_Normal,

        gameTime=0,

        gameCondition={         
            GameCondition.Condition_Type_PlantsGold,
            GameCondition.Condition_Type_PlantsGold,
        },
        PlantsGoal={0.5,1},

}


level1_9={

        battery={
            {point={320,1140},attackspeed={7,9,12},
                refreshtime=1,count=3,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={320,-10},isRandomTable={1,0,0}}},


            {point={500,1140},attackspeed={1},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
                
            {point={450,1140},attackspeed={1.6},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
                
            {point={400,1140},attackspeed={2.2},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
               
            {point={320,1140},attackspeed={1},refreshtime=1,count=1,normalAtk={bulletInfo=bu5,damage=1,
               mask=EnumAttackType.FARMLAND,duration=0,targetPoint={320,0},isRandomTable={0}}},
           {point={400,1140},attackspeed={1.6},refreshtime=1,count=1,normalAtk={bulletInfo=bu5,damage=1,
              mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
           {point={240,1140},attackspeed={2.2},refreshtime=1,count=1,normalAtk={bulletInfo=bu5,damage=1,
               mask=EnumAttackType.FARMLAND,duration=0,targetPoint={240,0},isRandomTable={0}}}, 
 },

        monster={
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={250,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={450,1200},movespeed=50.0,isRandom=0,endpoint={450,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=14,point={450,1200},movespeed=50.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={250,1200},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
               
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=26,point={350,1200},movespeed=50.0,isRandom=0,endpoint={350,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=26,point={250,1200},movespeed=50.0,isRandom=0,endpoint={250,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=26,point={450,1200},movespeed=50.0,isRandom=0,endpoint={450,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

          
 },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={100,1200},endpoint={100,900},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=14,leavePoint={-200,900}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=15,isMove=1,point={100,1200},endpoint={100,900},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=14,leavePoint={-200,900}},
               
            {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=9,isMove=1,point={80,1200},endpoint={80,1000},movespeed=90,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=20,leavePoint={-200,1000}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=29,isMove=1,point={600,1200},endpoint={550,980},movespeed=90,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandom=0}},


        },
        --中立怪物
        neutralMonster={

        --m名字（素材名字） refreshtime刷新时间 isMove是否移动 point刷新点坐标 moveForever(1永远重复移动)endpointType终点坐标类型(0-不移动,1-只移动一个坐标或者 移动多个坐标)
        --endpointTable移动坐标和速度和位置(number-第几点坐标) ExitTime(0-无时间限制，大于0-限定时间)存在时间 condition触发条件 result触发效果
        --       
            {m="sheep",refreshtime=8,isMove=1,point={800,800},ExitTime=0,hp=0,moveForever=0,MonsterSpecia=EnumMonsterSpecia.COMMON_NEUTRAL,
                 endpointTable={{endpoint={800,800},movespeed=80,number=1},{endpoint={150,900},movespeed=80,number=2},
                   {endpoint={0,700},movespeed=80,number=3},{endpoint={800,600},movespeed=80,number=3},},
                       condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},


        },

        bossMonster={

        },

        honeyBee={

        },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,
        gameTime=0,
        
        gameCondition={         
            GameCondition.Condition_Type_PlantsGold,
            GameCondition.Condition_Type_PlantsGold,
        },
        PlantsGoal={0.5,1},

}

level1_11={

        battery={

        },

        monster={
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={150,1140},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={400,1140},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={350,1140},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={550,1140},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={650,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=23,point={650,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=26,point={650,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=21,point={-10,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=24,point={-10,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=27,point={-10,850},movespeed=45.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 

            
            
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={150,1140},movespeed=40.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={400,1140},movespeed=40.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=43,point={150,1140},movespeed=40.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=43,point={400,1140},movespeed=40.0,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=43,point={300,1140},movespeed=40.20,isRandom=1,hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=54,point={200,1140},movespeed=45.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=54,point={500,1140},movespeed=45.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=54,point={400,1140},movespeed=45.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=54,point={300,1140},movespeed=45.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
    
        },
        remotemonster={
--            {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=13,isMove=1,point={250,1140},endpoint={250,1000},movespeed=80,hp=4,attackspeed=5,
--                normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
       --     {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=16,isMove=1,point={500,1200},endpoint={550,900},movespeed=50,hp=4,attackspeed=6,
        --        normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=2,isMove=1,point={700,900},endpoint={600,1000},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=20,leavePoint={700,1300}},
                
                {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=22,isMove=1,point={700,900},endpoint={600,900},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=13,leavePoint={700,1300}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=35,isMove=1,point={700,900},endpoint={600,1000},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=12,leavePoint={700,1300}},
                {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=47,isMove=1,point={700,900},endpoint={600,900},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=35,leavePoint={700,1300}},
              
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={-100,900},endpoint={50,1000},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=2,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=20,leavePoint={-50,1300}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=20,isMove=1,point={-100,900},endpoint={50,900},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=2,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=15,leavePoint={-50,1300}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=35,isMove=1,point={-100,900},endpoint={50,1000},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=2,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=10,leavePoint={-50,1300}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=45,isMove=1,point={-100,900},endpoint={50,900},movespeed=80,hp=3,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=2,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=35,leavePoint={-50,1300}},
                
--                
--            {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=22,isMove=1,point={150,1200},endpoint={150,1000},movespeed=80,hp=2,attackspeed=4,
--                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},



        },
        --中立怪物
        neutralMonster={
--        
--            {m="sheep",refreshtime=8,isMove=1,point={0,800},ExitTime=0,hp=0,moveForever=0,
--                endpointTable={{endpoint={0,800},movespeed=80,number=1},{endpoint={150,900},movespeed=80,number=2},
--                 {endpoint={800,900},movespeed=80,number=3},},
--                condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},
--                
--            {m="sheep",refreshtime=25,isMove=1,point={800,800},ExitTime=0,hp=0,moveForever=0,
--                endpointTable={{endpoint={800,800},movespeed=80,number=1},{endpoint={150,900},movespeed=80,number=2},
--                    {endpoint={0,700},movespeed=80,number=3},{endpoint={800,600},movespeed=80,number=3},},
--                condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},
--        
        },

        bossMonster={},


        honeyBee={},

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},
            
        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量               
        },

        KillMonster={monstertype={"am0002","am0001"},amount={12,8}},

}

level1_12={

        battery={
            --15
            {point={200,1140},attackspeed={1},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={1.6},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={2.2},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
            {point={350,1140},attackspeed={2.8},refreshtime=13,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},

        },

        monster={
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={320,1200},movespeed=60.0,isRandom=0,endpoint={450,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1200},movespeed=60.0,isRandom=0,endpoint={450,0},hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=9,point={300,1200},movespeed=50.0,isRandom=0,endpoint={350,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=9,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=18,point={650,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={650,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=18,point={-10,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=20,point={-10,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 

            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=28,point={400,1200},movespeed=50.0,isRandom=0,endpoint={150,0},hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},  

            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=31,point={300,1200},movespeed=50.0,isRandom=0,endpoint={150,0},hp=2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=35,point={200,1200},movespeed=60.0,isRandom=0,endpoint={200,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},


        },
        remotemonster={
     
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=2,isMove=1,point={150,1200},endpoint={150,1000},movespeed=100,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=12,leavePoint={-10,1200}},
                
            {m="arm0013",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=15,isMove=1,point={400,1200},endpoint={550,1000},movespeed=90,hp=4,attackspeed=1.5,
                normalAtk={bulletInfo=bu4,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},


        },
        --中立怪物
        neutralMonster={
        },

        bossMonster={},


        honeyBee={},

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },
        
backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},
            
        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        gameCondition={
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量                  
            GameCondition.Condition_Type_KillMonsterNum,        --击杀某种怪物数量               
        },

        KillMonster={monstertype={"am0001","am0002"},amount={4,7}},

        
}


level1_14={

        battery={
            {point={200,1140},attackspeed={1,6,9},
                refreshtime=1,count=3,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={305,0},isRandomTable={0,0,0}}},

            {point={500,1140},attackspeed={4.5},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},    
                 
            {point={450,1140},attackspeed={3.0},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
                
            {point={400,1140},attackspeed={2.0},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
                
            {point={350,1140},attackspeed={1.0},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
                
            {point={300,1140},attackspeed={1.5},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
                
            {point={250,1140},attackspeed={2.5},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
                
            {point={200,1140},attackspeed={3.5},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
                
            {point={150,1140},attackspeed={5.0},refreshtime=36,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={150,0},isRandomTable={0}}},  
                 
     


        },       



        monster={
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={350,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            -- {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=14,point={350,1200},movespeed=50.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=14,point={650,850},movespeed=60.0,isRandom=0,endpoint={320,-50},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=14,point={-10,880},movespeed=60.0,isRandom=0,endpoint={320,-50},hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=2,point={300,1200},movespeed=50.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},


            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={600,1200},endpoint={600,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={500,1200},endpoint={500,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={400,1200},endpoint={400,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={300,1200},endpoint={300,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={200,1200},endpoint={200,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={100,1200},endpoint={100,-10},movespeed=60.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 



        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={180,1200},endpoint={180,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=32,leavePoint={-100,900}},
                
            {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=8,isMove=1,point={80,1200},endpoint={80,900},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=25,leavePoint={-100,800}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=24,isMove=1,point={500,1200},endpoint={550,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=10,leavePoint={700,1200}},


        },
        --中立怪物
        neutralMonster={

            --m名字（素材名字） refreshtime刷新时间 isMove是否移动 point刷新点坐标 moveForever(1永远重复移动)endpointType终点坐标类型(0-不移动,1-只移动一个坐标或者 移动多个坐标)
            --endpointTable移动坐标和速度和位置(number-第几点坐标) ExitTime(0-无时间限制，大于0-限定时间)存在时间 condition触发条件 result触发效果
            --       
            {m="sheep",refreshtime=1,isMove=1,point={800,800},ExitTime=0,hp=0,moveForever=0,
                endpointTable={{endpoint={800,800},movespeed=60,number=1},{endpoint={150,900},movespeed=60,number=2},
                    {endpoint={0,700},movespeed=60,number=3},{endpoint={800,600},movespeed=60,number=3},},
                condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},

            {m="sheep",refreshtime=20,isMove=1,point={800,500},ExitTime=0,hp=0,moveForever=0,
                endpointTable={{endpoint={800,800},movespeed=80,number=1},{endpoint={150,900},movespeed=80,number=2},
                    {endpoint={0,700},movespeed=80,number=3},{endpoint={800,400},movespeed=80,number=3},},
                condition=neutralMonsterCondition.notlife,result=neutralMonsterResult.deductLife,Resultdata={damage=1,duration=0}},

        },

        bossMonster={

        },

        honeyBee={

        },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },
backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,
        gameTime=0,
        gameCondition={         
            GameCondition.Condition_Type_NotKillMonster,
            GameCondition.Condition_Type_PlantsGold,
        },
        NotKillMonster={monstertype={"sheep"},amount={1}},
        PlantsGoal={1},
}





level1_15={

        battery={
            {point={200,1140},attackspeed={9,12,15,30},
                refreshtime=1,count=4,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={105,0},isRandomTable={1,1,0,0}}},

   
            {point={450,1140},attackspeed={3.0},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.0},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={1.0},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={1.5},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
            {point={250,1140},attackspeed={2.5},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={200,1140},attackspeed={3.5},refreshtime=4,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
         



       
        {point={450,1140},attackspeed={3.0},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
        {point={400,1140},attackspeed={2.0},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
        {point={350,1140},attackspeed={1.0},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
        {point={300,1140},attackspeed={1.5},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},     
        {point={250,1140},attackspeed={2.5},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
        {point={200,1140},attackspeed={3.5},refreshtime=52,count=1,normalAtk={bulletInfo=bu5,damage=1,
            mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
         
                
        },       
                
                 

        monster={
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=12,point={700,850},movespeed=50.0,isRandom=0,endpoint={320,-10},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            -- {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=14,point={350,1200},movespeed=50.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={400,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={450,1200},movespeed=50.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={350,1200},movespeed=40.0,isRandom=1,hp=2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},


          
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={500,1200},endpoint={500,-10},movespeed=50.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={400,1200},endpoint={400,-10},movespeed=50.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1200},endpoint={300,-10},movespeed=50.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={200,1200},endpoint={200,-10},movespeed=50.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
           
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=33,point={650,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=35,point={650,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=37,point={650,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=34,point={-10,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=36,point={-10,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=38,point={-10,850},movespeed=40.0,isRandom=0,endpoint={320,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},}, 

            
            
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=48,point={500,1200},endpoint={500,-10},movespeed=40.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=48,point={400,1200},endpoint={400,-10},movespeed=40.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=48,point={300,1200},endpoint={300,-10},movespeed=40.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=48,point={200,1200},endpoint={200,-10},movespeed=40.0,isRandom=0,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
          
            
            
        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=7,isMove=1,point={80,1200},endpoint={80,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=37,leavePoint={-50,1200}},
                
            {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=14,isMove=1,point={180,1200},endpoint={180,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=20,leavePoint={800,1200}},
                 {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=33,isMove=1,point={180,1200},endpoint={180,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=16,leavePoint={800,1200}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=30,isMove=1,point={500,1200},endpoint={550,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0},leaveTime=17,leavePoint={700,1200}},


        },
        --中立怪物
        neutralMonster={
 },

        bossMonster={

        },

        honeyBee={

        },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,
        gameTime=0,
        gameCondition={         
            GameCondition.Condition_Type_PlantsGold,
            GameCondition.Condition_Type_PlantsGold,
        },
        PlantsGoal={0.5,1},

}

--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

level1_17={

        battery={
            {point={300,1140},attackspeed={1,6,10},
                refreshtime=1,count=3,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={1,0,1}}},

            {point={300,1140},attackspeed={1},refreshtime=17,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},
            {point={350,1140},attackspeed={1.6},refreshtime=17,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={350,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.2},refreshtime=17,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},  


            {point={500,1140},attackspeed={1},refreshtime=22,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={1.6},refreshtime=22,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={2.2},refreshtime=22,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},

            {point={200,1140},attackspeed={1},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={1.5},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={2.0},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},  
},

        monster={
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={400,1200},movespeed=50.0,isRandom=0,endpoint={400,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

         {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=6,point={300,1200},movespeed=40.0,isRandom=1,hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={400,1200},movespeed=50.0,isRandom=0,endpoint={350,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=13,point={300,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
           {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=17,point={150,1200},movespeed=50.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=12,point={350,1200},movespeed=50.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=29,point={250,1200},movespeed=40.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
 
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={500,1200},movespeed=40.0,isRandom=0,endpoint={500,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={400,1200},movespeed=40.0,isRandom=0,endpoint={400,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={300,1200},movespeed=40.0,isRandom=0,endpoint={300,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={200,1200},movespeed=40.0,isRandom=0,endpoint={200,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={100,1200},endpoint={100,1000},movespeed=80,hp=2,attackspeed=3,
            leaveTime=14,leavePoint={-100,1200}, normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=15,isMove=1,point={100,1200},endpoint={100,950},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
                
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=3,isMove=1,point={600,1200},endpoint={600,1000},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=17,leavePoint={700,1000}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=21,isMove=1,point={650,1200},endpoint={600,980},movespeed=80,hp=2,attackspeed=3,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0}},
                
         


        },
        --中立怪物
        neutralMonster={

        },

        bossMonster={
        --         {m="bear",refreshtime=2,isMove=1,point={50,800},endpoint={600,-100},movespeed=10.0,hitDistance=100,
        --         hitMoveSpeed=100,hp=100,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,}},
        },

        honeyBee={
        --         {m="honeyBee",isLeft=true,refreshtime=1,isMove=1,point={85,900},honeyCount={3,4,5,6},patrolTime=5,
        --         honey={m="honey",a=70,b=70,maxA=190,maxB=190,aDistance=40,bDistance=40,moveInAnticlockwise=false},
        --         normalAtk={damage=1,mask=EnumAttackType.BOSS,duration=0,}},

        --         {m="honeyBee",isLeft=false,refreshtime=1,isMove=1,point={555,900},honeyCount={3,4,5,6},patrolTime=5,
        --         honey={m="honey",a=70,b=70,maxA=190,maxB=190,aDistance=40,bDistance=40,moveInAnticlockwise=false},
        --         normalAtk={damage=1,mask=EnumAttackType.BOSS,duration=0,}},
        },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },

            backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},
            
        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        
        gameCondition={
          
           GameCondition.Condition_Type_PlantsGold,
      
        GameCondition.Condition_Type_BeKillMonsterMainNum, 
        
        },
        PlantsGoal={1},
        KillMonsterMainNum = {14},
}
--8
level1_18={

        battery={
           

            {point={200,1140},attackspeed={1},refreshtime=14,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={1.4},refreshtime=14,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={1.8},refreshtime=14,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},  


            {point={200,1140},attackspeed={1},refreshtime=19,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={200,0},isRandomTable={0}}},
            {point={250,1140},attackspeed={1.4},refreshtime=19,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={250,0},isRandomTable={0}}},
            {point={300,1140},attackspeed={1.8},refreshtime=19,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={300,0},isRandomTable={0}}},  


            {point={500,1140},attackspeed={1},refreshtime=25,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={1.4},refreshtime=25,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={1.8},refreshtime=25,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
                
            {point={500,1140},attackspeed={1},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={1.4},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={1.8},refreshtime=29,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
                
            {point={500,1140},attackspeed={1},refreshtime=33,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={1.4},refreshtime=33,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={1.8},refreshtime=33,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},
},

        monster={
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=8,point={450,1200},movespeed=60.0,isRandom=0,endpoint={450,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=2,point={150,1200},movespeed=60.0,isRandom=0,endpoint={200,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=13,point={150,1200},movespeed=60.0,isRandom=0,endpoint={200,0},hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            
            
            
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={500,1200},movespeed=40.0,isRandom=0,endpoint={500,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={400,1200},movespeed=40.0,isRandom=0,endpoint={400,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={300,1200},movespeed=40.0,isRandom=0,endpoint={300,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={200,1200},movespeed=40.0,isRandom=0,endpoint={200,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
           
            
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={500,1200},movespeed=40.0,isRandom=0,endpoint={500,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={400,1200},movespeed=40.0,isRandom=0,endpoint={400,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={300,1200},movespeed=40.0,isRandom=0,endpoint={300,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=25,point={200,1200},movespeed=40.0,isRandom=0,endpoint={200,0},hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
         
          
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=32,point={400,1200},movespeed=60.0,isRandom=0,endpoint={400,0},hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={50,1200},endpoint={50,1000},movespeed=80,hp=4,attackspeed=2,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},
   



        },
        --中立怪物
        neutralMonster={ },

        bossMonster={ },

        honeyBee={ },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },


             backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_Normal,

        gameTime=0,
        gameCondition={

            GameCondition.Condition_Type_PlantsGold,

            GameCondition.Condition_Type_BeKillMonsterMainNum, 

        },
        KillMonsterMainNum = {12},
        PlantsGoal={1},
        
}

-- //////////////////////////////////////////////////////////////////////////////1_6/////////////////////////////////////////////////////
level1_20={

        battery={
            {point={200,1140},attackspeed={2,6,10,32,36,40,42,45,46,48,50,55},
                refreshtime=1,count=12,normalAtk={bulletInfo=bu3,damage=1,
                    mask=EnumAttackType.FARMLAND,duration=0,targetPoint={0,0},isRandomTable={1,1,1,1,1,1,1,1,1,1,1,1}}},

            {point={500,1140},attackspeed={2.6},refreshtime=24,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={500,0},isRandomTable={0}}},
            {point={450,1140},attackspeed={3.2},refreshtime=24,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={450,0},isRandomTable={0}}},
            {point={400,1140},attackspeed={3.8},refreshtime=24,count=1,normalAtk={bulletInfo=bu5,damage=1,
                mask=EnumAttackType.FARMLAND,duration=0,targetPoint={400,0},isRandomTable={0}}},


        },

        monster={
            
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=18,point={550,1200},movespeed=60.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

          --  {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=16,point={250,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

           -- {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=22,point={150,1200},movespeed=60.0,isRandom=1,hp=1.2,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            --            {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=28,point={350,1200},movespeed=50.0,isRandom=1,hp=3,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=30,point={350,1200},movespeed=60.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
            {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=38,point={350,1200},movespeed=60.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},

            --      {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={250,1200},movespeed=60.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        --    {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=10,point={450,1200},movespeed=60.0,isRandom=1,hp=1.2, normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,},},
        },
        remotemonster={
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=4,isMove=1,point={500,1200},endpoint={500,1000},movespeed=60,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=19,lavePoint={700,1200}},
                
            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=10,isMove=1,point={350,1200},endpoint={350,1100},movespeed=50,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1},leaveTime=12,leavePoint={-100,1000}},
                
            {m="arm0012",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=23,isMove=1,point={500,1200},endpoint={500,1000},movespeed=50,hp=2,attackspeed=4,
                        normalAtk={bulletInfo=bu2,damage=1,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},

            {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=33,isMove=1,point={350,1200},endpoint={350,980},movespeed=60,hp=2,attackspeed=4,
                normalAtk={bulletInfo=bu1,damage=1,mask=EnumAttackType.FARMLAND,duration=0,targetPoint={440,0},isRandom=0}},


        },
        --中立怪物
        neutralMonster={ },

        bossMonster={
         {m="bear",refreshtime=5,isMove=1,point={300,1140},endpoint={300,-10},movespeed=40.0,hitDistance=200,
         hitMoveSpeed=100,hp=50,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,}},
         
--            {m="bear",refreshtime=25,isMove=1,point={300,1140},endpoint={250,-10},movespeed=50.0,hitDistance=100,
--                hitMoveSpeed=100,hp=50,normalAtk={damage=1,mask=EnumAttackType.FARMLAND,duration=0,}},
        },

        honeyBee={
         {m="honeyBee",isLeft=true,refreshtime=1,isMove=1,point={80,950},honeyCount={3,4,5,6},patrolTime=15,
         honey={m="honey",a=50,b=50,maxA=190,maxB=150,aDistance=40,bDistance=50,moveInAnticlockwise=false},
         normalAtk={damage=10,mask=EnumAttackType.BOSS,duration=0,}},

         {m="honeyBee",isLeft=false,refreshtime=1,isMove=1,point={600,700},honeyCount={3,4,5,6},patrolTime=15,
         honey={m="honey",a=50,b=50,maxA=190,maxB=150,aDistance=40,bDistance=50,moveInAnticlockwise=false},
         normalAtk={damage=10,mask=EnumAttackType.BOSS,duration=0,}},
        },

        scratch={
            name="scratch001",
        },

        plants={
            hp=5,
            meisu="shucai1",
        },
             backgroundJpg={jpg1="battleScene1_1.jpg",
            jpg2="battleScene1_2.jpg",},

        gametype=GameType.Game_Type_boss_1,

        gameTime=0,
        gameCondition={
        
           GameCondition.Condition_Type_PlantsGold, 
            GameCondition.Condition_Type_PlantsGold, 
        },
        --levelhitrate={0.5},
        levelcritrate={0.5},
        --狸猫am0001
        --兔子am0002
        --猴子arm0011
        --松鼠arm0012
        --青蛙arm0013
        --羊sheep
        --熊boss bear
        PlantsGoal={0.5,1},

}
-- 苹果模式！！！！！！！！！！！！！！！！！！！！！！

level1_10={

        apple={
           n="apple.png",
            
        },
        collingNum=10,
        backgroundJpg={jpg="battleScene1.jpg"},
        scratch={
            name="scratch002",
        },
        --农民
        famer={
            type="famer_jump_1.png",
        },
        ceche={"famer"},

        gametype=GameType.Game_Type_Apple,
}

level1_16={

        apple={
            --{n="apple.png",point={300,600}},
            {n="apple.png",point={200,700}},
            {n="apple.png",point={430,830}},
            {n="apple.png",point={450,550}},
            {n="apple.png",point={450,595}},
            {n="apple.png",point={350,650}},
            {n="apple.png",point={250,950}},
            {n="apple.png",point={150,800}},
            {n="apple.png",point={150,530}},
            {n="apple.png",point={550,980}},
            {n="apple.png",point={450,880}},
            {n="apple.png",point={450,770}},
        },
        collingNum=10,
        backgroundJpg={jpg="battleScene1.jpg"},
        scratch={
            name="scratch002",
        },
        --农民
        famer={
            type="famer_jump_1.png",
        },
        ceche={"famer"},

        gametype=GameType.Game_Type_Apple,
}

--暂停模式
level1_7={
    monster={
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={150,1140},endpoint={150,900},movespeed=300,isRandom=0,hp=300,group=2,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={500,1140},endpoint={500,900},movespeed=300,isRandom=0,hp=300,group=2,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
            
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={350,1140},endpoint={390,900},movespeed=300,isRandom=0,hp=300,group=3,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
            
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1140},endpoint={280,900},movespeed=300,isRandom=0,hp=300,group=3,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
     
    },
    --   refreshtime刷新时间 isMove是否移动 point 初始点 endpoint 终点坐标  movespeed移动速度  targetPoint子弹目标坐标 isRandom 随机目标  1 为随机 0为不随机
    remotemonster={
        --                {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=0,isMove=0,point={500,900},endpoint={500,900},movespeed=3.0,targetPoint={320,0},isRandom=0,},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={500,1200},endpoint={400,650},movespeed=300.0,hp=10,attackspeed=1,group=1,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0}}},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={150,1140},endpoint={200,650},movespeed=300,hp=10,attackspeed=1,group=1,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={200,0}}},

        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={500,1200},endpoint={500,650},movespeed=300.0,hp=10,attackspeed=1,group=2,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0}}},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={150,1140},endpoint={150,650},movespeed=300,hp=10,attackspeed=1,group=2,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={200,0}}},
            
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={300,1140},endpoint={320,750},movespeed=300,hp=10,attackspeed=1,group=3,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=1}},


    },
    
    
    gametype=GameType.Game_Type_Pause,
    backgroundJpg={jpg="battleScene1.jpg"},
    scratch={
        name="scratch001",
    },
    ceche={"arm0011","arm0012","am0001","sheep","bear","honeyBee","am0002"
        ,"arm0013","monsterBullet"},
    sggAnimate={
        arm0011={atk=10,under=2,die=5,foot=4,},
        arm0012={atk=11,under=2,die=11,foot=8,},
        arm0013={atk=5,under=4,die=6,foot=5,},
        am0001={under=2,die=6,foot=4,},
        sheep={under=3,die=7,foot=5,},
        bear={atk=9,under=3,underbee=5,die=8,foot=8},
        honeyBee={under=5,foot=2,atk=2},
        am0002={under=2,die=6,foot=5,},
        xiaoniao={fly=2,hit=1,plume=5,},
    },
    
    
    pauseTime={4,4,4},
    pauseScratchNum={2,2,1},
    totaltime={1.5,1.5,1.5},
}

level1_13={
    monster={
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={150,1140},endpoint={100,900},movespeed=300,isRandom=0,hp=300,group=1,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
        {m="am0001",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={500,1140},endpoint={450,900},movespeed=300,isRandom=0,hp=300,group=1,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={150,1140},endpoint={200,1000},movespeed=300,isRandom=0,hp=300,group=1,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={500,1140},endpoint={550,1000},movespeed=300,isRandom=0,hp=300,group=1,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},


        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1140},endpoint={500,800},movespeed=300,isRandom=0,hp=300,group=3,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},
        {m="am0002",EnumMonsterSpecia =EnumMonsterSpecia.COMMON_MONSTER, refreshtime=1,point={300,1140},endpoint={120,800},movespeed=300,isRandom=0,hp=300,group=3,isMove=1,
            normalAtk={damage=10,mask=EnumAttackType.FARMLAND,duration=0,}},

    },
    --   refreshtime刷新时间 isMove是否移动 point 初始点 endpoint 终点坐标  movespeed移动速度  targetPoint子弹目标坐标 isRandom 随机目标  1 为随机 0为不随机
    remotemonster={
        --                {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=0,isMove=0,point={500,900},endpoint={500,900},movespeed=3.0,targetPoint={320,0},isRandom=0,},
    
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={500,1200},endpoint={500,800},movespeed=300.0,hp=10,attackspeed=1,group=1,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={400,0}}},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={150,1140},endpoint={150,800},movespeed=300,hp=10,attackspeed=1,group=1,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={200,0}}},

        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={500,1140},endpoint={200,700},movespeed=300,hp=10,attackspeed=1,group=2,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={640,0}}},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={100,1140},endpoint={400,700},movespeed=300,hp=10,attackspeed=1,group=2,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={1,0}}},
            
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={370,1140},endpoint={370,650},movespeed=300,hp=10,attackspeed=1,group=3,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={640,0}}},
        {m="arm0011",MonsterSpecia=EnumMonsterSpecia.COMMON_REMOTEMONSTER,refreshtime=1,isMove=1,point={250,1140},endpoint={250,650},movespeed=300,hp=10,attackspeed=1,group=3,
            normalAtk={bulletInfo=bu1,damage=10,mask=EnumAttackType.FARMLAND,duration=0,isRandom=0,targetPoint={1,0}}},
    },


    gametype=GameType.Game_Type_Pause,
    backgroundJpg={jpg="battleScene1.jpg"},
    scratch={
        name="scratch001",
    },
    ceche={"arm0011","arm0012","am0001","sheep","bear","honeyBee","am0002"
        ,"arm0013","monsterBullet"},
    sggAnimate={
        arm0011={atk=10,under=2,die=5,foot=4,},
        arm0012={atk=11,under=2,die=11,foot=8,},
        arm0013={atk=5,under=4,die=6,foot=5,},
        am0001={under=2,die=6,foot=4,},
        sheep={under=3,die=7,foot=5,},
        bear={atk=9,under=3,underbee=5,die=8,foot=8},
        honeyBee={under=5,foot=2,atk=2},
        am0002={under=2,die=6,foot=5,},
        xiaoniao={fly=2,hit=1,plume=5,},
    },


    pauseTime={4,4,4},
    pauseScratchNum={2,2,2},
    totaltime={1.5,2.0,1.5},
}


local levelTable={["SggGameCeche"]=SggGameCeche,["1001"]=guide1001,["1_1"]=level1_1,["1_2"]=level1_2,["1_3"]=level1_3,["1_4"]=level1_4,["1_5"]=level1_5,["1_6"]=level1_6,["1_7"]=level1_7,["1_8"]=level1_8
    ,["1_9"]=level1_9,["1_10"]=level1_10,["1_11"]=level1_11,["1_12"]=level1_12,["1_13"]=level1_13,["1_14"]=level1_14,["1_15"]=level1_15,["1_16"]=level1_16
    ,["1_17"]=level1_17,["1_18"]=level1_18,["1_19"]=level1_19,["1_20"]=level1_20}

    
function returnLevelTable(level)
    return levelTable[level]
end

function returnSceneTableCount()
    return 20
end
