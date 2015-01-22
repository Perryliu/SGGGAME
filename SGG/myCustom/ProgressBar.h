//
//  ProgressBar.h
//  FishingJoy
//
//  Created by Ringo_D on 12-9-30.
//
//

#ifndef __FishingJoy__ProgressBar__
#define __FishingJoy__ProgressBar__
#include "cocos2d.h"

class ProgressBar : public cocos2d::ProgressTimer
{
public:

    static ProgressBar* create(cocos2d::Sprite *sprite);
    
    bool initWithBarSprite(cocos2d::Sprite *sprite);

    void progressBy(float delta);

    void progressTo(float destination);

    CC_SYNTHESIZE(float, _currcentHp, CurcentHp);
    CC_SYNTHESIZE(float, c_Hp, C_Hp);

    CC_PROPERTY(cocos2d::Node*, _background, Background);
protected:
    
    bool isFinished;
    bool isAdd;
    
};

#endif /* defined(__FishingJoy__ProgressBar__) */
