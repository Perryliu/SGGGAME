require"Cocos2d"
require "Cocos2dConstants"

local GameSettingLayer =class("GameSettingLayer",function()
	return cc.Layer:create();
end)

local winSize=DirectorUtils.getWinSize()
local listener=cc.EventListenerTouchOneByOne:create()

local label_return
local label_effect
local label_music

function GameSettingLayer.create()      
    local layer=GameSettingLayer.new()
	layer:addTouchListener()
	layer:initLayer()
	return layer
end


function GameSettingLayer:addTouchListener()
    local function onTouchBegan(touch,event)
        
        return true
    end
    
    local function onTouchMoved(touch,event)
        

    end
   
    local function onTouchEnded(touch,event)
    
    end
    listener=cc.EventListenerTouchOneByOne:create()
	listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN)
    listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher=cc.Director:getInstance():getEventDispatcher()
    listener:setSwallowTouches(true)
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener,self)
end

local function MusicCallBack(sender)


    local MusicState=cc.UserDefault:getInstance():getBoolForKey("MusicState")
    
	if MusicState then
        cc.SimpleAudioEngine:getInstance():pauseMusic()
        MusicManager:GetInstance():changeMusicState(false)
        local string = string.format("%s","MUSIC:OFF")
        label_music:setString(string)
    else
    
        cc.SimpleAudioEngine:getInstance():resumeMusic()
        MusicManager:GetInstance():changeMusicState(true)

        local string = string.format("%s","MUSIC:ON")
        label_music:setString(string)
    end
end
local function EffectCallBack(sender)
    local EffectState=cc.UserDefault:getInstance():getBoolForKey("EffectState")
    if EffectState then
    
       
        local string = string.format("%s","EFFECT:OFF")
        label_effect:setString(string);
        MusicManager:GetInstance():changeEffectState(false);
    
    else
    
        local string = string.format("%s","EFFECT:ON")
        label_effect:setString(string)
        MusicManager:GetInstance():changeEffectState(true);
    end
    
    
end

local function GoquitCallBack(sender)
    if gameScene then
        gameScene:overClearScene()
        GameUIManager:exitBattleScene()
    end  
end

local function GoAgainCallBack(sender)
    if gameScene then
        gameScene:overClearScene()
        GameUIManager:EnterBattleScene()
    end  
end

local function GoBackCallBack(sender)
    if gameScene then
        gameScene:closeSeting()
    end  
end
function GameSettingLayer:initLayer()
    local dian=cc.Sprite:create("dian.png")
    dian:setScaleX(winSize.width/dian:getContentSize().width)
    dian:setScaleY(winSize.height/dian:getContentSize().height)
    dian:setPosition(cc.p(winSize.width/2,winSize.height/2))
    self:addChild(dian,-10)

	local menu=cc.Menu:create()
	self:addChild(menu)
	
	--返回主界面按钮
    local Button_return=cc.MenuItemImage:create("Menu_button_normal.png",
        "Menu_button_select.png");
    Button_return:registerScriptTapHandler(GoquitCallBack)
    Button_return:setPosition(cc.p(0,-230));
    Button_return:setScale(0.8)
    menu:addChild(Button_return);

    label_return = cc.Label:createWithTTF("RETURN","fonts/QuicksandBold-Regular.otf",36);

    label_return:setPosition(cc.vertex2F(winSize.width/2,winSize.height/2-230));
    label_return:setColor(cc.c3b(65,40,25));
    self:addChild(label_return,6);
    
    --返回
    local Button_BACK=cc.MenuItemImage:create("Menu_button_normal.png",
        "Menu_button_select.png");
    Button_BACK:registerScriptTapHandler(GoBackCallBack)
    Button_BACK:setPosition(cc.p(0,-110));
    Button_BACK:setScale(0.8)
    menu:addChild(Button_BACK);

    local label_bcak = cc.Label:createWithTTF("BACK","fonts/QuicksandBold-Regular.otf",36);

    label_bcak:setPosition(cc.vertex2F(winSize.width/2,winSize.height/2-110));
    label_bcak:setColor(cc.c3b(65,40,25));
    self:addChild(label_bcak,6);
    
    

    --重新开始
    local Button_restart=cc.MenuItemImage:create("Menu_button_normal.png",
        "Menu_button_select.png");
    Button_restart:registerScriptTapHandler(GoAgainCallBack)
    Button_restart:setPosition(cc.p(0,10));
    Button_restart:setScale(0.8)
    menu:addChild(Button_restart);

    local label_restart = cc.Label:createWithTTF("RESTART","fonts/QuicksandBold-Regular.otf",36);

    label_restart:setPosition(cc.vertex2F(winSize.width/2,winSize.height/2+10));
    label_restart:setColor(cc.c3b(65,40,25));
    self:addChild(label_restart,6);



    --音乐
    local Button_Music=cc.MenuItemImage:create("Menu_button_normal.png",
        "Menu_button_select.png"
        )
    
    Button_Music:registerScriptTapHandler(MusicCallBack)
    
    Button_Music:setPosition(cc.p(0,250));
    Button_Music:setScale(0.8)
    menu:addChild(Button_Music);
    local musickey
    local MusicState=cc.UserDefault:getInstance():getBoolForKey("MusicState")
    if MusicState then
    
        musickey=string.format("%s","MUSIC:ON")
        --sprintf(musickey,"MUSIC:ON");
    else
        musickey=string.format("%s","MUSIC:OFF")
--        sprintf(musickey,"MUSIC:OFF");
    end
    label_music = cc.Label:createWithTTF(musickey,"fonts/QuicksandBold-Regular.otf",36);

    label_music:setPosition(cc.vertex2F(winSize.width/2,winSize.height/2+250));
    label_music:setColor(cc.c3b(65,40,25));
    self:addChild(label_music,6);


    
    local effkey
    local EffectState=cc.UserDefault:getInstance():getBoolForKey("EffectState")
    if EffectState then
            
        effkey=string.format("%s","EFFECT:ON")
--        sprintf(effkey,"EFFECT:ON");
    
    else
         effkey=string.format("%s","EFFECT:OFF")
--        sprintf(effkey,"EFFECT:OFF");
    end
    
    --音效
    local Button_effect=cc.MenuItemImage:create("Menu_button_normal.png",
        "Menu_button_select.png");
    Button_effect:registerScriptTapHandler(EffectCallBack)
    Button_effect:setPosition(cc.p(0,130));
    Button_effect:setScale(0.8)
    menu:addChild(Button_effect);

    label_effect = cc.Label:createWithTTF(effkey,"fonts/QuicksandBold-Regular.otf",36);

    label_effect:setPosition(cc.vertex2F(winSize.width/2,winSize.height/2+130));
    label_effect:setColor(cc.c3b(65,40,25));
    self:addChild(label_effect,6);
	
end


return GameSettingLayer