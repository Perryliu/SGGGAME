require "Cocos2d"
require "Data_Level"
require "Data_Scratch"
require "LayerManager"
local SpecialScratch = class ("SpecialScratch", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

local Scratch_status={
    K_Scratch_None=1,
    K_Scratch_Disappear=2,
    K_Scratch_Move=3,
}


function SpecialScratch:ctor()
    --local ScratchData=returnLevelTable(DirectorUtils.getCurSceneLevel()).scratch
    
    
    self._scratchSprite=nil;
    self._ballBodyTwo=nil;
    self.isSetData=false;
    self._scratch_status=Scratch_status.K_Scratch_None;
    self.mogutable={}
    
    self._bulletNum=0
end

function SpecialScratch.create(name)
    local Scratch = SpecialScratch.new()  
   
    Scratch:init(name)
    
    Scratch:initcache()
   
    
    return Scratch
end

function SpecialScratch:init(name)
    
    
    
    
    
    self._scratchName=name
    self:initWithParticle()
end
function SpecialScratch:iniWithData()
    local scratchdata=getScratchInfo("2001")
    
    if not self.isSetData then
       
        self._minLength=scratchdata.minLength
        --local abc=scratchdata.minLength
        self._maxLength=scratchdata.maxLength
        
        self._minRealLength=scratchdata.realMinLength
        self._maxRealLength=scratchdata.realMaxLength
        self._hurtAddition=1.0
        self._speedAddition=1.0
        self.isSetData=true;
    end
    
   
    
    
end

function SpecialScratch:initWithScratchSprite()
    self._scratchSprite=cc.Scale9Sprite:create("scratch001.png")
    self._testScratchSprite=cc.Sprite:create("scratch001.png")
    self._testScratchSprite:setVisible(false)
    self._scratchSprite:setVisible(false)
    self:addChild(self._scratchSprite)
    
end

function SpecialScratch:initWithPhysicsBody()
 --物理引擎刚体
 --self._scratchSprite:getContentSize().width
    local spriteSize=cc.size(self._scratchSprite:getContentSize().width,self._scratchSprite:getContentSize().height/2)
    self._ballBodyTwo=cc.PhysicsBody:createBox(cc.size(spriteSize.width*self._scale,spriteSize.height),cc.PhysicsMaterial(0.1, 0.5, 0.5))
    self._ballBodyTwo:setDynamic(false)
    self._ballBodyTwo:getShape(0):setGroup(2)
    self._ballBodyTwo:getShape(0):setRestitution(1.1)
    self._ballBodyTwo:getShape(0):setFriction(0.0)
    self._ballBodyTwo:getShape(0):setDensity(1.0)
    
    self._ballBodyTwo:setGravityEnable(true)
    self._ballBodyTwo:setCategoryBitmask(0x0010)
    self._ballBodyTwo:setCollisionBitmask(0x0010)
    self._ballBodyTwo:setContactTestBitmask(0x0010)
    self._ballBodyTwo:retain()
end

function SpecialScratch:initWithParticle()
    --local glShaderProgram = cc.GLProgramCache:getInstance():getGLProgram("kCCShader_PositionColor")
    --ShaderCache:getInstance():programForKey(kCCShader_PositionColor);
    --self:setGLProgram(glShaderProgram)
    self.S_BeaginParticle = cc.ParticleSystemQuad:create("Particle.plist") 
    self.S_EndParticle = cc.ParticleSystemQuad:create("Particle.plist") 
    self.S_BeaginParticle:setVisible(false)
    self.S_EndParticle:setVisible(false)

    self:addChild(self.S_BeaginParticle, 100) 
    self:addChild(self.S_EndParticle, 101) 
    
    self.S_BeaginParticle:stopSystem()
    self.S_EndParticle:stopSystem()
    
end

function SpecialScratch:setBeginScratchStatus(beginPoint)
    self.isTouchINit=true
    self:reset()
    self.s_beginPoint=beginPoint;
    self.s_endPoint=beginPoint;
    
    local sp=self:convertToNodeSpace(beginPoint)
    self.S_BeaginParticle:resetSystem()
    self.S_BeaginParticle:setPosition(sp)
    self.S_BeaginParticle:setVisible(true)
    --蘑菇精灵
    self.mogutable={}
end

function SpecialScratch:setScratchBeginPoint(beginPoint)
    local a=1
    local b=1
    local c=1
    
--    local sp =cc.Sprite:create("scratch001.png")
--    sp:setPosition(cc.p(300,300))
--    self:addChild(sp)
    
    self:iniWithData()
    
    if (self._scratch_status~=Scratch_status.K_Scratch_None) then
        return
    end
    self:setBeginScratchStatus(beginPoint)
    
    
    
end

function SpecialScratch:setScratchMovePoint(movePoint)
    if self._scratch_status~=Scratch_status.K_Scratch_None then
        return;
    end
    self.s_endPoint=movePoint;
    self:setParticleState(false)
end

function SpecialScratch:setScratchEndPoint(endPoint)
    if self._scratch_status ~= Scratch_status.K_Scratch_None then
        return;
    end
    self.s_endPoint=endPoint;
    self:setScratchState(true);
    self:setParticleState(true);
end

function SpecialScratch:getTouchDuration() 
    
    local startInWorldSpace=self:convertToNodeSpace(self.s_beginPoint);
    local sp=cc.p(startInWorldSpace.x,startInWorldSpace.y);
    
    --设置变形的大小
    local tergetInNodeSpace=self:convertToNodeSpace(self.s_endPoint);
    local beginAddSpriteWidth=self:convertToNodeSpace(sp);
    
    local duration=getDistanceBetween(beginAddSpriteWidth,tergetInNodeSpace)
    --beginAddSpriteWidth.getDistance(tergetInNodeSpace);
    return duration

end

function SpecialScratch:showScratch(duration) 
    self.isTouchINit=false;
    if (duration<self._minRealLength) then
        duration=self._minRealLength
    end
    
    if (duration>self._maxRealLength) then
        duration=self._maxRealLength;
    end
    --初始化精灵
   self:initWithScratchSprite()
    
    self._scratchLength=duration
    
    local sp=cc.p(self.s_beginPoint.x,self.s_beginPoint.y)
    self._testScratchSprite:setAnchorPoint(cc.vertex2F(0,0.5))
    self._testScratchSprite:setPosition(sp);
    
    local XScale=duration/self._scratchSprite:getContentSize().width;
    self._testScratchSprite:setScaleX(XScale);
    self._scale=XScale;
    --设置角度
    local angle=getGLAngle(self.s_endPoint.x,self.s_endPoint.y, sp.x,sp.y);
    
    self._angle=-angle;
    self._scratchSprite:setRotation(self._angle);
    self._testScratchSprite:setRotation(self._angle);

    if (self._ballBodyTwo) then
        
        self._ballBodyTwo=nil
   end
    --找出变变化的中点坐标
    local BR=self._testScratchSprite:getBoundingBox();
    local lastPoint=cc.p(BR.x+BR.width*0.5,BR.y+BR.height*0.5);
    self:initWithPhysicsBody()
--    //            ((Scale9Sprite *)_scratchSprite)->setInsetTop(0);
--    //            ((Scale9Sprite *)_scratchSprite)->setInsetLeft(100);
--    //            ((Scale9Sprite *)_scratchSprite)->setInsetRight(100);
--    //            ((Scale9Sprite *)_scratchSprite)->setInsetBottom(32);
    
    self._scratchSize=cc.size(duration,32);
    self._scratchSprite:setPreferredSize(self._scratchSize)
    self._scratchSprite:setPhysicsBody(self._ballBodyTwo);
    self._scratchSprite:setPosition(lastPoint);
    self._scratchSprite:setVisible(true);
    
    --self:initMoguSprite(duration,self._angle)
    --self:initMoguSprite(duration,angle)
    self.isShengcheng=true
end

function SpecialScratch:setScratchState(isEnd) 
    local duration=self:getTouchDuration()
    
    if (duration>=self._minLength) then
        self:showScratch(duration)
    end
    
end


function SpecialScratch:setParticleState(isEnd) 
    if not self.S_EndParticle:isActive()then
        self.S_EndParticle:resetSystem()
    end
    local tergetInNodeSpace=self:convertToNodeSpace(self.s_endPoint)
    self.S_EndParticle:setPosition(tergetInNodeSpace);
    self.S_EndParticle:setVisible(true);
    
    if (isEnd) then
        self.S_BeaginParticle:stopSystem();
        self.S_EndParticle:stopSystem();
    end
end

function SpecialScratch:setScratchStatus(var) 
    self._scratch_status=var;
end


function SpecialScratch:reset() 
    self._thichness=1;
    
    if (self._scratchSprite) then
        self:removeChild(self._scratchSprite);
        self._scratchSprite=nil;
    end
    
    if (self._testScratchSprite) then
        self:removeChild(self._testScratchSprite)
        self._testScratchSprite=nil;
    end
    self:setScratchStatus(Scratch_status.K_Scratch_None);

end



local Mogu={2,1,5,3,4,5,2,3,1,4}
local MoguSize={79,67,55,57,77}
--
function SpecialScratch:initMoguSprite(duration,angle)
    local Mogucopy={}
    copyTable(Mogu,Mogucopy)
    local spriteDuration=duration
    local getMogu={}
    --蘑菇弹要用的table  保存的是第几个蘑菇
    self.Mogutan={}    
    local a=MoguSize[1]
    while spriteDuration>0 do
        math.randomseed(os.time()) --相当于srand()的过程
        local i=math.random(1,#Mogucopy)
        
            spriteDuration=spriteDuration-MoguSize[Mogucopy[i]]
            table.insert(getMogu,#getMogu+1,Mogucopy[i])
            table.remove(Mogucopy,i)
        
    end
    
    local node = cc.Node:create()
    node:setPosition(self.s_beginPoint)
    self:addChild(node)
    node:setAnchorPoint(cc.vertex2F(0,0.5))
    node:setRotation(angle)
    
    if self.s_beginPoint.x> self.s_endPoint.x then
        node:setScaleY(-1)
    end
   
    local lenth=0
    
    
    
    math.randomseed(os.time()) --相当于srand()的过程
    local c=math.random(1,#Mogucopy)
    
    spriteDuration=spriteDuration-MoguSize[Mogucopy[c]]
    table.insert(getMogu,#getMogu+1,Mogucopy[c])
    --table.remove(Mogucopy,i)
    
--    while spriteDuration >0 do
--        for var=1,5,1 do
--            if Mogu[var]<spriteDuration then 
--            
--            end
--        end
--    end
    
    local n=#getMogu
    
    
    
    
    --local shiftX=spriteDuration+duration
    
    
    
    while n>0 do
        local str = string.format("scratchmogu_%s_1.png",getMogu[n])
        local sp = cc.Sprite:create(str)
        lenth=lenth+sp:getContentSize().width/2+spriteDuration/8
        sp:setPosition(lenth,0)
        --sp:setScale(0.5)
        node:addChild(sp)
        --加进table方便后面播放动画     加的是精灵
        table.insert(self.mogutable,#self.mogutable+1,sp)
        --cc.AnimationCache:getInstance():getAnimation(str.c_str());
        
        --action_mogu:retain()
        local action = self:MoguAction(getMogu[n],n,#getMogu)
        sp:runAction(action)
        
        n=n-1
        lenth=lenth+sp:getContentSize().width/2
    end
    
end

--加载资源
function SpecialScratch:initcache()
        
    local cache = cc.SpriteFrameCache:getInstance()
    for i=1 ,5,1 do
        local animframes={} 
        for var=1,5,1 do
            local ImageStr=string.format("scratchmogu_%s_%s.png",i,var)
            local frame=cache:getSpriteFrame(ImageStr)
            animframes[var]=frame
        end
        --local annima=cc.Animation:createWithSpriteFrames(array,float,int)
        local animation=cc.Animation:createWithSpriteFrames(animframes)
        local animationStr=string.format("scratchmogu_%s",i)
        --                print("animationStr===",animationStr)
        cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
    end
    
    
    for i=1 ,5,1 do
        local animframes={} 
        for var=1,5,1 do
            local ImageStr=string.format("scratchmogutan_%s_%s.png",i,var)
            local frame=cache:getSpriteFrame(ImageStr)
            animframes[var]=frame
        end
        --local annima=cc.Animation:createWithSpriteFrames(array,float,int)
        local animation=cc.Animation:createWithSpriteFrames(animframes)
        local animationStr=string.format("scratchmogutan_%s",i)
        --                print("animationStr===",animationStr)
        cc.AnimationCache:getInstance():addAnimation(animation,animationStr)
    end
    
    
end
--测试回调
local function CCCCCCCCCCCCCCCCalllback(sender)
    --ScratchSprite:MoguTanAction(5,ScratchSprite.Mogutan)
    print("ScratchSprite:MoguTanActionEEEEEEEEEEEEEEENNNNNNNNNNDDDDDDDDDDDDD")
end
--蘑菇生长动画
function SpecialScratch:MoguAction(i,n,size)
    local str_name = string.format("scratchmogu_%s",i)
    --local animantion_mogu =cc.Animation:create()
    table.insert(self.Mogutan,#self.Mogutan+1,i)
    
    local animantion_mogu=cc.AnimationCache:getInstance():getAnimation(str_name)
    animantion_mogu:setDelayPerUnit(0.05)--一张图片跳到下一张的间隔
    animantion_mogu:setRestoreOriginalFrame(false)

    local action_mogu=cc.Animate:create(animantion_mogu);
    local delt=cc.DelayTime:create((size-n)*0.05)
    
    --测试回调
    local callback  = cc.CallFunc:create(CCCCCCCCCCCCCCCCalllback)
    local action
    if n==1 then
        local delt11=cc.DelayTime:create(1)
        action =cc.Sequence:create(delt,action_mogu,delt11,callback)
    else
        action =cc.Sequence:create(delt,action_mogu)
    end
    
   
    return action
end

--回调
local function MoguCallBack(render)
   -- render:removeFromParent()
    print("CCCCCCCCCCCCCCCCCCCCCCCCCCAAAAScratchSprite:MoguTanActionBEEEEEEEEEEEEEEEEGGGGGGGGGGGGGGIN")
end
--蘑菇反弹动画播放
function SpecialScratch:MoguTanAction(i,Mogtable)
    print("ScratchSprite:MoguTanActionBEEEEEEEEEEEEEEEEGGGGGGGGGGGGGGIN")
    local moguT={}
    copyTable(Mogtable,moguT)
    print("Mogtable::::::::::::::::::%s",#Mogtable)
    for var=1,#moguT,1 do 
        local str_name = string.format("scratchmogutan_%s",moguT[var])
        --local animantion_mogu =cc.Animation:create()
        print("%s",str_name)
    
        local animantion_mogu=cc.AnimationCache:getInstance():getAnimation(str_name)
        animantion_mogu:setDelayPerUnit(0.07)--一张图片跳到下一张的间隔
        animantion_mogu:setRestoreOriginalFrame(false)

        local action_mogu=cc.Animate:create(animantion_mogu);
        local delt=cc.DelayTime:create(math.abs(var-i)*0.08)
        local callback = cc.CallFunc:create(MoguCallBack)
        local scale = cc.ScaleBy:create(0.025,1.5)
        
        local spaw=cc.Spawn:create(action_mogu,scale)
        local action =cc.Sequence:create(delt,spaw,callback)
        --self.mogutable[var]:setScale(1.5)
        self.mogutable[var]:runAction(action)
        --self.mogutable[var]:setAnchorPoint(cc.p(0.5,0))
    end
    
end

--蘑菇反弹碰撞判断
function SpecialScratch:MoguColling(bulletPoint)
    local moguT={}
    local minDistance=500
    local minVar
    copyTable(self.mogutable,moguT)
    for var =1 ,#moguT,1 do
        local a=moguT[var]:getParent():convertToWorldSpace(moguT[var]:getPosition())
        local spPoint=moguT[var]:getParent():convertToWorldSpace(moguT[var]:getPosition());
        local distance=getDistanceBetween(spPoint,bulletPoint)
        if distance<minDistance then
            minDistance=distance
            minVar=var
        end
    end
    
    return minVar
end

function SpecialScratch:getScratchSize()
    return self._scratchSize
end

function SpecialScratch:getAngle()
    return self._angle
end

function SpecialScratch:setThichness(n)
    self._thichness=self._thichness+n
end

function SpecialScratch:getThichness()
    return self._thichness
end

function SpecialScratch:getcurScratchLenth()
    return self._scratchLength
end
return SpecialScratch