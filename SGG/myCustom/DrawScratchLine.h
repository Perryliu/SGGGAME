//
//  DrawScratchLine.h
//  SGGLuaGame
//
//  Created by shuaigougou on 14/11/5.
//
//

#ifndef __SGGLuaGame__DrawScratchLine__
#define __SGGLuaGame__DrawScratchLine__

#include "cocos2d.h"

USING_NS_CC;


class DrawScratchLine:public Node {
    
public:
    static DrawScratchLine* create();
    bool init();
    void restDrawPoint();
    CC_SYNTHESIZE(Point, s_beginPoint, S_beginPoint);
    CC_SYNTHESIZE(Point, s_endPoint, S_endPoint);
    
    virtual void draw(Renderer *renderer, const Mat4 &transform, uint32_t flags) override;
    
    void onDraw(const Mat4 &transform, uint32_t flags);
private:
    CustomCommand _command;
};

#endif /* defined(__SGGLuaGame__DrawScratchLine__) */
