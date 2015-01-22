require "Cocos2d"

LightSprite = class ("LightSprite", function ()
    local node = cc.Sprite:create("Bursh.png")
    return node
end)

function LightSprite.create(scale)
    local light = LightSprite.new()
    light:init(scale)    
    
    return light
end

function LightSprite:init(scale)
    local blendFuc = {gl.ZERO, gl.ONE_MINUS_SRC_ALPHA}
    self:setBlendFunc( gl.ZERO, gl.ONE_MINUS_SRC_ALPHA)
    self:setScale(scale);
    self._time=0;
    self:retain()
end
function LightSprite:destroy()
    self:removeFromParent()
end
   
   
function LightSprite:update(dt)
    self._time=self._time+dt
    self:setScale(self._time*5+2);
    --if(time>=0.2
end
       
function LightSprite:InitTexture(point)
    self:setPosition(point);
end   

function LightSprite:destroySelf()
    self:release()
end   
 
return LightSprite