//
//  Wall.m
//  OpenglESDemo
//
//  Created by Nullin on 11-8-4.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "Wall.h"

@interface Wall (Private) 
-(void)loadTexture;

@end



@implementation Wall
-(id)init{
    self = [super init];
    if (self) {
        width = .2f;
        height = .2f;
        vSize = 4;
        vertex = malloc(3 * vSize * sizeof(float));
        indeices = malloc(6 *sizeof(GLubyte));
        texCoor = malloc(2 * vSize *sizeof(GLfloat));
        
        vertex[0] = -width;
        vertex[1] = height / 2;
        vertex[2] = 0;
        
        vertex[3] = width;
        vertex[4] = height / 2;
        vertex[5] = 0;

        vertex[6] = width;
        vertex[7] = -height / 2;
        vertex[8] = 0;

        vertex[9] = -width;
        vertex[10] = -height / 2;
        vertex[11] = 0;
        
        indeices[0] = 0;
        indeices[1] = 3;
        indeices[2] = 1;
        indeices[3] = 1;
        indeices[4] = 3;
        indeices[5] = 2;
        
        
        texCoor[0] = 0;
        texCoor[1] = 0;
        
        texCoor[2] = 1;
        texCoor[3] = 0;
        
        texCoor[4] = 1;
        texCoor[5] = 1;
        
        texCoor[6] = 0;
        texCoor[7] = 1;
        

        
        [self loadTexture];
}
    
    return self;
}
float bz = -1.001f;
-(void)draw{
    glPushMatrix();
    glEnable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);

    glBindTexture(GL_TEXTURE_2D, textures[3]);
    glTranslatef(1.1f, 0.8f, bz);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    

    glLoadIdentity();
    glTranslatef(-1.1f, 0.8f, bz);
    glRotatef(180, 0, 1, 0);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glLoadIdentity();    
    glTranslatef(1.1f, -0.8f, bz);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    

    glLoadIdentity();
    glTranslatef(-1.1f, -0.8f, bz);
    glRotatef(180, 0, 1, 0);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glLoadIdentity();
    glTranslatef(-1.2, -0.5f, bz);
    glRotatef(90, 0, 0, 1);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glLoadIdentity();
    glTranslatef(-1, -0.5f, bz);
    glRotatef(-90, 0, 0, 1);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glLoadIdentity();
    glTranslatef(1.2, -0.5f, bz);
    glRotatef(90, 0, 0, 1);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glLoadIdentity();
    glTranslatef(1, -0.5f, bz);
    glRotatef(-90, 0, 0, 1);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_BYTE, indeices);
    
    glDisable(GL_BLEND);
    glPopMatrix();
}


-(void)loadTexture{
    TextureLoader *tl = [TextureLoader shareTextureLoader];
    textures = [tl textures];
    CGImageRef textureImage0 = [UIImage imageNamed:@"next.png"].CGImage;
    [tl loadTextureWith:textureImage0 Index:3];
    CGImageRef textureImage1 = [UIImage imageNamed:@"preview.png"].CGImage;
    [tl loadTextureWith:textureImage1 Index:4];
}

@end
