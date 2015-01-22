require "GameDirectorUtils"
require "Data_Level"
--GameCondition ={
 --   Condition_Type_ScratchLength=2,         --消耗挡板长度
 --   Condition_Type_ScratchTimes=3,          --命中率  
 --   Condition_Type_ScratchCritRate=4,       --暴击率
 --   Condition_Type_PlantsGold=5,            --植物得分
 --   Condition_Type_TimeClock=6,             --时间计时  到时间就输
--}



local GameJudge = class("GameJudge")


function GameJudge.create()
    local gm = GameJudge.new()
    --gm:initdata()
    return gm
end
function GameJudge:initdata()
	self.GameData=nil
	self.ScratchMainTimes=0
	self.ScratchHitrate=0
	self.ScratchMainLength=0
	self.BeUseScratchLength=0
    self.MainPlants=0
    self.CurPlants=nil
    self.BeCritScratch=0
    self.KillMonsterNum={}
    self.MainKillMonsterNum=0
    self.NotKillMonsterNum={}
end

function GameJudge:setCurJudgeData()
    self:initdata()
	self:getGameJudgement()
    self:setMainPlants()
	--local gameCondition=self.GameData.gameCondition
    local condit=self.GameData.gameCondition
    
    if condit[1]==condit[2] then
        self.conditionSame=true
    else
        self.conditionSame=false
    end
    
    self.isKillMonsterCondition=false
    for var=1,#condit do
        local key=string.format("Condition_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
        local cond=cc.UserDefault:getInstance():setIntegerForKey(key,condit[var]);
--        if condit[var]==2 then
--            
--        end
        if condit[var]==2 then
            if self.conditionSame then
                local ScratchMainlength=self.GameData.ScratchMainlength[var]
                local str=string.format(" %s-","Scratch length")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",ScratchMainlength)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            else
                local ScratchMainlength=self.GameData.ScratchMainlength[1]
                local str=string.format(" %s-","Scratch length")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)

                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",ScratchMainlength)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            end
        end
        if condit[var]==3 then
            if self.conditionSame then
                local levelhitrate=self.GameData.levelhitrate[var]*100
                local str=string.format(" %s-","Hit rate")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d%s",levelhitrate,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
            else
                local levelhitrate=self.GameData.levelhitrate[1]*100
                local str=string.format(" %s-","Hit rate")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d%s",levelhitrate,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
            end
        end
        if condit[var]==4 then
            if self.conditionSame then
                local levelcritrate=self.GameData.levelcritrate[var]*100
                local str=string.format(" %s-","Crit rate")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d %s",levelcritrate,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            else
                local levelcritrate=self.GameData.levelcritrate[1]*100
                local str=string.format(" %s-","Crit rate")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d%s",levelcritrate,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            end
        end
        
        if condit[var]==5 then
            if self.conditionSame then
                local PlantsGoal=self.GameData.PlantsGoal[var]*100
                local str=string.format(" %s-","Plants gain")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d%s",PlantsGoal,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
            else
                local PlantsGoal=self.GameData.PlantsGoal[1]*100
                local str=string.format(" %s-","Plants gain")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d%s",PlantsGoal,"%")
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            end
        end
        
        if condit[var]==6 then
            self.isKillMonsterCondition=true
            local monsterName
            if self.conditionSame then
                self.KillMonsterNum[var]=0
                monsterName=self.GameData.KillMonster.monstertype[var]
                local monsterNum=self.GameData.KillMonster.amount[var]
                local monsterType=BattleUtils.ReturnMonsterTypeForConditionLayer(monsterName)
                local str=string.format(" %s-",monsterType)
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",monsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
            else
                self.KillMonsterNum[1]=0
                monsterName=self.GameData.KillMonster.monstertype[1]
                local monsterNum=self.GameData.KillMonster.amount[1]
                local monsterType=BattleUtils.ReturnMonsterTypeForConditionLayer(monsterName)
                local str=string.format(" %s-",monsterType)
                
                
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",monsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
            end
        end
        
        
        if condit[var]==7 then
            self.isNotKillMonsterCondition=true
            local monsterName
            if self.conditionSame then
                
                self.NotKillMonsterNum[var]=0
                monsterName=self.GameData.NotKillMonster.monstertype[var]
                local monsterNum=self.GameData.NotKillMonster.amount[var]
                local monsterType=BattleUtils.ReturnNotMonsterTypeForConditionLayer(monsterName)
                local str=string.format(" %s-",monsterType)
                
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",monsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)

            else
                self.NotKillMonsterNum[1]=0
                monsterName=self.GameData.NotKillMonster.monstertype[1]
                local monsterNum=self.GameData.NotKillMonster.amount[1]
                local monsterType=BattleUtils.ReturnNotMonsterTypeForConditionLayer(monsterName)
                local str=string.format(" %s-",monsterType)
                
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",monsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
                
                
            end
        end
        if condit[var]==8 then
            if self.conditionSame then
                local MainMonsterNum=self.GameData.KillMonsterMainNum[var]
                local str=string.format("%s-","Critters")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",MainMonsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            else
                local MainMonsterNum=self.GameData.KillMonsterMainNum[1]
                local str=string.format("%s-","Critters")
                local key = string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                cc.UserDefault:getInstance():setStringForKey(key,str)
                
                local keynum = string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
                local strnum= string.format(" %d",MainMonsterNum)
                cc.UserDefault:getInstance():setStringForKey(keynum,strnum)
            end
            
        end
        
    end
    
	cc.UserDefault:getInstance():flush()
	
end

--local GameData=nil
--local ScratchMainTimes=0
--local ScratchHitrate=0
--local ScratchMainLength=0
--local BeUseScratchLength=0
--local MainPlants=0
--local CurPlants=nil
--
--local BeCritScratch=0
--获得关卡数据
function GameJudge:getGameJudgement()
    self.GameData = returnLevelTable(DirectorUtils.getCurSceneLevel())
end
--增加总量被击打挡板数  用来评价命中率                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
function GameJudge:addScratchMainTimes()
    print("self.ScratchMainTimes===",self.ScratchMainTimes)
    self.ScratchMainTimes=self.ScratchMainTimes+1
    print("self.ScratchMainTimes===",self.ScratchMainTimes)
end
--增加击打怪物数  用来评价命中率              击打怪物数/总板子数量
function GameJudge:addScratchHitRate()
    print("self.ScratchHitrate===",self.ScratchHitrate)
    self.ScratchHitrate=self.ScratchHitrate+1
    print("self.ScratchHitrate===",self.ScratchHitrate)
end
--击杀目标怪物数量
function GameJudge:addTargetMonsterDeadNum(sprite)
    local monstertype=self.GameData.KillMonster.monstertype
    if monstertype~=nil then
        for var=1,#monstertype do
            if sprite.m==monstertype[var] then
                self.KillMonsterNum[var]=self.KillMonsterNum[var]+1
            end
        end
    end
end
--击杀怪物总数量
function GameJudge:addMainMonsterDeadNum(sprite)
    if sprite.m=="sheep" then
        return
    end
    self.MainKillMonsterNum=self.MainKillMonsterNum+1
end

--不能击杀怪物数量
function GameJudge:addNotKillMonsterDeadNum(sprite)
    local monstertype=self.GameData.NotKillMonster.monstertype
    if monstertype~=nil then                        
        for var=1,#monstertype do
            if sprite.m==monstertype[var] then
                self.NotKillMonsterNum[var]=self.NotKillMonsterNum[var]+1
            end
        end
    end
end

--暴击次数
function GameJudge:addCritScratch()
    print("self.BeCritScratch===",self.BeCritScratch)
    self.BeCritScratch=self.BeCritScratch+1
    print("self.BeCritScratch===",self.BeCritScratch)
end


--被使用的挡板长度  这里需要反弹才生效 用来计算滑动挡板 被使用的长度
function GameJudge:BeUseSratchLength(leng)
    self.BeUseScratchLength=self.BeUseScratchLength+leng
end
--获取当前关卡的总共的挡板生成长度
function GameJudge:setUseScratchLength()
    self.ScratchMainLength=self.GameData.ScratchMainlength
end

--设置总植物血量
function GameJudge:setMainPlants()
    self.MainPlants=self.GameData.plants.hp
    self.CurPlants=self.MainPlants
    --return self.MainPlants
end

--植物扣血
function GameJudge:PlantsSubHp(hp)
    if self.CurPlants==nil then
        self.CurPlants=self.MainPlants
    end
    self.CurPlants=self.CurPlants-hp
end

function GameJudge:DisposeCondition()
    local GameCondition=self.GameData.gameCondition

	
	  -- local MainGold=0.3
        
	   for var=1,#GameCondition,1 do 
	           --消耗长度
	       if GameCondition[var]==2 then
	            local _isbool
	            
	            if self.conditionSame==true then
                    self.ScratchMainLength[1]=self.GameData.ScratchMainlength[1]
                    self.ScratchMainLength[2]=self.GameData.ScratchMainlength[2]
                    if self.BeUseScratchLength<self.ScratchMainLength[var] then
                        _isbool=true
                    else
                        _isbool=false
                    end
                else
                    self.ScratchMainLength[1]=self.GameData.ScratchMainlength[1]
                    
                    if self.BeUseScratchLength<self.ScratchMainLength[1] then
                        _isbool=true
                    else
                        _isbool=false
                    end
	            end
	            
                if _isbool then
                    --MainGold=MainGold+0.3
                    local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
	            end
	            
                local curnum = self.BeUseScratchLength
                local str= string.format("%d",curnum)
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
                
	            
	           --命中率
	       elseif GameCondition[var]==3 then
                --local LevelHitRate=self.GameData.levelhitrate
                local curHitRate=self.ScratchHitrate/self.ScratchMainTimes
                if self.ScratchMainTimes==0 then
                    curHitRate=0
                end
                
                local _isbool
                local LevelHitRate
                if self.conditionSame==true then
                    LevelHitRate=self.GameData.levelhitrate[var]
                    
                    if curHitRate>=LevelHitRate then
                        _isbool=true
                    else
                        _isbool=false
                    end
                else
                    LevelHitRate=self.GameData.levelhitrate[1]
    
                    if curHitRate>=LevelHitRate then
                        _isbool=true
                    else
                        _isbool=false
                    end
                end
            
            
                if _isbool then
                    --MainGold=MainGold+0.3
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                
                local curnum = curHitRate
                local str= string.format("%d %s",curnum,"%")
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
            
                --暴击
	       elseif GameCondition[var]==4 then
	            
                local curCritRate=self.BeCritScratch/self.ScratchMainTimes
                local LevelCritRate
                if self.ScratchMainTimes==0 then
                    curCritRate=0
                end
                
                local _isbool
                local LevelHitRate
                if self.conditionSame==true then
                    LevelCritRate=self.GameData.levelcritrate[var]
                    
                    if curCritRate>=LevelHitRate then
                        _isbool=true
                    else
                        _isbool=false
                    end
                else
                    LevelHitRate=self.GameData.levelcritrate[1]
    
                    if curCritRate>=LevelHitRate then
                        _isbool=true
                    else
                        _isbool=false
                    end
                end
                
                
                
                
                
                if _isbool then
                    --MainGold=MainGold+0.3
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                --当前暴击率
                local curnum = curCritRate*100
                local str= string.format("%d %s",curnum,"%")
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
                
                
                
                --植物得分
            elseif GameCondition[var]==5 then
                
                local curScore=self.CurPlants/self.MainPlants
                local LevelPlantsGoal
                local _isbool
               
                if self.conditionSame==true then
                    LevelPlantsGoal=self.GameData.PlantsGoal[var]
    
                    if curScore>=LevelPlantsGoal then
                        _isbool=true
                    else
                        _isbool=false
                    end
                else
                    LevelPlantsGoal=self.GameData.PlantsGoal[1]
    
                    if curScore>=LevelPlantsGoal then
                        _isbool=true
                    else
                        _isbool=false
                    end
                end
            
            
                
                if curScore>= LevelPlantsGoal then
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                --当前植物剩余百分比
                local curnum = curScore*100
                local str= string.format("%d %s",curnum,"%")
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
           
                    --击杀某种怪物数量
            elseif GameCondition[var]==6 then
                local LevelKillMonsterGoal=self.GameData.KillMonster.amount
                
                
                local LevelKillMonsterGoal
                local _isbool
                local curnum
                if self.conditionSame==true then
                    LevelKillMonsterGoal=self.GameData.KillMonster.amount[var]
    
                    if self.KillMonsterNum[var]>=LevelKillMonsterGoal then
                        _isbool=true
                    else
                        _isbool=false
                    end
                    curnum = self.KillMonsterNum[var]
                else
                    LevelKillMonsterGoal=self.GameData.KillMonster.amount[1]
    
                    if self.KillMonsterNum[1]>=LevelKillMonsterGoal then
                        _isbool=true
                    else
                        _isbool=false
                    end
                    curnum = self.KillMonsterNum[1]
                end
                if _isbool then
                    local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                    local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                --当前击杀某种怪物数量
                
                local str= string.format("%d",curnum)
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
	        
	        --不可击杀某种怪物数量
            elseif GameCondition[var]==7 then
                --local LevelKillMonsterGoal=self.GameData.NotKillMonster.amount
                local LevelNotKillMonsterGoal
                local _isbool
                local curnum
                if self.conditionSame==true then
                    LevelNotKillMonsterGoal=self.GameData.NotKillMonster.amount[var]
                    
                    if self.NotKillMonsterNum[var]>=LevelNotKillMonsterGoal then
                        _isbool=true
                    else
                        _isbool=false
                    end
                    curnum = self.NotKillMonsterNum[var]
                else
                    LevelNotKillMonsterGoal=self.GameData.NotKillMonster.amount[1]
    
                    if self.NotKillMonsterNum[1]>=LevelNotKillMonsterGoal then
                        _isbool=false
                    else
                        _isbool=true
                    end
                    curnum = self.NotKillMonsterNum[1]
                end
                if _isbool then
                    local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                    local key = string.format("boolCondition_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                
                --当前不可击杀某种怪物数量
                
                local str= string.format("%d",curnum)
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
            
            
            
                --击杀怪物总量
            elseif GameCondition[var]==8 then
                --local LevelKillMonsterGoal=self.GameData.NotKillMonster.amount
                local LevelMainMonsterNum
                local _isbool
    
                if self.conditionSame==true then
                    LevelMainMonsterNum=self.GameData.KillMonsterMainNum[var]
    
                    if self.MainKillMonsterNum>=LevelMainMonsterNum then
                        _isbool=true
                    else
                        _isbool=false
                    end
                else
                    LevelMainMonsterNum=self.GameData.KillMonsterMainNum[1]
    
                    if self.MainKillMonsterNum>=LevelMainMonsterNum then
                        _isbool=true
                    else
                        _isbool=false
                    end
                end
                if _isbool then
                    local key = string.format("boolCondition_%d_%d_%d"
                        ,DirectorUtils.getCurScene()
                        ,DirectorUtils.getCurLevel()
                        ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,true)
                else
                    local key = string.format("boolCondition_%d_%d_%d"
                        ,DirectorUtils.getCurScene()
                        ,DirectorUtils.getCurLevel()
                        ,var)
                    cc.UserDefault:getInstance():setBoolForKey(key,false)
                end
                
                --当前不可击杀某种怪物数量
                local curnum = self.MainKillMonsterNum
                local str= string.format("%d",curnum)
                local key1 = string.format("CurCondNum_%d_%d_%d"
                    ,DirectorUtils.getCurScene()
                    ,DirectorUtils.getCurLevel()
                    ,var)
                cc.UserDefault:getInstance():setStringForKey(key1,str)
          end
	       
	       
	   end
end


return GameJudge

