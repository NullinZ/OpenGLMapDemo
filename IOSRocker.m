//
//  IOSRocker.m
//  OpenglESDemo
//
//  Created by Nullin on 11-8-2.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "IOSRocker.h"
#import "OpenGLCommon.h"

@implementation IOSRocker
-(id)init{
    self = [super init];
    if (self) {
        factorA = .5f;
        factorO = .02f;
        pointsCount = 0;
    }
    return self;
}
-(void)transfer{
    glRotatef(angle[0], 1, 0, 0);
    glRotatef(angle[1], 0, 1, 0);
    glTranslatef(position[0], 0, position[1]);
}
-(void)doEvent:(NSSet *)touches view:(UIView *)view eventType:(EventType)eventType{
    if ([[touches anyObject] tapCount]>2) {
        [self reset];
    }
    p1 = [[touches anyObject] locationInView:view];
    if (EVENT_TYPE_MOVE != eventType) {
        if (eventType == EVENT_TYPE_BEGIN) {
            pointsCount+=[touches count];

        }else{
            pointsCount-=[touches count];

        }
        if (pointsCount > 1) {
            p2 = [[touches anyObject] locationInView:view];
        }
        if (pointsCount == 1) {
            tangle[0] = p1.y;
            tangle[1] = p1.x;
        } else {
            tposition[0] = (p1.x + p2.x) / 2;
            tposition[1] = (p1.y + p2.y) / 2;
        }        
    }else{
        if (pointsCount == 1) {
            angle[0] += (p1.y - tangle[0]) * factorA;
            angle[1] += (p1.x - tangle[1]) * factorA;
            tangle[0] = p1.y;
            tangle[1] = p1.x;
        } else {

            if (position[1] < -17) {
                position[1] = -17;
                return;
            }else if(position[1] > 17){
                position[1] = 17;
                return;
            }
            position[0] += ((p1.x + p2.x) / 2 - tposition[0]) * factorO;
            position[1] -= ((p1.y + p2.y) / 2 - tposition[1]) * factorO;
            tposition[0] = (p1.x + p2.x) / 2;
            tposition[1] = (p1.y + p2.y) / 2;
        }
    }
}

-(void)reset{
    tposition[0] = 0;
    tposition[1] = 0;
    tposition[2] = 0;
    position[0] = 0;
    position[1] = 0;
    position[2] = 0;
    tangle[0] = 0;
    tangle[1] = 0;
    tangle[2] = 0;
    angle[0] = 0;
    angle[1] = 0;
    angle[2] = 0;
    p1 = CGPointMake(0, 0);
    p2 = CGPointMake(0, 0);
    pointsCount = 1;
}
@end
