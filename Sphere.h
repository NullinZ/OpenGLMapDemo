//
//  Sphere.h
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "OpenGLCommon.h"
#import "UIColor-Random.h"
#import "TextureLoader.h"
#define PI 3.1415926
@interface Sphere : NSObject {
    Vertex3D *vertex;
    Color3D *color;
    GLubyte *indices;
    GLfloat *texCoor;
    GLuint *textures;
    CGPoint position;
    
    float radius;
    int vsize;
    int vsection;
    int hsection;
}

-(void)draw;
@end
