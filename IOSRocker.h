//
//  IOSRocker.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-2.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "IRocker.h"

@interface IOSRocker : NSObject<IRocker> {
    
    float position[3];
    float angle[3];
    float tposition[3];
    float tangle[3];
    CGPoint p1,p2;
    
    
    float factorA;
    float factorO;
    int pointsCount;
}

@end
