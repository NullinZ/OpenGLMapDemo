//
//  Ball.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-4.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface Cylinder : NSObject {
    GLfloat *vertex;
    GLfloat *normal;
    GLubyte *indices;
    GLfloat *color;
    
    GLfloat *texCoor;
    GLuint textures [10];
    
    
    float radius;
    int vsize;
    int section;
    int height;
}

-(void)draw;

@end
