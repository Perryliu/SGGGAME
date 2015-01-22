//
//  PowerSlider.h
//  SGGLuaGame
//
//  Created by shuaigougou on 14/11/3.
//
//

#ifndef __SGGLuaGame__PowerSlider__
#define __SGGLuaGame__PowerSlider__

#include "cocos2d.h"
#include "ProgressBar.h"

USING_NS_CC;
using namespace ui;

typedef enum{
    K_GridEnum=100,
}GridEnum;

class PowerSlider:public cocos2d::ProgressTimer{
    
public:
    PowerSlider();
    ~PowerSlider();
    
    static PowerSlider* create(cocos2d::Sprite *sprite);
    bool initWithSprite(cocos2d::Sprite *sprite);
    
    void progressTo(float length);
    void setCritMark(const std::string& name);
    void restSlider();
    
    //最慢最快速度
    CC_SYNTHESIZE(float,_minRealLength,MinRealLength);
    CC_SYNTHESIZE(float,_maxRealLength,MaxRealLength);
//
   //攻击力
    CC_SYNTHESIZE(float,_critLength,CritLength);
//    CC_SYNTHESIZE(float,_maxAtk,MaxAtk);
    
     //最长最短划线长度
    CC_SYNTHESIZE(float,_minLength,MinLength);
    CC_SYNTHESIZE(float,_maxLength,MaxLength);
    
    CC_PROPERTY(cocos2d::Node*, _background, Background);
    
protected:
    void updatePercentage(float sRate);
    Sprite *markSprite;
    bool isAdd;
    
};


#endif /* defined(__SGGLuaGame__PowerSlider__) */
