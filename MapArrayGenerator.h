//
//  MapArrayGenerator.h
//  OpenglESDemo
//
//  Created by &#36213; &#30427; on 11-8-19.
//  Copyright (c) 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString-Hex.h"
@interface MapArrayGenerator : NSObject
{
    NSArray *maps;
}
@property (nonatomic, retain) NSArray *maps;
-(id)init;
-(int *)loadMapWithIndex:(int)index Array:(int **)map Size:(int *)sizeVar;
@end
