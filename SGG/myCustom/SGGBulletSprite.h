//
//  SGGBulletSprite.h
//  cocos2d_libs
//
//  Created by shuaigougou on 14-10-18.
//
//

#ifndef __cocos2d_libs__SGGBulletSprite__
#define __cocos2d_libs__SGGBulletSprite__

#include "cocos2d.h"

USING_NS_CC;

typedef enum {
    k_BulletParticle=100,
}BulletParticleEnum;

class SGGBulletSprite:public Sprite {
    
public:
    SGGBulletSprite();
    ~SGGBulletSprite();
    
    static SGGBulletSprite* create(const std::string& name);
    void init(const std::string& name);
    void showParticle(float angle,float rateRatio);
    void hideParticle(float dt);
    void removeBullet();
    
    //bulletParticle1.plist
    CC_PROPERTY(float, _hurt, Hurt);
    CC_SYNTHESIZE(Size, _bulletSize, BulletSize);
    CC_SYNTHESIZE(float, _bulletScale, BulletScale);
    CC_SYNTHESIZE(bool, _isRebound, IsRebound);
protected:
    //Á£×ÓÐ§¹û
    ParticleSystem* _bulletParticle ;
    int particleTime;
    int moveTime;
};

#endif /* defined(__cocos2d_libs__SGGBulletSprite__) */
