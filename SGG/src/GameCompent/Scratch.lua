require "Cocos2d"
require "Data_Level"
require "Data_Scratch"
require "LayerManager"
local Scratch = class ("Scratch", function ()
    local node = cc.Node:create()
    node:setCascadeColorEnabled(true)
    return node
end)

local Scratch_status={
    K_Scratch_None=1,
    K_Scratch_Disappear=2,
    K_Scratch_Move=3,
}


function Scratch:ctor()
    self._minLength=0
    self._maxLength=0

    self._minAtk=0
    self._maxAtk=0

    self._minRealLength=0
    self._maxRealLength=0

    self._minReboundSpeed=0
    self._maxReboundSpeed=0

    self._critLength=0
    self._hurtAddition=1.0
    self._speedAddition=1.0
    self._buffAddition=0.0
    self._buffTime=0.0
    self._addBuffTime=0.0
    
    self._scratchSprite=nil;
    self._ballBodyTwo=nil;
    self._scratch_status=Scratch_status.K_Scratch_None;
    self.mogutable={}    
    self._AppleAngle=0
end

function Scratch.create(name)
    local scratch = Scratch.new()  
    
    scratch:init(name)
    scratch:initcache()
    scratch:iniWithData()
    scratch:initWithPowerSlider()
    scratch:initWithLine()    
    return scratch
end

function Scratch:init(name)
    self._scratchName=name
    self:initWithParticle()
end
function Scratch:iniWithData()
    local scratchdata=getScratchInfo("2001")
    
    self._minLength=scratchdata.minLength
    self._maxLength=scratchdata.maxLength
    
    self._minAtk=scratchdata.minAtk
    self._maxAtk=scratchdata.maxAtk
    
    self._minRealLength=scratchdata.realMinLength
    self._maxRealLength=scratchdata.realMaxLength
    
    self._minReboundSpeed=scratchdata.minReboundSpeed
    self._maxReboundSpeed=scratchdata.maxReboundSpeed

    self._critLength=scratchdata.critLength
end

--///////////////////////初始化效果，数据////////////////////////////
function Scratch:initWithPowerSlider()
    local progressBg = cc.Sprite:create("SGpowerSliderbg.png");
    local progress=cc.Sprite:create("SGpowerSlider.png");

    self.powerSlider= PowerSlider:create(progress);
    self.powerSlider:setBackground(progressBg);

    self.powerSlider:setPosition(cc.p(DirectorUtils.getWinWidth()/10*9,DirectorUtils.getWinHeight()/4))
    self.powerSlider:setPercentage(100);
    self.powerSlider:setMinLength(self._minLength);
    self.powerSlider:setMaxLength(self._maxLength);
    self.powerSlider:setCritLength(self._critLength);
    self.powerSlider:setMinRealLength(self._minRealLength);
    self.powerSlider:setMaxRealLength(self._maxRealLength);
    self.powerSlider:setCritMark("SGpowerSliderMark.png");

    self:addChild(self.powerSlider);
end

function Scratch:initWithLine()
    self.line=DrawScratchLine:create()
    self.line:setVisible(false)
    self.line:restDrawPoint()
    self:addChild(self.line)

end

function Scratch:initWithScratchSprite()
    self._scratchSprite=cc.Scale9Sprite:create("scratch001.png")
    self._testScratchSprite=cc.Sprite:create("scratch001.png")
    self._testScratchSprite:setVisible(false)
    self._scratchSprite:setVisible(false)
    self:addChild(self._scratchSprite)
end

function Scratch:initWithPhysicsBody()
 --物理引擎刚体
    local spriteSize=cc.size(self._scratchSprite:getContentSize().width,self._scratchSprite:getContentSize().height)
--    local spriteSize=cc.size(self._scratchSprite:getContentSize().width,1)
    self._ballBodyTwo=cc.PhysicsBody:createBox(cc.size(spriteSize.width*self._scale,spriteSize.height),cc.PhysicsMaterial(0.1, 0.5, 0.5))
    self._ballBodyTwo:setDynamic(false)
    self._ballBodyTwo:getShape(0):setGroup(BattleGroup.ScratchGroup)
    self._ballBodyTwo:getShape(0):setRestitution(1.1)
    self._ballBodyTwo:getShape(0):setFriction(0.0)
    self._ballBodyTwo:getShape(0):setDensity(1.0)
    
    self._ballBodyTwo:setGravityEnable(true)
    self._ballBodyTwo:setCategoryBitmask(0x0010)
    self._ballBodyTwo:setCollisionBitmask(0x0010)
    self._ballBodyTwo:setContactTestBitmask(0x0010)
    self._ballBodyTwo:retain()
end

function Scratch:initWithParticle()
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

--///////////////////////初始化效果，数据////////////////////////////

function Scratch:setBeginScratchStatus(beginPoint)

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


--///////////////////////////////坐标点/////////////////////////////////
function Scratch:setScratchBeginPoint(beginPoint)    
    if (self._scratch_status~=Scratch_status.K_Scratch_None) then
        return
    end

    self:setBeginScratchStatus(beginPoint)
    self.line:setS_beginPoint(beginPoint)

end

function Scratch:setScratchMovePoint(movePoint)
    if self._scratch_status~=Scratch_status.K_Scratch_None then
        return;
    end
    
    self.s_endPoint=movePoint;
    self:setParticleState(false)
    self.line:setVisible(true)
    self.line:setS_endPoint(movePoint)
end

function Scratch:setScratchEndPoint(endPoint)
    if self._scratch_status ~= Scratch_status.K_Scratch_None then
        return;
    end
    
    self.s_endPoint=endPoint;
    self:setScratchState(true);
    self:setParticleState(true);
    self.line:setVisible(false)
    
    
end
--///////////////////////////////坐标点/////////////////////////////////


function Scratch:getTouchDuration() 
    
    local startInWorldSpace=self:convertToNodeSpace(self.s_beginPoint);
    local sp=cc.p(startInWorldSpace.x,startInWorldSpace.y);
    
    --设置变形的大小
    local tergetInNodeSpace=self:convertToNodeSpace(self.s_endPoint);
    local beginAddSpriteWidth=self:convertToNodeSpace(sp);
    
    local duration=getDistanceBetween(beginAddSpriteWidth,tergetInNodeSpace)
    --beginAddSpriteWidth.getDistance(tergetInNodeSpace);
    return duration
end

--//////////////////////////现实挡板 效果///////////////////////
function Scratch:showScratch(duration) 
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
    if self.s_endPoint.y>self.s_beginPoint.y then
        self._AppleAngle=getGLAngle(self.s_endPoint.x,self.s_endPoint.y, sp.x,sp.y)
    else
        self._AppleAngle=getGLAngle(sp.x,sp.y,self.s_endPoint.x,self.s_endPoint.y)
    end
    self._angle=-angle;
    
    self._scratchSprite:setRotation(self._angle);
    self._testScratchSprite:setRotation(self._angle);
    print("self._angle========",self._angle)
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
    
    self._scratchSize=cc.size(duration, 32);
    self._scratchSprite:setPreferredSize(self._scratchSize)
    self._scratchSprite:setPhysicsBody(self._ballBodyTwo);
    self._scratchSprite:setPosition(lastPoint);
    self._scratchSprite:setVisible(true);
    
--    self:initMoguSprite(duration,self._angle)
    --self:initMoguSprite(duration,angle)
end

function Scratch:setBuffAddition(addition,time) 

end   

function Scratch:progressPercentageSetter(percentage,isAdd)    
    --伤害加成
    local lengthAtk=self._maxAtk-self._minAtk
    --划线挡板加成
    self._hurtAddition=self._minAtk+lengthAtk*(percentage/100)
    --buff伤害加成
    self._hurtAddition=self._hurtAddition+self._hurtAddition*self._buffAddition
    
    --速度加成
    local speedDifference=self._maxReboundSpeed-self._minReboundSpeed
    self._speedAddition=self._minReboundSpeed+speedDifference*(percentage/100)
    --buff速度加成
    self._speedAddition=self._speedAddition+self._speedAddition*self._buffAddition
end

function Scratch:setScratchState(isEnd) 
    local duration=self:getTouchDuration()
    
    if (duration>=self._minLength) then
        self.powerSlider:progressTo(duration)
        if isEnd then
            self:progressPercentageSetter(self.powerSlider:getPercentage(),true)
            self:showScratch(duration)
        end
    end
end


function Scratch:setParticleState(isEnd) 
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

function Scratch:setScratchStatus(var) 
    self._scratch_status=var;
end
--//////////////////////////现实挡板 效果///////////////////////

--///////////////////////////////还原挡板///////////////////////
function Scratch:reset() 
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
--///////////////////////////////还原挡板///////////////////////

--//////////////////////////////////动画///////////////////////////////
local Mogu={2,1,5,3,4,5,2,3,1,4}
local MoguSize={79,67,55,57,77}
--
function Scratch:initMoguSprite(duration,angle)
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
function Scratch:initcache()
        
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
    ScratchSprite:MoguTanAction(5,ScratchSprite.Mogutan)
    print("ScratchSprite:MoguTanActionEEEEEEEEEEEEEEENNNNNNNNNNDDDDDDDDDDDDD")
end
--蘑菇生长动画
function Scratch:MoguAction(i,n,size)
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
function Scratch:MoguTanAction(i,Mogtable)
    print("ScratchSprite:MoguTanActionBEEEEEEEEEEEEEEEEGGGGGGGGGGGGGGIN")
    local moguT={}
    copyTable(Mogtable,moguT)
    print("Mogtable::::::::::::::::::%s",#Mogtable)
   -- for var=1,#moguT,1 do 
        local str_name = string.format("scratchmogutan_%s",moguT[i])
        --local animantion_mogu =cc.Animation:create()
        print("%s",str_name)
    
        local animantion_mogu=cc.AnimationCache:getInstance():getAnimation(str_name)
        animantion_mogu:setDelayPerUnit(0.07)--一张图片跳到下一张的间隔
        animantion_mogu:setRestoreOriginalFrame(false)

        local action_mogu=cc.Animate:create(animantion_mogu);
        local delt=cc.DelayTime:create(math.abs(i-i)*0.08)
        local callback = cc.CallFunc:create(MoguCallBack)
        local scale = cc.ScaleBy:create(0.025,1.5)
        
        local spaw=cc.Spawn:create(action_mogu,scale)
    local action =cc.Sequence:create(delt,spaw,callback)
        --self.mogutable[var]:setScale(1.5)
        self.mogutable[i]:runAction(action)
        self.mogutable[i]:setAnchorPoint(cc.p(0.5,0))
  --  end
    
end

--蘑菇反弹碰撞判断
function Scratch:MoguColling(bulletPoint)
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
--//////////////////////////////////动画///////////////////////////////


--//////////////////////////////////buff加成///////////////////////////////
function Scratch:setBuffAddition(addition,time)
    self._buffAddition=addition
    self._buffTime=time
    
    local function restBufffAddition(dt)
        self._addBuffTime=self._addBuffTime+dt
        if self._addBuffTime>=self._buffTime then
            self._buffAddition=0
            self._buffTime=0
            
            if self.buffAdditionSchedule then
                cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.buffAdditionSchedule)
                self.buffAdditionSchedule=nil
            end
        end
    end
    
    self.buffAdditionSchedule=cc.Director:getInstance():getScheduler():scheduleScriptFunc(restBufffAddition,1, false)
    
end

--//////////////////////////////////buff加成///////////////////////////////

--//////////////////////////////////数据///////////////////////////////
function Scratch:setThichness(n)
    self._thichness=self._thichness+n
end

function Scratch:getThichness()
    return self._thichness
end

function Scratch:getHurtAddition()
    return self._hurtAddition
end

function Scratch:getSpeedAddition()
    return self._speedAddition
end

function Scratch:getMaxReboundSpeed()
    return self._maxReboundSpeed
end

function Scratch:getScratchSize()
    return self._scratchSize
end

function Scratch:getAngle()
    
    return self._angle
end

function Scratch:getcurScratchLenth()
    return self._scratchLength
end

function Scratch:getAppleAngle()
    return self._AppleAngle
end
--//////////////////////////////////数据///////////////////////////////

return Scratch