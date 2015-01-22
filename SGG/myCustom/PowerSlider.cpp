//
//  PowerSlider.cpp
//  SGGLuaGame
//
//  Created by shuaigougou on 14/11/3.
//
//

#include "PowerSlider.h"

#define heightLength 37
#define bottomLength 22

PowerSlider::PowerSlider() {
    
}

PowerSlider::~PowerSlider() {
    
}


PowerSlider* PowerSlider::create(Sprite *sprite)
{
    PowerSlider* ps = new PowerSlider();
    ps->initWithSprite(sprite);
    ps->autorelease();
    return ps;
}
bool PowerSlider::initWithSprite(Sprite *sprite)
{
    ProgressTimer::initWithSprite(sprite);
    this->setVisible(false);
    this->setMidpoint(Point(0.5, 0));
    this->setType(ProgressTimer::Type::BAR);
    this->setBarChangeRate(Point(0, 1));
    
    return true;
}

void PowerSlider::setCritMark(const std::string& name) {
    markSprite=Sprite::create(name);
    Size psSize=_sprite->getContentSize();
    if (_critLength>_maxRealLength) {
        _critLength=_maxRealLength;
    }
    
    float markHeigth;
    float markWidht;
    
    if (_maxRealLength==_minRealLength) {
//        log("_maxRealLength==_minRealLength");
        markWidht=bottomLength;
        markHeigth=0;
        return;
    }else {
        float subHeight=((_critLength-_minRealLength)/(_maxRealLength-_minRealLength))*psSize.height;
        markHeigth=psSize.height-subHeight;
        markWidht=heightLength-(heightLength-bottomLength)*subHeight/psSize.height;
    }
    markSprite->setPosition(Vec2(markWidht, markHeigth));
    markSprite->setAnchorPoint(Vec2::ANCHOR_MIDDLE_LEFT);
    this->addChild(markSprite);
    
}

void PowerSlider::progressTo(float length) {
    if (!(this->isVisible())) {
        this->setVisible(true);
    }
    
    float lengthDifference=_maxRealLength-_minRealLength;
    float subLength=length-_minRealLength;
    
    if (subLength<0) {
        subLength=0;
    }
    float lengthRate;
    
    if (lengthDifference==0) {
        lengthRate=0;
    }else {
        lengthRate=subLength/lengthDifference;
    }
    
    if(lengthRate>1.0) {
        lengthRate=1.0f;
    }
    
    float slipRate=(1-lengthRate)*100;
    this->setPercentage(slipRate);
    
    if (length<_critLength || _critLength==_maxRealLength) {
        this->updatePercentage(100);
    }else {
        this->updatePercentage(slipRate);
    }
}

//力量条变化调用 isAdd 为true加强 为flase减弱
void PowerSlider::updatePercentage(float sRate)
{
    if (sRate>this->getPercentage()) {
        isAdd=true;
    }else {
        isAdd=false;
    }
}

void PowerSlider::setBackground(Node* bg)
{
    this->removeChild(_background,true);
    _background = bg;
    Size size = this->getSprite()->getContentSize();
    _background->setPosition(Point(size.width*0.5, size.height*0.5));
    this->addChild(_background, -1);
}
Node* PowerSlider::getBackground()
{
    return _background;
}


void PowerSlider::restSlider() {
    this->setVisible(false);
    this->setPercentage(100);
}


