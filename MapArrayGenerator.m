//
//  MapArrayGenerator.m
//  OpenglESDemo
//
//  Created by &#36213; &#30427; on 11-8-19.
//  Copyright (c) 2011年 Innovation Workshop. All rights reserved.
//

#import "MapArrayGenerator.h"

@implementation MapArrayGenerator
@synthesize maps;
-(id)init{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"mapData" ofType:@"plist"];

        NSDictionary *dic = [[NSDictionary alloc] initWithContentsOfFile:path];
        self.maps = [dic objectForKey:@"Root"];
        [dic release];
    }
    return self;
}
-(int *)loadMapWithIndex:(int)index Array:(int **)map Size:(int *)sizeVar{
    NSArray *mapArr = [[maps objectAtIndex:index] componentsSeparatedByString:@" "];
    *map = malloc(mapArr.count * sizeof(int));
    for (int i = 0; i < [mapArr count]; i++) {
        (*map)[i] = [[mapArr objectAtIndex:i] hexValue];
    }
    *sizeVar = mapArr.count;
    return *map;
}
-(void)dealloc{
    [maps release];
    [super dealloc];
}

@end
