require "Cocos2d"

GuideChalkLine = class ("GuideChalkLine", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

function GuideChalkLine:ctor()
    self.chalkEnd=false
end

function GuideChalkLine.create(data)
    local chalkLine = GuideChalkLine.new()  
    copyTable(data,chalkLine)
    chalkLine:iniWithData(data)
    return chalkLine
end

local function moveCallBack(sender)
    sender:getParent():handMove()
end

function GuideChalkLine:iniWithData(data)
    self.stencil=cc.Sprite:create(data.stencil)
    self:addChild(self.stencil)
    self.stencil:setVisible(false)
    self.stencilSize=self.stencil:getContentSize()

    local width=self.stencilSize.width
    local height=self.stencilSize.height
--    local p1=cc.p((width-data.subWidth)/2,height/2)
--    local p2=cc.p((width-data.subWidth)/2+100,height/2)


    self.chand=cc.Sprite:create(data.chand)
    local handSize=self.chand:getContentSize()
    
    local p=cc.p(0,0)
    local p1=cc.p(p.x-width/2+(width-data.subWidth)/2+handSize.width/2,p.y-handSize.height/2)
    local p2=cc.p(p.x+width/2-(width-data.subWidth)/2+handSize.width/2,p.y-handSize.height/2)
    self.chand:setPosition(p1)
    self:addChild(self.chand)
    
    self.p1=p1
    self.p2=p2

    local action=GameAU.GameActionMoveCallBack(p1,p2,data.chandSpeed,moveCallBack)
    self.chand:runAction(action)
end

function GuideChalkLine:handMove(data)
    
    local p1=self.p1
    local p2=self.p2
    self.chand:setPosition(p1)
    
    local action=GameAU.GameActionMoveCallBack(p1,p2,self.chandSpeed,moveCallBack)
    self.chand:runAction(action)
end


return GuideChalkLine