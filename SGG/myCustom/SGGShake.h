//
//  SGGShake.h
//  SGGLuaGame
//
//  Created by shuaigougou on 14/12/10.
//
//

#ifndef __SGGLuaGame__SGGShake__
#define __SGGLuaGame__SGGShake__

#include "cocos2d.h"
USING_NS_CC;


class SGGShake : public ActionInterval
{
public:
    SGGShake();
    ~SGGShake();
    
    // Create the action with a time and a strength (same in x and y)
    static SGGShake *create(float d, float strength );
    // Create the action with a time and strengths (different in x and y)
    static SGGShake *createWithStrength(float d, float strength_x, float strength_y );
    bool initWithDuration(float d, float strength_x, float strength_y );
    
    virtual SGGShake* clone() const override;
	virtual SGGShake* reverse(void) const  override;
    
protected:
    
    void startWithTarget(cocos2d::Node *pTarget);
    void update(float time);
    void stop(void);
    
    Point m_StartPosition;
    
    
    // Strength of the action
    float m_strength_x, m_strength_y;
private:
    CC_DISALLOW_COPY_AND_ASSIGN(SGGShake);
};

#endif /* defined(__SGGLuaGame__SGGShake__) */
