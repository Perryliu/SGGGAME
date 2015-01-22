require "Helper"

-- ///////////////////////音效//////////////////////////////////////
--音效
playEffectConstant={
    _DIANJIBUTTON_=1,
    _GONGJISUCAI_=2,
    _LOSTEFFECT_=3,
    _WINEFFECT_=4,
    _JIZHONG_=5,
    _LOGO_=6,
    _FANTAN_=7,
}

--播放类型
MusicType={
    _BACKGROUNDMUSIC_=0,
    _EFFECTMUSIC_=1,
}

--背景音乐
ENUMBACKGROUND={
    _BGM_=0,
}
-- ///////////////////////音效//////////////////////////////////////


--///////////////////////怪物tag///////////////////////////////////
--远程 炮台 tag
weaponEnum={
    weaponTag=100,
}

--近战怪物的tag
monsterEnum={
    monsterTag=1000,
}

--中立怪物的tag
neutralEnum={
    neutralTag=1500,
}

--蜜蜂tag
HoneyBeeEnum={
    honeyBeelTag=2000,
}

--熊tag
BaerBossEnum={
    baerBossTag=2100,
}
--///////////////////////怪物tag///////////////////////////////////


--///////////////////////重力引擎组///////////////////////////////////
BattleUtils={}

BattleGroup={
    BulletGroup=1,
    ScratchGroup=2,
    BoundBoyGroup=3,
    CannonGroup=4,
    NeutralGroup=5,
    MonsterGroup=6,
    BulletReboundGroup=7,
    UserFarmlandGroup=8,
    BossMonsterGroup=9,
    HoneyBeeGroup=10,
}
--///////////////////////重力引擎组///////////////////////////////////

--//////////////////////怪物动作/////////////////////////////////////
GameAUEnum={
    CannonMoveTag=10,
    CannonHitTag=11, 
     
    MonsterMoveTag=100,
    
    NeutralMoveTag=200,
}

--//////////////////////怪物动作/////////////////////////////////////

--//////////////////////怪物数据标志/////////////////////////////////////
BattleDataPool={
    WEAPON_POOL = "WEAPON_POOL",
    MONSTER_POOL = "MONSTER_POOL",
    NUETRAL_POOL = "NUETRAL_POOL",
    BOSS_POOL = "BOSS_POOL",
}

--//////////////////////怪物数据标志/////////////////////////////////////


--//////////////////////中立怪物三种状态/////////////////////////////////////
NeutraStatus={
    Neutral_None = 1,         --中立
    Neutral_Enemy = 2,        --变为敌人
    Neutral_Ally = 3,         --变为盟友
}

--//////////////////////中立怪物三种状态/////////////////////////////////////

--//////////////////////进战怪物三种类型/////////////////////////////////////
MonsterType={
    Monster_Type_Normal = 1,                 --默认
    Monster_Type_Invincible = 2,             --无敌
    Monster_Type_Invincible_Hit = 3,         --无敌但受击
}

--//////////////////////进战怪物三种类型/////////////////////////////////////

--//////////////////////boss 动作类型/////////////////////////////////////
BossMonsterAType={
    BMA_Type_Move = 101,                --进攻
    BMA_Type_hitMove = 102,             --受击后退
    BMA_Type_honeyHitMove = 103,        --受击后退
}

--//////////////////////boss 动作类型/////////////////////////////////////

--//////////////////////动作缓冲类型/////////////////////////////////////
animationEaseType = {
   SpriteEaseSineOut=1,
--    SpriteEase,
--    SpriteEaseInOut,
--    SpriteEaseExponential,
--    SpriteEaseExponentialInOut,
--    SpriteEaseSineIn,
    
--    SpriteEaseElastic,
--    SpriteEaseElasticInOut,
--    SpriteEaseBounce,   
--    SpriteEaseBounceInOut,  
--    SpriteEaseBack, 
--    SpriteEaseBackInOut,
}
--//////////////////////动作缓冲类型/////////////////////////////////////


--//////////////////////怪物类型冲类型/////////////////////////////////////
EnumRaceType = 
    { 
        "MONSTER",          --怪物
        "REMOTEMONSTER",    --远程怪物
        "NEUTRALMONSTER",   --中立怪物
        "BAERBOSS",         --熊boss
        "HONEYBEE",         --蜜蜂
        "BULLET",           --子弹
        "FARMLAND",         --农田
        "PROPS",            --道具
        "BETTARY",          --炮台
    }

EnumRaceType = CreateEnumTable(EnumRaceType)     
--//////////////////////怪物类型冲类型/////////////////////////////////////

--//////////////////////攻击类型/////////////////////////////////////
EnumAttackType = 
    { 
        "FARMLAND",          --只能攻击农场
        "ENEMY",             --攻击所有敌人和中立怪
        "BOSS",              --只攻击boss
        "ANYTHING",          --任何物体
        "MONSTER",           --攻击所有敌人
        
    }

EnumAttackType = CreateEnumTable(EnumAttackType)     
--//////////////////////攻击类型/////////////////////////////////////

--//////////////////////怪物状态类型/////////////////////////////////////
EnumStateType =
    {
        "IDLE",
        "WALKING",
        "ATTACKING",
        "DEFENDING",
        "JUMPING",
        "KNOCKING",
        "DYING",
        "DEAD"
    }
EnumStateType = CreateEnumTable(EnumStateType) 
--//////////////////////怪物状态类型/////////////////////////////////////

--//////////////////////怪物状态类型/////////////////////////////////////
EnumMonsterTypeHit =
    {
        "K_Monster_Type_Normal",                   --默认类型
        "K_Monster_Type_Invincible",               --无敌不可攻击
        "K_Monster_Type_Invincible_Hit",           --无敌子弹可以攻击
    }
EnumMonsterTypeHit = CreateEnumTable(EnumMonsterTypeHit) 
--//////////////////////怪物状态类型/////////////////////////////////////

--//////////////////////道具类型/////////////////////////////////////
EnumPropskType = 
    { 
        "SINGLE",            --单体作用
        "ANYTHING",          --所有作用
        "RANGE",             --范围作用
    }

EnumPropskType = CreateEnumTable(EnumPropskType)     
--//////////////////////道具类型/////////////////////////////////////

--//////////////////////怪物特性类型/////////////////////////////////////
EnumMonsterSpecia = 
    { 
        "COMMON_MONSTER",                       --普通近站怪物
        "COMMON_REMOTEMONSTER",                 --普通远程怪物
        "BLAST_MONSTER",                        --自爆近战怪物
        "SUSLIKS_REMOTEMONSTER",                --地鼠远程怪物
        "HIPPO_MONSTER",                        --河马近战怪物
        "TORTOISE_MONSTER",                     --乌龟近战怪物
        "JUMP_MONSTER",                         --跳跃近战怪物
        "CONTINUATION_REMOTEMONSTER",           --连续发射子弹远程怪物
    }

EnumMonsterSpecia = CreateEnumTable(EnumMonsterSpecia)     
--//////////////////////怪物特性类型/////////////////////////////////////


--狸猫am0001
--兔子am0002
--猴子arm0011
--松鼠arm0012
--青蛙arm0013
--羊sheep
--熊boss bear
MonsterNameType=
    {
        ["am0001"]=1,
        ["am0001"]=1,
        ["am0001"]=1,
        ["am0001"]=1,
        ["am0001"]=1,
        ["am0001"]=1,
        ["am0001"]=1,
    }
