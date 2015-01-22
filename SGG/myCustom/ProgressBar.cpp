//
//  ProgressBar.cpp
//  FishingJoy
//
//  Created by Ringo_D on 12-9-30.
//
//

#include "ProgressBar.h"


USING_NS_CC;
enum{
    k_Progress_Action = 0
};
ProgressBar* ProgressBar::create(Sprite *sprite)
{
    ProgressBar* progress = new ProgressBar();
    progress->initWithBarSprite(sprite);
    progress->autorelease();
    return progress;
}
bool ProgressBar::initWithBarSprite(Sprite *sprite)
{
    ProgressTimer::initWithSprite(sprite);
    this->setVisible(false);
    this->setMidpoint(Point(0, 0.5));
    this->setType(ProgressTimer::Type::BAR);
    this->setBarChangeRate(Point(1, 0));
    
    isFinished = false;
    isAdd=false;
    return true;
}
void ProgressBar::progressBy(float delta)
{
    if (isFinished) {
        return;
    }
    if(delta<0) {
        isAdd=false;
    }else {
        isAdd=true;
    }
    
    float maxPercentage=100.0f;
    float pFrom =this->getPercentage();
    _currcentHp=_currcentHp+delta;
    if (_currcentHp<=0) {
        isFinished=true;
    }
    this->stopActionByTag(k_Progress_Action);
    float pTo=_currcentHp/c_Hp*maxPercentage;
    this->setVisible(true);
    Vector<cocos2d::FiniteTimeAction *> _actionDatas;
    
    ProgressFromTo *to2 = ProgressFromTo::create(0.2, pFrom, pTo);
    _actionDatas.pushBack(to2);
    auto callFunc = CallFunc::create(CC_CALLBACK_0(ProgressTimer::setVisible,this,false));
    if (isFinished) {
//        auto callFuncEnd = CallFunc::create(CC_CALLBACK_0(ProgressBar::ProgressEnd,this));
//        _actionDatas.pushBack(callFuncEnd);
    }
    FiniteTimeAction* seq = Sequence::create(_actionDatas);
    
//    CallFunc* updatePercentage = CallFunc::create(CC_CALLBACK_0(ProgressBar::updatePercentage,this,_currcentHp,isAdd));
//    Spawn* spawn = Spawn::createWithTwoActions(seq, updatePercentage);
    auto action=Sequence::create(seq,callFunc, NULL);
    action->setTag(k_Progress_Action);
    this->runAction(action);
}
void ProgressBar::progressTo(float destination)
{
    this->progressBy(destination);
}


void ProgressBar::setBackground(Node* bg)
{
    this->removeChild(_background,true);
    _background = bg;
    Size size = this->getSprite()->getContentSize();
    _background->setPosition(Point(size.width*0.5, size.height*0.5));
    this->addChild(_background, -1);
}
Node* ProgressBar::getBackground()
{
    return _background;
}
