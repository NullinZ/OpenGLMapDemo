//
//  Wall.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-4.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "TextureLoader.h"
@interface Wall : NSObject {
    GLfloat *vertex;
    GLubyte *indeices;
    GLfloat *color;
    GLfloat *texCoor;
    GLuint *textures;

    
    int vSize;
    float width;
    float height;
    

}
-(void)draw;

@end
