//
//  SGGShake.cpp
//  SGGLuaGame
//
//  Created by shuaigougou on 14/12/10.
//
//

#include "SGGShake.h"

#include "cocos2d.h"
USING_NS_CC;

// not really useful, but I like clean default constructors
SGGShake::SGGShake() : m_strength_x(0), m_strength_y(0)
{
    
}

// not really useful, but I like clean default constructors
SGGShake::~SGGShake()
{
    
}

SGGShake *SGGShake::create( float d, float strength )
{
    // call other construction method with twice the same strength
    return createWithStrength( d, strength, strength );
}

SGGShake *SGGShake::createWithStrength(float duration, float strength_x, float strength_y)
{
    SGGShake *pRet=new SGGShake();
//
    if (pRet && pRet->initWithDuration(duration, strength_x, strength_y))
    {
        pRet->autorelease();
    }
    else
    {
        CC_SAFE_DELETE(pRet);
    }
    
    
    return pRet;
}

bool SGGShake::initWithDuration(float duration, float strength_x, float strength_y)
{
    if (CCActionInterval::initWithDuration(duration))
    {
        m_strength_x = strength_x;
        m_strength_y = strength_y;
        
        return true;
    }
    
    return false;
}

// Helper function. I included it here so that you can compile the whole file
// it returns a random value between min and max included
static float fgRangeRand( float min, float max )
{
    float rnd = ((float)rand() / (float)RAND_MAX);
    return rnd * (max - min) + min;
}

void SGGShake::update(float dt)
{
    float randx = fgRangeRand( -m_strength_x, m_strength_x ) * dt;
    float randy = fgRangeRand( -m_strength_y, m_strength_y ) * dt;
    
    // move the target to a shaked position
    
    Vec2 vec=Vec2(m_StartPosition.x, m_StartPosition.y);
    vec.add(Vec2(randx, randy));
    _target->setPosition(vec);
}

void SGGShake::startWithTarget(Node *pTarget)
{
    CCActionInterval::startWithTarget( pTarget );
    
    // save the initial position
    m_StartPosition=pTarget->getPosition();
}

void SGGShake::stop(void)
{
    // Action is done, reset clip position
    this->getTarget()->setPosition( m_StartPosition);
    
    CCActionInterval::stop();
}

SGGShake* SGGShake::clone() const
{
	// no copy constructor
	auto s = new SGGShake();
    s->initWithDuration(_duration,m_strength_x, m_strength_y);
	s->autorelease();
	return s;
}

SGGShake* SGGShake::reverse() const
{
    return nullptr;
}
