require"Cocos2d"
require"GameDirectorUtils"

local NightLayer =class("NightLayer",function()
    return cc.Layer:create();
end)

function NightLayer.create()      
    local layer=NightLayer.new()
    layer:initLayer()
--    local layer=cc.Layer:create();
    return layer
end

local menuBg
local winSize = DirectorUtils.getWinSize()
function NightLayer:initLayer()
    local pScratchLayer = cc.RenderTexture:create( 
        winSize.width,winSize.height);
    pScratchLayer:setPosition( cc.p( winSize.width / 2, winSize.height / 2 ) );
    local newBlendFuc = { gl.SRC_ALPHA,gl.ONE_MINUS_SRC_ALPHA }
    pScratchLayer:getSprite():setBlendFunc( gl.SRC_ALPHA,gl.ONE_MINUS_SRC_ALPHA );
    pScratchLayer:setZOrder( 5);
    pScratchLayer:setTag( 10001 );
    self:addChild( pScratchLayer );

    
    pScratchLayer:clear( 0,0,0,1 )
    pScratchLayer:begin()
    
    pScratchLayer:endToLua()
    
    
    cc.SpriteFrameCache:getInstance():addSpriteFrames("light.plist","light.png")
end

function NightLayer:LabelCreate(ispass)
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
    --self:addTouchListener(self)



end
function NightLayer:addTouchListener(touchLayer)
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
local timenum=0
local isLight=false
function NightLayer:update(dt)
    if isLight then
        return
    end
    timenum=timenum+dt
    local pScratchLayer = self:getChildByTag( 10001 )
    if timenum>3  then
        isLight=true
        local function ActionCallBack(sender)
        	sender:removeFromParent()
        	timenum=0
        	isLight=false
        end
        pScratchLayer:setVisible(false)
        local spr = cc.Sprite:create("Light_1.png")
        spr:setPosition(winSize.width/2,winSize.height/2)
        self:getParent():addChild(spr,100)
        local cache = cc.SpriteFrameCache:getInstance()
        local animframes={} 
        for var=1 ,4 do
            
           
                
               
            local ImageStr=string.format("Light_%s.png",var)
            local frame=cache:getSpriteFrame(ImageStr)
            animframes[var]=frame
                
                --local annima=cc.Animation:createWithSpriteFrames(array,float,int)
                
            
        end
        local animation=cc.Animation:createWithSpriteFrames(animframes)
        local animationStr=string.format("light")
        --                print("animationStr===",animationStr)
        cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
        local str_name = string.format("light")
        
        local a=cc.AnimationCache:getInstance():getAnimation(str_name)
        a:setDelayPerUnit(0.05)--一张图片跳到下一张的间隔
        a:setRestoreOriginalFrame(false)

        local action_mogu=cc.Animate:create(a);
        
        local callback  = cc.CallFunc:create(ActionCallBack)
        local det = cc.DelayTime:create(0.5)
        local action=cc.Sequence:create(action_mogu,det,callback)
        spr:runAction(action)
        return
    end
    pScratchLayer:setVisible(true)
    if List.getSize(LightSpriteManager)~=0 then
        for val = LightModeBullet.first, LightModeBullet.last do
            local sprite = LightModeBullet[val]
            local point=cc.p(sprite:getPositionX(),sprite:getPositionY())
            
           
            sprite:updateLightSpritePoint(point)
        end
    end
    
    
    
    
   
    pScratchLayer:clear( 0,0,0,1 );

    -- 开始重绘
    pScratchLayer:begin();
   
    pScratchLayer:endToLua();

    -- 更新renderTexture
    pScratchLayer:begin()
    gl.colorMask( 0,0,0,1 )
    
    if List.getSize(LightSpriteManager)~=0  then
        for val = LightSpriteManager.first, LightSpriteManager.last do
            local sprite = LightSpriteManager[val]
        
            sprite:visit()
        end
    end
    gl.colorMask(1,1,1,1)

    pScratchLayer:endToLua()
end


return NightLayer