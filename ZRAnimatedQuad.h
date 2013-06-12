//
//  ZRAnimatedQuad.h
//  SpaceRocks
//
//  Created by ben smith on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ZRTexturedQuad.h"


@interface ZRAnimatedQuad : ZRTexturedQuad {
	NSMutableArray * frameQuads;
	CGFloat speed;
	NSTimeInterval elapsedTime;
	BOOL loops;
	BOOL didFinish;
}

@property (assign) CGFloat speed;
@property (assign) BOOL loops;
@property (assign) BOOL didFinish;

- (id) init;
- (void) dealloc;
- (void)addFrame:(ZRTexturedQuad*)aQuad;
- (void)setFrame:(ZRTexturedQuad*)quad;
- (void)updateAnimation;

// 5 methods

@end
