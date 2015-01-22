--子弹

--
----香蕉
--bu1={
--    velocity=300,          --子弹发射速度
--    angularVelocity=15,    --旋转速度
--    pic="banana.png",      --子弹的图片
--    name="banana",
--
--}
--
----松果
--bu2={
--    velocity=350,          --子弹发射速度
--    angularVelocity=5,    --旋转速度
--    pic="acorn.png",      --子弹的图片
--    name="acorn",     
--}
--
----小鸟
--bu3={
--    velocity=400,          --子弹发射速度
--    angularVelocity=0,    --旋转速度
--    pic="xiaoniao.png",      --子弹的图片
--    rotatex=0.0,          --子弹偏转力
--    rotatey=-0.0, 
--    name="xiaoniao",  
--    isAnimate=true, 
--    reboundangularVelocity=3, --小鸟反弹之后旋转速度     
--}
--
----蘑菇
--bu4={
--    velocity=250,          --子弹发射速度
--    angularVelocity=0,    --旋转速度
--    pic="mogu.png",      --子弹的图片
--    name="mogu",
--    rotatex=0.0,          --子弹偏转力
--    rotatey=-0.0,        
--}
--
----小鸟快速
--bu100={
--    velocity=600,          --子弹发射速度
--    angularVelocity=0,    --旋转速度
--    pic="xiaoniao.png",      --子弹的图片
--    rotatex=0.0,          --子弹偏转力
--    rotatey=-0.0,        
--    name="xiaoniao",  
--    isAnimate=true, 
--    reboundangularVelocity=1, --小鸟反弹之后旋转速度     
--}
--
----香蕉
bu1={
    velocity=290,          --子弹发射速度
    angularVelocity=15,    --旋转速度
    pic="banana.png",      --子弹的图片
    name="banana",
    

}

--松果
bu2={
    velocity=320,          --子弹发射速度
    angularVelocity=5,    --旋转速度
    pic="acorn.png",      --子弹的图片
    name="acorn",     
    sliceParticle="bu1_splurt.plist",
}

--小鸟
bu3={
    velocity=340,          --子弹发射速度
    angularVelocity=0,    --旋转速度
    pic="xiaoniao.png",      --子弹的图片
    rotatex=0.0,          --子弹偏转力
    rotatey=-0.0, 
    name="xiaoniao",  
    isAnimate=true, 
    reboundangularVelocity=3, --小鸟反弹之后旋转速度     
    sliceParticle="bu1_splurt.plist",
}

--蘑菇
bu4={
    velocity=280,          --子弹发射速度
    angularVelocity=0,    --旋转速度
    pic="mogu.png",      --子弹的图片
    name="mogu",
    rotatex=0.0,          --子弹偏转力
    rotatey=-0.0,        
    sliceParticle="bu1_splurt.plist",
}

--小鸟快速
bu100={
    velocity=400,          --子弹发射速度
    angularVelocity=0,    --旋转速度
    pic="xiaoniao.png",      --子弹的图片
    rotatex=0.0,          --子弹偏转力
    rotatey=-0.0,        
    name="xiaoniao",  
    isAnimate=true, 
    reboundangularVelocity=1, --小鸟反弹之后旋转速度     
    sliceParticle="bu1_splurt.plist",
}

--鸭子
bu5={
    velocity=420,          --子弹发射速度
    angularVelocity=0,    --旋转速度
    pic="duckBullet.png",      --子弹的图片
    rotatex=0.0,          --子弹偏转力
    rotatey=-0.0, 
    name="duckBullet",  
    isAnimate=true, 
    reboundangularVelocity=3, --小鸟反弹之后旋转速度     
    sliceParticle="bu1_splurt.plist",
}
