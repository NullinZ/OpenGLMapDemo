//
//  Hex.m
//  MapEditorHD
//
//  Created by Nullin on 11-7-13.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "NSString-Hex.h"


@implementation NSString (Hex)
-(int)hexValue{
    unsigned int intValue;
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner scanHexInt:&intValue];
    return intValue;
}
@end
