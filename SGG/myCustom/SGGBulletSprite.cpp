//
//  SGGBulletSprite.cpp
//  cocos2d_libs
//
//  Created by shuaigougou on 14-10-18.
//
//

#include "SGGBulletSprite.h"

#define ParticleTime 10

SGGBulletSprite::SGGBulletSprite() {
    
}

SGGBulletSprite::~SGGBulletSprite() {
    
}

SGGBulletSprite* SGGBulletSprite::create(const std::string& name) {
    SGGBulletSprite* bulletSprite=new SGGBulletSprite();
    bulletSprite->init(name);
    bulletSprite->autorelease();
    bulletSprite->setIsRebound(false);
    return bulletSprite;
}


void SGGBulletSprite::init(const std::string& name) {
//    Sprite::createWithSpriteFrameName(<#const std::string &spriteFrameName#>)
    
    SpriteFrame *frame = SpriteFrameCache::getInstance()->getSpriteFrameByName(name);
    Sprite::initWithSpriteFrame(frame);
}

void SGGBulletSprite::setHurt(float var) {
    _hurt=var;
}

float SGGBulletSprite::getHurt() {
    return _hurt;
}

void SGGBulletSprite::showParticle(float angle,float rateRatio) {
    particleTime=0;
    GLProgram * glShaderProgram = ShaderCache::getInstance()->getGLProgram(GLProgram::SHADER_NAME_POSITION_COLOR);
    this->getParent()->getParent()->setGLProgram(glShaderProgram);
    _bulletParticle = CCParticleSystemQuad::create("bulletParticle1.plist") ;
    _bulletParticle->setPositionType(ParticleSystem::PositionType::GROUPED);
    _bulletParticle->setAngle(angle-180);
    int rate=_bulletParticle->getTotalParticles();
    rate=rate*rateRatio;
    _bulletParticle->setEmissionRate(rate);
    Point point=this->getPosition();
    _bulletParticle->setPosition(point);
    this->getParent()->getParent()->addChild(_bulletParticle, 0, k_BulletParticle);
    this->schedule(schedule_selector(SGGBulletSprite::hideParticle), 0.01f, ParticleTime, 0);
}
void SGGBulletSprite::hideParticle(float dt){
    particleTime++;
    if (particleTime>=ParticleTime) {
        this->getParent()->getParent()->removeChild(_bulletParticle);
        _bulletParticle=nullptr;
    }else {
        if (this->getParent()->getParent()->getChildByTag(k_BulletParticle)) {
            Point point=this->getPosition();
            _bulletParticle->setPosition(point);
        }
    }
}
void SGGBulletSprite::removeBullet(){
    this->unscheduleAllSelectors();
    if (this->getParent()->getParent()->getChildByTag(k_BulletParticle)) {
        this->getParent()->getParent()->removeChild(_bulletParticle);
        _bulletParticle=nullptr;
    }
    
}
