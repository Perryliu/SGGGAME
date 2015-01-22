
require "Cocos2d"
require "GameDirectorUtils"

GuideChalkLayer = class ("GuideChalkLayer", function ()
    local node = cc.Layer:create()
    node:setCascadeColorEnabled(true)
    return node
end)

function GuideChalkLayer:ctor()
    self.chalkEnd=false
end

function GuideChalkLayer.create(data)
    local chalkLayer= GuideChalkLayer.new()  
    copyTable(data,chalkLayer)
    chalkLayer:iniWithData(data)
    return chalkLayer
end

local function menuCallbackBugsTest()
    print("menuCallbackBugsTest")
    if beginnerGuide then
        beginnerGuide:initWithGuide()
    end        
end

function GuideChalkLayer:iniWithData(data)
    local colorLayer=cc.LayerColor:create(cc.c4b(0,0,0,100))
    self:addChild(colorLayer)
    
    local str="ju:"..data.strMsg
    local lifeLabel = cc.Label:createWithTTF(str, "MarkerFelt.ttf", 45)
    lifeLabel:setWidth(DirectorUtils.getWinWidth()*3/4)
    local lifeLabelPosition=cc.p(DirectorUtils.getWinWidth()/2,DirectorUtils.getWinHeight()/2)
    lifeLabel:setPosition(lifeLabelPosition)
    lifeLabel:setAlignment(cc.TEXT_ALIGNMENT_LEFT)
--    lifeLabel:setTag(GameUserDataEnum.lifeLabelTag)
    self:addChild(lifeLabel)
    
    local label = cc.Label:createWithTTF("o k", "comic andy.ttf", 100)
    local  item = cc.MenuItemLabel:create(label)
    item:registerScriptTapHandler(menuCallbackBugsTest)
    local  menu = cc.Menu:create()
    local menuPosition=cc.p(DirectorUtils.getWinWidth()/2,DirectorUtils.getWinHeight()/2-100)
    menu:addChild(item)
    menu:setPosition(menuPosition)
    
    self:addChild(menu)
end


return GuideChalkLayer