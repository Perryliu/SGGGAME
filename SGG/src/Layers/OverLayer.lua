require"Cocos2d"
require"GameDirectorUtils"

local OverLayer =class("OverLayer",function()
    return cc.Layer:create();
end)

function OverLayer.create()      
    local layer=OverLayer.new()
    layer:initLayer()
--    local layer=cc.Layer:create();
    return layer
end

local menuBg
function OverLayer:initLayer()

     
--    local winSize=DirectorUtils.getWinSize()
--    local dianBg=cc.Sprite:create("dian.png")
--    dianBg:setPosition(cc.p(winSize.width/2,winSize.height/2))
--    dianBg:setScaleX(winSize.width/dianBg:getContentSize().width)
--    dianBg:setScaleY(winSize.height/dianBg:getContentSize().height)
--    self:addChild(dianBg,-10)
--    local ispass = cc.UserDefault:getInstance():getBoolForKey("ispass")
--    if ispass then
--        if(UserData:GetInstance():getCurScene()>=UserData:GetInstance():getMaxScene()) then
--            if(UserData:GetInstance():getCurLevel()>=UserData:GetInstance():getMaxLevel()) then
--                UserData:GetInstance():setMaxLevel(UserData:GetInstance():getCurLevel()+1)
--            end
--        end
--        menuBg=cc.Sprite:create("win.png")
--        menuBg:setPosition(cc.p(winSize.width/2,winSize.height/2))
--        self:addChild(menuBg,0)
--
--        self:getGoal()
--    else
--        menuBg=cc.Sprite:create("lose.png")
--        menuBg:setPosition(cc.p(winSize.width/2,winSize.height/2))
--        self:addChild(menuBg,0)
--
--
--    end
end

function OverLayer:getGoal()
    local gametype = returnLevelTable(DirectorUtils.getCurSceneLevel()).gametype
    local goal
    local starNum
    if gametype == 1 then
        goal=UserData:GetInstance():getLevelGoal(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel())
    elseif gametype ==2 then
        local curapp=UserData:getSceneLevelGetApple(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel())
        local maxapp=UserData:getLevelMaxApple(UserData:GetInstance():getCurScene(),UserData:GetInstance():getCurLevel())
        goal=UserData:getAppleLevelGoal(curapp,maxapp)
    elseif gametype ==3 then
        goal=1
    end
    if goal>=0.9 then

        starNum=3;
    end       
    if(goal>=0.6 and goal<0.9) then

        starNum=2;
    end
    if(goal<0.6) then 

        starNum=1
    end

    for var=0,starNum,1 do

        local levelstar=cc.Sprite:create("star_2.png")
        levelstar:setPosition(cc.p(menuBg:getPositionX()-40+40*var,menuBg:getPositionY()))
        self:addChild(levelstar)
    end

end
function OverLayer:LabelCreate(ispass)
    local fadeIn1 =cc.FadeTo:create(0.5,150);   --1秒渐变到80透明
        local fadeOut2 = cc.FadeTo:create(0.75,255);    --1秒变不透明

        local fadeIn3 =cc.FadeTo:create(1,80);  --1秒渐变到80透明
        local fadeOut4 = cc.FadeTo:create(1.5,255); --1秒变不透明

        local fadeIn5 =cc.FadeTo:create(1.5,80);   --1秒渐变到80透明
        local fadeOut6 = cc.FadeTo:create(1,255);   --1秒变不透明

        local ease1_1 = cc.EaseSineInOut:create(fadeIn1);    --让目标动作由慢到快

        local ease1_2 = cc.EaseSineInOut:create(fadeOut2);

        local ease2_1 = cc.EaseSineInOut:create(fadeIn3);    --让目标动作由慢到快

        local ease2_2 = cc.EaseSineInOut:create(fadeOut4);

        local ease3_1 = cc.EaseSineInOut:create(fadeIn5);    --让目标动作由慢到快

        local ease3_2 = cc.EaseSineInOut:create(fadeOut6);

        local seq1 =cc.Sequence:create(ease1_1,ease1_2);   --顺序播放
        local seq2 =cc.Sequence:create(ease2_1,ease2_2);   --顺序播放
        local seq3 =cc.Sequence:create(ease3_1,ease3_2);  --顺序播放
    









    if ispass then

        --退出
        local label_quit = cc.Label:createWithTTF("QUIT","fonts/QuicksandBold-Regular.otf",50);
        label_quit:setColor(cc.c3b(65,40,25));
        local quit = cc.MenuItemLabel:create(
            label_quit)   --回调函数
        quit:registerScriptTapHandler(goQuit)  
        quit:setPosition(cc.p(-90,-150))

        --下一关
        local label_next = cc.Label:createWithTTF("NEXT","fonts/QuicksandBold-Regular.otf",50);
        label_next:setColor(cc.c3b(65,40,25));
        local NEXT = cc.MenuItemLabel:create(
            label_next)   --回调函数
        NEXT:registerScriptTapHandler(goNext)
        NEXT:setPosition(cc.p(0,-70));
        --重新开始
        local label_again = cc.Label:createWithTTF("AGAIN","fonts/QuicksandBold-Regular.otf",50);
        label_again:setColor(cc.c3b(65,40,25));
        local again = cc.MenuItemLabel:create(
            label_again)
        again:registerScriptTapHandler(goAgain)    
        again:setPosition(cc.p(90,-150));
        NEXT:runAction(cc.RepeatForever:create(seq1));
        quit:runAction(cc.RepeatForever:create(seq2));
        again:runAction(cc.RepeatForever:create(seq3));
        local menu = cc.Menu:create(again,NEXT,quit);
        self:addChild(menu);

    else

        --退出
        local label_quit = cc.Label:createWithTTF("QUIT","fonts/QuicksandBold-Regular.otf",50);
        label_quit:setColor(cc.c3b(65,40,25));
        local quit = cc.MenuItemLabel:create(
            label_quit)   --回调函数
        quit:registerScriptTapHandler(goQuit) 
        quit:setPosition(cc.p(0,-150));
        --重新开始

        local label_again = cc.Label:createWithTTF("AGAIN","fonts/QuicksandBold-Regular.otf",50);
        label_again:setColor(cc.c3b(65,40,25));
        local again =cc.MenuItemLabel:create(
            label_again)
        again:registerScriptTapHandler(goAgain) 


        again:setPosition(cc.p(0,-70));

        quit:runAction(cc.RepeatForever:create(seq2));
        again:runAction(cc.RepeatForever:create(seq3));
        local menu = cc.Menu:create(again,quit);

        self:addChild(menu);

    end
    self:addTouchListener(self)



end
function OverLayer:addTouchListener(touchLayer)
    local function onTouchBegan(touch,event)

        --        print("onTouchBegan: %0.2f, %0.2f", gl.x,"    ", gl.y)    
        return true
    end

    local function onTouchMoved(touch,event)

    --        print("onTouchMoved: %0.2f, %0.2f", gl.x,"    ", gl.y)
    end

    local function onTouchEnded(touch,event)

    --        print("onTouchEnded: %0.2f, %0.2f", gl.x, "    ",gl.y)
    end


    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
    listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher=touchLayer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,touchLayer)   

end
function saveCurLevel(isagin)
    local curLevel=UserDefault:getInstance():getIntegerForKey("curLevel")
    local ispass = cc.UserDefault:getInstance():getBoolForKey("ispass")
    if (ispass and isagin==true) then
        curLevel=curLevel+1
    end
    --    if(curLevel>20) then
    --    
    --        curLevel=1;
    --    end
    UserDefault:getInstance():setIntegerForKey("curLevel",curLevel)

    UserDefault:getInstance():flush();
    print("Level==%d",UserDefault:getInstance():getIntegerForKey("curLevel"));
end
local function goQuit(sender)
    cc.SimpleAudioEngine:getInstance():stopAllEffects()

    saveCurLevel(false)
    --MusicManager::GetInstance()->PlayMusicOrEffect("music/bgm.mp3",MusicType::_BACKGROUNDMUSIC_);
    cc.Director:getInstance():replaceScene(GameUIManager:GameStateChoose(1))
end

local function goNext(sender)
    saveCurLevel(false)
    if(UserDefault:getInstance():getIntegerForKey("curLevel")>3) then

        print("Level==%d",UserDefault:getInstance():getIntegerForKey("curLevel"))
        UserDefault:getInstance():setIntegerForKey("curLevel",1)
    end
    cc.SimpleAudioEngine:getInstance():stopAllEffects()
    GameUIManager:EnterBattleScene();
    Olayer:removeFromParent();
end

local function goAgain(sender)
    saveCurLevel(true)
    cc.SimpleAudioEngine:getInstance():stopAllEffects()
    GameUIManager:EnterBattleScene()
    Olayer:removeFromParent()
end



return OverLayer