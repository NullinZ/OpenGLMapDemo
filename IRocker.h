//
//  IRocker.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-2.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    EVENT_TYPE_BEGIN,
    EVENT_TYPE_MOVE,
    EVENT_TYPE_END,
}EventType;
@protocol IRocker <NSObject>
-(void)transfer;
-(void)doEvent:(NSSet *)touches view:(UIView*)view eventType:(EventType)eventType;
-(void)reset;
@end
