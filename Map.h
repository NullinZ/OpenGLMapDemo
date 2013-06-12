//
//  Map.h
//  OpenglESDemo
//
//  Created by Nullin on 11-8-11.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "OpenGLCommon.h"
#import "MapArrayGenerator.h"
#import "TextureLoader.h"

typedef struct t_stack{
    Vertex3D data; 
    struct t_stack* next;

}Stack;
@interface Map : NSObject {
    int *mapData;
    unsigned int mapWidth;
    unsigned int mapHeight;
    unsigned int curGate;


    Vertex3D *way;
    Vertex3D *wall;
    Vertex3D *block;
    
    int wallCount, wayCount, blockCount;

    float tileSize;
    float wallHeight;
    GLuint *textures;
    
    float *texCoor;
    
}

-(void)previousMap;
-(void)nextMap;
-(void)drawSelf;
@end
