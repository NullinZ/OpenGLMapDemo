//
//  Ball.m
//  OpenglESDemo
//
//  Created by Nullin on 11-8-4.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "Cylinder.h"

#define MOD(X, Y, Z) sqrt( X*X+Y*Y+Z*Z)
@implementation Cylinder

-(void)loadTexture{
    CGImageRef textureImage = [UIImage imageNamed:@"tile.jpg"].CGImage;
    if (textureImage == nil) {
        NSLog(@"Failed to load texture image");
        return;
    }
    
    NSInteger texWidth = CGImageGetWidth(textureImage);
    NSInteger texHeight = CGImageGetHeight(textureImage);
    GLubyte *textureData = (GLubyte *)malloc(texWidth * texHeight * 4);
    
    CGContextRef textureContext = CGBitmapContextCreate(
                                                        textureData,
                                                        texWidth,
                                                        texHeight,
                                                        8, texWidth * 4,
                                                        CGImageGetColorSpace(textureImage),
                                                        kCGImageAlphaPremultipliedLast);
    
    CGContextDrawImage(textureContext,
                       CGRectMake(0.0, 0.0, (float)texWidth, (float)texHeight),
                       textureImage);
    
    CGContextRelease(textureContext);
    
    glGenTextures(10, &textures[0]);
    glBindTexture(GL_TEXTURE_2D, textures[0]);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texWidth, texHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, textureData);
    free(textureData);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
}

-(id)init{
    self = [super init];
    if (self) {
        const float PI = 3.1415923f;
        radius = 2;
        section = 32;
        height = 8;
        float hh = 3.0f;
        vsize = section * height ;
        vertex = malloc(3 * vsize * sizeof(float));
        normal = malloc(3 * vsize * sizeof(float));
        texCoor = malloc(2 * vsize *sizeof(GLfloat));
        
        indices = malloc(6 * vsize * sizeof(float));
        color = malloc(4 * section * sizeof(float));
        float factor = 1.0f;
        for (int v = 0; v < height; v++) {
            for (int h = 0 ; h < section; h++) {
                int index = (v * section + h);
//                if (index%6 == 0) {
//                    factor = 1.5f;
////                }else if(index%7 == 0){
////                    factor = 0.8f;
//                }
//                else{
//                    factor = 1.0f;
//                }
                vertex[3 * index  + 2] = factor * sinf(h*1.0f/section * 2 * PI);
                vertex[3 * index] = factor * cosf(h*1.0f/section * 2 * PI);
                vertex[3 * index  + 1] = hh * v * 1.0f / height - hh/2;
                
                texCoor[2 * index+ 1] = 1 - (float)v / (height- 1);
                texCoor[2 * index] = 1 - (float)h / (section - 1);
                
                float mod=sqrtf(vertex[3 * index]*vertex[3 * index]+
                                vertex[3 * index+1]*vertex[3 * index+1]+ 
                                0);
                normal[3 * index    ] = vertex[3 * index    ] / mod;
                normal[3 * index + 1] = vertex[3 * index + 1] / mod;
                normal[3 * index + 2] = 0;
                
                if (v != height - 1) {
                    if (h != section - 1) {
                        indices[index * 6  ] = v * section + h;
                        indices[index * 6+1] = (v + 1) * section + h;
                        indices[index * 6+2] = v * section + h + 1;
                        
                        indices[index * 6+3] = (v + 1) * section + h ;
                        indices[index * 6+4] = ((v + 1) * section + h) + 1;
                        indices[index * 6+5] = (v * section + h) + 1;
                        
                    }else{
                        indices[index * 6  ] = (v * section + h);
                        indices[index * 6+1] = (v + 1) * section + h;
                        indices[index * 6+2] = (v * section ) ;
                        
                        indices[index * 6+3] = (v + 1) * section + h;
                        indices[index * 6+4] = (v + 1) * section ;
                        indices[index * 6+5] = v * section;
                    }
                    
                }
            }
        }
    }

    [self loadTexture];

    return self;
}
-(void)draw{
    glPushMatrix();
    glColor4f(1, 1, 1,1);
//    glEnableClientState(GL_COLOR_ARRAY);
//    glColorPointer(4, GL_FLOAT, 0, color);
    glEnable(GL_TEXTURE_2D);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    
    
    glEnableClientState(GL_NORMAL_ARRAY);//打开法向量缓冲
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glNormalPointer(GL_FLOAT, 0, normal);
    glDrawElements(GL_TRIANGLES, 6*vsize, GL_UNSIGNED_BYTE, indices);
    //    glDrawArrays(GL_TRIANGLES, 0, vsize * 3);
//    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_NORMAL_ARRAY);//打开法向量缓冲
    glPopMatrix();
    
}
@end
