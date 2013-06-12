//
//  OpenglESDemoViewController.h
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Sphere.h"
#import "Cylinder.h"
#import "Wall.h"
#import "IOSRocker.h"
#import "Map.h"
#import "MapArrayGenerator.h"
#import "TextureLoader.h"
#import "ZRMaterialController.h"

@interface OpenglESDemoViewController : UIViewController {
@private
    EAGLContext *context;
    GLuint program;
    Sphere *sphere;
    Wall *wall;
    Map *map;
    Cylinder *cylinder;
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
    id<IRocker> rocker;
    GLuint *textures;
    ZRMaterialController *materialController;
    ZRTexturedQuad *padMargin, *padMarginActive;

}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
