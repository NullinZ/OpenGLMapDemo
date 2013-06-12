//
//  TextureLoader.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-8.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface TextureLoader : NSObject {
    GLuint textures[10];
}
+(TextureLoader*)shareTextureLoader;
-(GLuint*)textures;
-(void)loadTextureWith:(CGImageRef )image Index:(int)index;

@end
