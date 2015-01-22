require"Cocos2d"
require"GameDirectorUtils"

local isPass= "Pass"
local ScratchLength="Scratch length"
local HitRate="Hit rate"
local CritRate="Crit rate"
local CropGoal="Crops score"
local Critters="Critters"
--local

local skillone=string.format("%s","aaaaaa  aaaaaaaa aaaaaa aaaaaaaaaaaa  aaaaaaa aaaaaaaaa  aaaaaaa aaaaaa" )
local skilltwo="bbbbbbbb bbbbbbbb bbb bbbbbb bbbbbb bbbbbbb bbbbbbbbbbb bbbbbbb bbbbb bbbbbbbb bbbbbbbbbbb bbbbbbbbbbbbbbbbbb" 
local skillthree="ccccccccc ccccccc ccccccccccccccc cccccccccccc cccccccccccc cccccccccccc ccccccc ccccccccccccccccc" 
local skillfour="ddd ddd dd dddd dddd dd dd ddd ddd dddddd dd ddd dd dddd ddd ddd dddddd ddd dddd dddddd dddddd ddd ddd dddddd ddddddd ddd dddddddddddd" 
local skillfive="eeeeeeeee eeeeeeeeee eeeeee eeeeee eeeeeeeee eeeeee eeeeeee eeeeeeeeee eeeeeee eeeeee" 

local skilltable={skillone,skilltwo,skillthree,skillfour,skillfive}
local targettag  
local targetNumber
local ConditionLayer =class("ConditionLayer",function()
    return cc.Layer:create();
end)

function ConditionLayer.create()      
    local layer=ConditionLayer.new()
    layer:initLayer()
    layer:addTouchListener(layer)
--    local layer=cc.Layer:create();
    return layer
end

local function Cancel(sender)
   local scene= GameUIManager:GameStateChoose(4)
   cc.Director:getInstance():replaceScene(scene)
end

local function Confirm(sender)
    gameScene:openAllSchedule()
    CONDITIONLAYER:removeFromParent()
end



function ConditionLayer:initLayer()

    local winSize=cc.Director:getInstance():getWinSize()
    local biaojipoint
    local biaojisize
    local userdata=returnLevelTable(DirectorUtils.getCurSceneLevel())
    
    
    local bg = cc.Sprite:create("dian.png");
    bg:setScaleX(winSize.width/bg:getContentSize().width);
    bg:setScaleY(winSize.height/bg:getContentSize().height);
    bg:setPosition(cc.p(winSize.width/2,winSize.height/2));
    self:addChild(bg,3);

    local _starTypeSequence={};
    _starTypeSequence[1]=1;
    
    local key_1=string.format("Condition_%d_%d_1",UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel())
    --sprintf(key_1,"Condition_%d_%d_1",UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel());
    local condition1=userdata.gameCondition[1]
    _starTypeSequence[2]=condition1
    local key_1=string.format("Condition_%d_%d_2",UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel())
    --sprintf(key_1,"Condition_%d_%d_2",UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel());
    local condition2=userdata.gameCondition[2]
    _starTypeSequence[3]=condition2

    local _starType={}
    
    for var=1,#_starTypeSequence do 
        local gameData=returnLevelTable(DirectorUtils.getCurSceneLevel())
        if _starTypeSequence[var]==1 then
            local keystar=string.format("%d.%s",var,isPass)
            _starType[var]=keystar
        elseif _starTypeSequence[var]==2 then
            if gameJudge.conditionSame then
                local keyNumber=gameData.ScratchMainlength[var-1]
                local keystar=string.format("%d.%s - %d",var,ScratchLength,keyNumber)
                _starType[var]=keystar
            else
                local keyNumber=gameData.ScratchMainlength[1]
                local keystar=string.format("%d.%s - %d",var,ScratchLength,keyNumber)
                _starType[var]=keystar
            end
        elseif _starTypeSequence[var]==3 then
            if gameJudge.conditionSame then
                local keyNumber=gameData.levelhitrate[var-1]*100
                local keystar=string.format("%d.%s - %d ",var,HitRate,keyNumber)
                _starType[var]=keystar
            else
                local keyNumber=gameData.levelhitrate[1]*100
                local keystar=string.format("%d.%s - %d ",var,HitRate,keyNumber)
                _starType[var]=keystar
            end
        elseif _starTypeSequence[var]==4 then
            if gameJudge.conditionSame then
                local keyNumber =gameData.levelcritrate[var-1]*100
                local keystar=string.format("%d.%s - %d ",var,CritRate,keyNumber)
                _starType[var]=keystar
            else
                local keyNumber =gameData.levelcritrate[1]*100
                local keystar=string.format("%d.%s - %d ",var,CritRate,keyNumber)
                _starType[var]=keystar
            end
            
        elseif _starTypeSequence[var]==5 then
            if gameJudge.conditionSame then
                local keyNumber= gameData.PlantsGoal[var-1]*100
                local keystar=string.format("%d.%s - %d %s",var,CropGoal,keyNumber,"%")
                _starType[var]=keystar
               
            else
                local keyNumber= gameData.PlantsGoal[1]*100
                local keystar=string.format("%d.%s - %d ",var,CropGoal,keyNumber)
                _starType[var]=keystar
            end
            
        elseif _starTypeSequence[var]==6 then
            
            --KillMonster={monstertype="arm0011",amount=10},
            if gameJudge.conditionSame then
                local name=gameData.KillMonster.monstertype[var-1]
                local str=BattleUtils.ReturnMonsterTypeForConditionLayer(name)
                local keyNumber= gameData.KillMonster.amount[var-1]
                local keystar=string.format("%d.%s- %d",var,str,keyNumber)
                _starType[var]=keystar
            else
                local name=gameData.KillMonster.monstertype[1]
                local str=BattleUtils.ReturnMonsterTypeForConditionLayer(name)
                local keyNumber= gameData.KillMonster.amount[1]
                local keystar=string.format("%d.%s- %d",var,str,keyNumber)
                _starType[var]=keystar
            end
        elseif _starTypeSequence[var]==7 then

            --KillMonster={monstertype="arm0011",amount=10},
            if gameJudge.conditionSame then
                local name=gameData.NotKillMonster.monstertype[var-1]
                local str=BattleUtils.ReturnNotMonsterTypeForConditionLayer(name)
                local keyNumber= gameData.NotKillMonster.amount[var-1]
                local keystar=string.format("%d.%s- %d",var,str,keyNumber)
                _starType[var]=keystar
            else
                local name=gameData.NotKillMonster.monstertype[1]
                local str=BattleUtils.ReturnNotMonsterTypeForConditionLayer(name)
                local keyNumber= gameData.NotKillMonster.amount[1]
                local keystar=string.format("%d.%s- %d",var,str,keyNumber)
                _starType[var]=keystar
            end
        elseif _starTypeSequence[var]==8 then

            --KillMonster={monstertype="arm0011",amount=10},
            if gameJudge.conditionSame then
                local keyNumber=gameData.KillMonsterMainNum[var-1]
                local keystar=string.format("%d.%s - %d ",var,Critters,keyNumber)
                _starType[var]=keystar
            else
                local keyNumber=gameData.KillMonsterMainNum[1]
                local keystar=string.format("%d.%s - %d ",var,Critters,keyNumber)
                _starType[var]=keystar
            end   
        end
    end
    
    --LEVEL
    local levelstr=string.format("Level %d",DirectorUtils.getCurLevel())
    local levellabel=cc.Label:createWithTTF(levelstr,"fonts/QuicksandBold-Regular.otf",60);
    levellabel:setColor(cc.c3b(255,215,0))
    levellabel:setPosition(cc.p(winSize.width/2,winSize.height/6*5))
    self:addChild(levellabel,6)
    --条件 
    for var=0,2  do
        local levelstar=cc.Sprite:create("over_star_1.png")
        levelstar:setPosition(cc.p(winSize.width/2+(var-1)*1.5*levelstar:getContentSize().width
            ,levellabel:getPositionY()-levellabel:getContentSize().height/2-levelstar:getContentSize().height/2-10))
        self:addChild(levelstar,6)

        local str
        local key
        if var==0 then
            str=" Pass"
            str=string.format("%d.%s",var+1,str)
            local levelstarLabel = cc.Label:createWithTTF(str,"Frozen.ttf",30)

            levelstarLabel:setPosition(cc.vertex2F(winSize.width/5+levelstarLabel:getContentSize().width/2,
                levelstar:getPositionY()-levelstar:getContentSize().height/2-levelstarLabel:getContentSize().height/2-var*(levelstar:getContentSize().height+4)))
            levelstarLabel:setColor(cc.c3b(255,215,0))
            self:addChild(levelstarLabel,6)
        else
            key=string.format("CondStr_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
            str = cc.UserDefault:getInstance():getStringForKey(key)
            str=string.format("%d.%s",var+1,str)
            
            local levelstarLabel = cc.Label:createWithTTF(str,"Frozen.ttf",30)

            levelstarLabel:setPosition(cc.vertex2F(winSize.width/5+levelstarLabel:getContentSize().width/2,
                levelstar:getPositionY()-levelstar:getContentSize().height/2-levelstarLabel:getContentSize().height/2-var*(levelstar:getContentSize().height+4)))
            levelstarLabel:setColor(cc.c3b(255,215,0))
            self:addChild(levelstarLabel,6)
            
            local key1=string.format("CondNum_%d_%d_%d",DirectorUtils.getCurScene(),DirectorUtils.getCurLevel(),var)
            local str1 = cc.UserDefault:getInstance():getStringForKey(key1)
            str1=string.format("%s",str1)
            
            local levelNumLabel = cc.Label:createWithTTF(str1,"Frozen.ttf",40)

            levelNumLabel:setPosition(cc.vertex2F(levelstarLabel:getPositionX()+levelstarLabel:getContentSize().width/2+levelNumLabel:getContentSize().width/2,
                levelstarLabel:getPositionY()-(levelNumLabel:getContentSize().height-levelstarLabel:getContentSize().height)/4))
            levelNumLabel:setColor(cc.c3b(255,100,0))
            self:addChild(levelNumLabel,6)
            
            biaojipoint={x,y}
            biaojipoint.x=levelstarLabel:getPositionX()
            biaojipoint.y=levelstarLabel:getPositionY()
            biaojisize=levelstarLabel:getContentSize().height
        end
    end
    
    
    
    --升级底板
    
    
    local Leveldibanbg = cc.Sprite:create("bg_banzi.png")
    Leveldibanbg:setPosition(cc.p(winSize.width/2,
        biaojipoint.y-biaojisize/2-Leveldibanbg:getContentSize().height/2-35
    ))
    self:addChild(Leveldibanbg,3)
    
    
    
    --按钮
    local menu1=cc.Menu:create()
    local button_left=cc.MenuItemImage:create("Menu_button_normal.png"
        ,"Menu_button_select.png"
        )
    button_left:setPosition(cc.p(-110,
        -winSize.height/2+Leveldibanbg:getPositionY()-Leveldibanbg:getContentSize().height/2-button_left:getContentSize().height/2));
    button_left:setScale(0.5);
    button_left:registerScriptTapHandler(Cancel)
    local label_left = cc.Label:createWithTTF("CANCEL","fonts/QuicksandBold-Regular.otf",30);
    

    label_left:setPosition(cc.vertex2F(winSize.width/2-110,
        Leveldibanbg:getPositionY()-Leveldibanbg:getContentSize().height/2-button_left:getContentSize().height/2))

    label_left:setColor(cc.c3b(65,40,25))

   
    self:addChild(label_left,6)


    local button_right=cc.MenuItemImage:create("Menu_button_normal.png"
        ,"Menu_button_select.png")
    button_right:setPosition(cc.p(110,
        -winSize.height/2+Leveldibanbg:getPositionY()-Leveldibanbg:getContentSize().height/2-button_left:getContentSize().height/2))
    button_right:setScale(0.5)
    button_right:registerScriptTapHandler(Confirm)
    local label_right = cc.Label:createWithTTF("START","fonts/QuicksandBold-Regular.otf",30)
  
    label_right:setPosition(cc.vertex2F(winSize.width/2+110,
        Leveldibanbg:getPositionY()-Leveldibanbg:getContentSize().height/2-button_left:getContentSize().height/2))

    label_right:setColor(cc.c3b(65,40,25))

   
    self:addChild(label_right,6)



    menu1:addChild(button_left)



    menu1:addChild(button_right)
    self:addChild(menu1,5)
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    local function onTouchBegan(touch,event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        if cc.rectContainsPoint(rect, locationInNode) then
            targettag=target:getTag()
            if targettag>=3001 and targettag<=3005 then
                local skillCheckBox= self:getChildByTag(targettag)
                if skillCheckBox._isCanBuy then
                    skillCheckBox:setTexture("levelup_select.png")
                    return true
                else
                    return false
                end
            end
            return true
        end
        return false
    end


    local function onTouchEnded(touch,event)
    
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        if cc.rectContainsPoint(rect, locationInNode) then
            local target = event:getCurrentTarget()
            if targettag==target:getTag() then
                if targettag>=1001 and targettag<=1005 then
                    local skillCheckBox= self:getChildByTag(targettag+1000)
                    if skillCheckBox._isSelect==false then
                        if targetNumber<2 then
                            skillCheckBox:setTexture("Skill_select.png")
                            skillCheckBox._isSelect=true
                            targetNumber=targetNumber+1
                        end

                    else
                        skillCheckBox:setTexture("Skill_normal.png")
                        skillCheckBox._isSelect=false
                        targetNumber=targetNumber-1
                    end
                    local select_bg = self:getChildByTag(675)
                    select_bg:setPosition(cc.p(target:getPositionX(),target:getPositionY()))
                    local jieshaolabel = self:getChildByTag(9999)
                    jieshaolabel:setString(skilltable[targettag-1000])
                    
                elseif targettag>=3001 and targettag<=3005 then
                    local skilllevelup= self:getChildByTag(targettag)
                    skilllevelup:setTexture("levelup_normal.png")
                    --升级技能
                    self:LevelUpScratchSkill(targettag-3000)
                    
                end

            end
        else    
            local skilllevelup=self:getChildByTag(targettag)
            skilllevelup:setTexture("levelup_normal.png")  
        end
        
        --        print("onTouchEnded: %0.2f, %0.2f", gl.x, "    ",gl.y)
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    local listenerItem = cc.EventListenerTouchOneByOne:create()
    listenerItem:setSwallowTouches(true)
    listenerItem:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listenerItem:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = self:getEventDispatcher()
    
    local lter=listenerItem
    
    
    --技能
    for var=1,5 do 
        if var>1 then
            lter=listenerItem:clone()
        end
        local _skillstr= string.format("MenuItem_%d.png",var)
        
        local _Skill=cc.Sprite:create("Skill_bg.png")
        _Skill:setPosition(cc.p(winSize.width/2-(3-var)*(14+_Skill:getContentSize().width),
            Leveldibanbg:getPositionY()+Leveldibanbg:getContentSize().height/2-_Skill:getContentSize().height/2-28))
        _Skill:setTag(1000+var)
        self:addChild(_Skill,6)
        
        eventDispatcher:addEventListenerWithSceneGraphPriority(lter, _Skill)
        
        local _skillcheckbox=cc.Sprite:create("Skill_normal.png")
        _skillcheckbox:setPosition(cc.p(_Skill:getPositionX(),
        _Skill:getPositionY()+_Skill:getContentSize().height/2))
        _skillcheckbox:setTag(2000+var)
        _skillcheckbox._isSelect=false
        self:addChild(_skillcheckbox,6)
        --升级按钮
        
        local _levelup=cc.Sprite:create("levelup_normal.png")
        _levelup:setPosition(cc.p(_Skill:getPositionX(),
            _Skill:getPositionY()-_Skill:getContentSize().height/2-_levelup:getContentSize().height/2-2))
        _levelup:setTag(3000+var)
        self:addChild(_levelup,6)
        
        
        local curGold = cc.UserDefault:getInstance():getIntegerForKey("curGold")
        local key= string.format("ScratchSkill_%d",var)
        local curSkilllevel = cc.UserDefault:getInstance():getIntegerForKey(key,1)
        local curlevelup = 20*math.pow(2,curSkilllevel)
        local labelstr = string.format("%d",curlevelup)
        local _leveluplabel = cc.Label:createWithTTF(labelstr,"Frozen.ttf",28);
        

        _leveluplabel:setPosition(cc.p(_levelup:getPositionX(),
            _levelup:getPositionY()-7))
        _leveluplabel:setTag(var+4000)
        if  curGold< curlevelup then
            _leveluplabel:setColor(cc.c3b(255,0,0))
            _levelup._isCanBuy =false
            
        else
            _leveluplabel:setColor(cc.c3b(255,215,0))
            _levelup._isCanBuy =true
        end
        

   
        self:addChild(_leveluplabel,7)
    
    
        
        lter=listenerItem:clone()
        eventDispatcher:addEventListenerWithSceneGraphPriority(lter, _levelup)
        biaojisize=_levelup:getContentSize().height
        biaojipoint.y=_levelup:getPositionY()
    end
    
    
    --选中框
    local sp_fuzhi = self:getChildByTag(1001)
    local select_bg = cc.Sprite:create("Skill_bg_select.png")
    select_bg:setTag(675)
    select_bg:setPosition(cc.p(sp_fuzhi:getPositionX(),sp_fuzhi:getPositionY()))
    
    self:addChild(select_bg,7)
    targetNumber=0
    
    
    --BitmapFontMultiLineAlignment._pLabelShouldRetain = cc.LabelBMFont:create(LongSentencesExample, "fonts/markerFelt.fnt", size.width/1.5, cc.TEXT_ALIGNMENT_CENTER)
    
    
    
    
    
--    local lifeLabel = cc.Label:createWithTTF(skillone, "fonts/QuicksandBold-Regular.otf", 30)
--    lifeLabel:setWidth(DirectorUtils.getWinWidth()/2)
    
--    lifeLabel:setPosition(lifeLabelPosition)
--    lifeLabel:setAlignment(cc.TEXT_ALIGNMENT_LEFT)
--    lifeLabel:setColor(cc.c3b(255,215,0))
--    lifeLabel:setTag(9999)
--    --    lifeLabel:setTag(GameUserDataEnum.lifeLabelTag)
--    self:addChild(lifeLabel,6)
    
    local _horizAlign = cc.TEXT_ALIGNMENT_LEFT
    local _vertAlign  = cc.VERTICAL_TEXT_ALIGNMENT_TOP
    
    
    local ttfConfig  = {}
    ttfConfig.fontFilePath="Frozen.ttf"
    ttfConfig.fontSize = 32
    local label = cc.Label:create()
    label:setDimensions(Leveldibanbg:getContentSize().width-50,
    biaojipoint.y-biaojisize/2-34-(biaojipoint.y-Leveldibanbg:getContentSize().height/2))
    label:setAlignment(_horizAlign,_vertAlign)
    label:setTTFConfig(ttfConfig)
    label:setString(skillone)
    label:setAnchorPoint(cc.p(0.0, 1))
    
    label:setColor(cc.c3b(255,215,0))
    self:addChild(label,6)
    label:setTag(9999)
    local lifeLabelPosition=cc.p(Leveldibanbg:getPositionX()-Leveldibanbg:getContentSize().width/2+22,
        biaojipoint.y-biaojisize/2-34)
    label:setPosition(lifeLabelPosition)
    
    
    
end


function ConditionLayer:addTouchListener(touchLayer)
    
    local function onTouchBegan(touch,event)
        return true
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    
    local eventDispatcher=touchLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,touchLayer)   

end



function ConditionLayer:LevelUpScratchSkill(SkillNum)
    local curGold = cc.UserDefault:getInstance():getIntegerForKey("curGold")
    local skillstr = string.format("ScratchSkill_%d",SkillNum)
    local curSkillLevel  =  cc.UserDefault:getInstance():getIntegerForKey(skillstr,1)
    local levelupgold = 20*math.pow(2,curSkillLevel)
    
    if curGold > levelupgold then
        curGold=curGold-levelupgold
        curSkillLevel=curSkillLevel+1
        cc.UserDefault:getInstance():setIntegerForKey("curGold",curGold)
        cc.UserDefault:getInstance():flush()
        
        local skillLabel = self:getChildByTag(SkillNum+4000)
        local skilllevelup = self:getChildByTag(SkillNum+3000)
        local curlevelupgold = 20 * math.pow(2,curSkillLevel)
        local labelstr = string.format("%d",curlevelupgold)
        skillLabel:setString(labelstr)
        if curGold < curlevelupgold then
            skillLabel:setColor(cc.c3b(255,0,0))
            skilllevelup._isCanBuy =false

        else
            skillLabel:setColor(cc.c3b(255,215,0))
            skilllevelup._isCanBuy =true
        end
        cc.UserDefault:getInstance():setIntegerForKey(skillstr,curSkillLevel)
        cc.UserDefault:getInstance():flush()
        
    end
end

return ConditionLayer