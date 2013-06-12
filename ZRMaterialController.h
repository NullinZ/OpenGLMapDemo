//
//  ZRMaterialController.h
//  SpaceRocks
//
//  Created by ben smith on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"
#import <QuartzCore/QuartzCore.h>

@class ZRTexturedQuad;
@class ZRAnimatedQuad;

@interface ZRMaterialController : NSObject {
	NSMutableDictionary * materialLibrary;
	NSMutableDictionary * quadLibrary;
}

+ (ZRMaterialController*)sharedMaterialController;
- (ZRAnimatedQuad*)animationFromAtlasKeys:(NSArray*)atlasKeys;
- (ZRTexturedQuad*)quadFromAtlasKey:(NSString*)atlasKey;
- (ZRTexturedQuad*)texturedQuadFromAtlasRecord:(NSDictionary*)record 
                                     atlasSize:(CGSize)atlasSize
                                   materialKey:(NSString*)key;;
- (CGSize)loadTextureImage:(NSString*)imageName materialKey:(NSString*)materialKey;
- (id) init;
- (void) dealloc;
- (void)bindMaterial:(NSString*)materialKey;
- (void)loadAtlasData:(NSString*)atlasName;

// 9 methods




@end
