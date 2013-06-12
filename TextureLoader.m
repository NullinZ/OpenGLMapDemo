//
//  TextureLoader.m
//  OpenglESDemo
//
//  Created by Nullin on 11-8-8.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "TextureLoader.h"


@implementation TextureLoader

+(TextureLoader*)shareTextureLoader{
    static TextureLoader *tl;
    @synchronized(self){
        if (!tl) {
            tl = [[TextureLoader alloc] init];
        }
    }
    return tl;
}
-(GLuint*)textures{
    return textures;
}
-(void)loadTextureWith:(CGImageRef )image Index:(int)index{
    if (image == nil) {
        NSLog(@"Failed to load texture image");
        return;
    }
    
    NSInteger texWidth = CGImageGetWidth(image);
    NSInteger texHeight = CGImageGetHeight(image);
    GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
    
    CGContextRef textureContext = CGBitmapContextCreate(
                                                        textureData,
                                                        texWidth,
                                                        texHeight,
                                                        8, texWidth * 4,
                                                        CGImageGetColorSpace(image),
                                                        kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(textureContext,
                       CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight),
                       image);
    
    CGContextRelease(textureContext);
    
    glBindTexture(GL_TEXTURE_2D, textures[index]);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
    free(textureData);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
}
@end
