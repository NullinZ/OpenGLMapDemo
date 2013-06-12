//
//  Map.m
//  OpenglESDemo
//
//  Created by Nullin on 11-8-11.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "Map.h"

@interface Map(Private) 
-(void)inimapData;
-(void)initTexture;
-(void)changeMap;
@end

@implementation Map
void pushNode(Stack* header, Vertex3D vertex){
    if(!header){
        return;
    }
    Stack *q = malloc(sizeof(Vertex3D));
    q -> data = vertex;
    q -> next = header -> next;
    header -> next = q;
}
Vertex3D popNode(Stack* header){

    if(!header){
        return Vertex3DMake(-1000, -1000, -1000);
    }
    Stack *q = header -> next;
    Vertex3D vertex = q ->data;
    header -> next = q -> next;
    free(q);
    return vertex;
}

-(id)init{
    self = [super init];
    if (self) {
        curGate = 0;

        [self inimapData];
        [self initTexture];
//        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(changeMap) userInfo:nil repeats:YES];

    }
    return self;
}

-(void)inimapData{
    mapWidth = 22;
    mapHeight = 14;
    tileSize =3.5f;// 0.32f;
    wallHeight = 2.32f;
    MapArrayGenerator * mag = [[MapArrayGenerator alloc] init];
    int size;
    [mag loadMapWithIndex:curGate Array:&mapData Size:&size];
    [mag release];
    Stack* wayList = (Stack*)malloc(sizeof(Stack));
    wayList->next = NULL;
    Stack* wallList= (Stack*)malloc(sizeof(Stack));
    wallList->next = NULL;
    Stack* blockList= (Stack*)malloc(sizeof(Stack));
    blockList ->next = NULL;
    
    wallCount = 0;
    wayCount = 0;
    blockCount = 0;
    
    float width = mapWidth * tileSize;
    float height = mapHeight * tileSize;
    
    for (int i = mapHeight - 1; i >= 0  ; i--) {
        for (int j = mapWidth - 1; j >= 0; j--) {
            float x = j * tileSize - width / 2;
            float y = i * tileSize - height / 2;
            float z = 0;
            int index = i * mapWidth + j;
            if (!mapData[index]) {
                pushNode(blockList, Vertex3DMake(x, y, z));
                pushNode(blockList, Vertex3DMake(x, y + tileSize, z));
                pushNode(blockList, Vertex3DMake(x + tileSize, y, z));
                pushNode(blockList, Vertex3DMake(x, y + tileSize, z));
                pushNode(blockList, Vertex3DMake(x + tileSize, y + tileSize, z));
                pushNode(blockList, Vertex3DMake(x + tileSize, y, z));
                blockCount += 6;
            }else{
                pushNode(wayList, Vertex3DMake(x, y, z - wallHeight));
                pushNode(wayList, Vertex3DMake(x, y + tileSize, z - wallHeight));
                pushNode(wayList, Vertex3DMake(x + tileSize, y, z - wallHeight));
                pushNode(wayList, Vertex3DMake(x, y + tileSize, z - wallHeight));
                pushNode(wayList, Vertex3DMake(x + tileSize, y + tileSize, z - wallHeight));
                pushNode(wayList, Vertex3DMake(x + tileSize, y, z - wallHeight));
                wayCount+= 6;
                if (j%mapWidth > 0 && !mapData[index - 1]) {
                    pushNode(wallList, Vertex3DMake(x, y, z));           
                    pushNode(wallList, Vertex3DMake(x, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z));
                    
                    pushNode(wallList, Vertex3DMake(x, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z));
                    wallCount+=6;
                }
                if(j%mapWidth < mapWidth - 1 && !mapData[index + 1]){
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z));
                    wallCount+=6;
                }
                if(i > 0 && !mapData[index - mapWidth]){
                    pushNode(wallList, Vertex3DMake(x, y, z));
                    pushNode(wallList, Vertex3DMake(x, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z));
                    pushNode(wallList, Vertex3DMake(x, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y, z));
                    wallCount+=6;
                }
                if(i < mapHeight - 1 && !mapData[index + mapWidth]){
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z));
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z));
                    pushNode(wallList, Vertex3DMake(x, y + tileSize, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z - wallHeight));
                    pushNode(wallList, Vertex3DMake(x + tileSize, y + tileSize, z));
                    wallCount+=6;
                }
            }
        }
    }
    
    wall = malloc(wallCount * sizeof(Vertex3D));
    for (int i = 0; i < wallCount; i++) {
        wall[i] = popNode(wallList);
    }
    free(wallList);

    way = malloc(wayCount * sizeof(Vertex3D));
    for (int i = 0; i < wayCount; i++) {
        way[i] = popNode(wayList);
    }
    free(wayList);
    
    block = malloc(blockCount * sizeof(Vertex3D));
    for (int i = 0; i < blockCount; i++) {
        block[i] = popNode(blockList);
    }
    free(blockList);
    
    int textCount = MAX(blockCount, MAX(wallCount, wayCount)) * 2;
    texCoor = malloc(textCount * sizeof(float));
    float texCoorTmp [] = {
        0.0, 0.0,
        0.0, 1.0,
        1.0, 1.0,
        
        0.0, 0.0,       
        1.0, 1.0,
        1.0, 0.0
    };
    for (int i = 0; i < textCount; i++) {
        texCoor[i] = texCoorTmp[i % 12];
    }
   
}

-(void)initTexture{
    TextureLoader * tl = [TextureLoader shareTextureLoader];
    textures = [tl textures];
    CGImageRef textureImage0 = [UIImage imageNamed:@"TileModern.png"].CGImage;
    [tl loadTextureWith:textureImage0 Index:0];
    
    CGImageRef textureImage1 = [UIImage imageNamed:@"Wall.png"].CGImage;
    [tl loadTextureWith:textureImage1 Index:1];
    
    CGImageRef textureImage2 = [UIImage imageNamed:@"way.png"].CGImage;
    [tl loadTextureWith:textureImage2 Index:2];
    
}

-(void)drawSelf{
    glPushMatrix();

    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    gluLookAt(way[0].x, way[0].y, way[0].z+1, way[0].x, way[0].y+.1f, way[0].z+1.0f, 0, 0, 1);

    glBindTexture(GL_TEXTURE_2D, textures[0]);    
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glVertexPointer(3, GL_FLOAT, 0, block);
    glDrawArrays(GL_TRIANGLES, 0, blockCount);
    
    glBindTexture(GL_TEXTURE_2D, textures[1]);    
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glVertexPointer(3, GL_FLOAT, 0, wall);
    glDrawArrays(GL_TRIANGLES, 0, wallCount);
    
    glBindTexture(GL_TEXTURE_2D, textures[2]);    
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glVertexPointer(3, GL_FLOAT, 0, way);
    glDrawArrays(GL_TRIANGLES, 0, wayCount);

    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glPopMatrix();
}
-(void)previousMap{
    if (--curGate == -1) {
        curGate = 29;
    }
    free(block);
    free(wall);
    free(way);
    [self inimapData];
}
-(void)nextMap{
    if (++curGate == 30) {
        curGate = 0;
    }
    free(block);
    free(wall);
    free(way);
    [self inimapData];
}
@end
