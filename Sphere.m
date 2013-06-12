//
//  Sphere.m
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import "Sphere.h"


@implementation Sphere

-(id)init{
    self = [super init];
    if (self) {
        radius = 0.4;
        hsection = 16;
        vsection = 15;
        vsize = hsection * vsection;
        vertex = malloc(vsize * sizeof(Vertex3D));
        texCoor = malloc(2 * vsize * sizeof(GLuint));
        color = malloc(vsize * sizeof(Color3D));
        indices = malloc(6 * vsize * sizeof(GLubyte)); 
        for (int v = 0; v < vsection; v++) {
            float r = radius * sinf(PI * v / (vsection - 1));
            for (int h = 0 ; h < hsection; h++) {
                int index = (v * hsection + h);
                vertex[index].x = r * sinf(2 * PI * h / (hsection - 1));
                vertex[index].y = r * cosf(2 * PI * h / (hsection - 1));
                vertex[index].z = radius * cosf(PI * v / (vsection - 1));
              
//                CGColorRef cgc = [UIColor randomColor].CGColor;
//                const float * rgb = CGColorGetComponents(cgc);
//                color[index].red =  rgb[0];
//                color[index].green = rgb[1];
//                color[index].blue = rgb[2];
//                color[index].alpha = rgb[3];
             
                texCoor[2 * index + 1] = (float)v / (vsection- 1);
                texCoor[2 * index + 0] = 1 - (float)h / (hsection - 1);
                //                
//                float mod=sqrtf(vertex[3 * index]*vertex[3 * index]+
//                                vertex[3 * index+1]*vertex[3 * index+1]+ 
//                                0);
//                normal[3 * index    ] = vertex[3 * index    ] / mod;
//                normal[3 * index + 1] = vertex[3 * index + 1] / mod;
//                normal[3 * index + 2] = 0;
//                
                if (v != vsection - 1 && h != hsection - 1) {
                    indices[index * 6  ] = v * hsection + h;
                    indices[index * 6+1] = (v + 1) * hsection + h;
                    indices[index * 6+2] = v * hsection + h + 1;
                    
                    indices[index * 6+3] = (v + 1) * hsection + h ;
                    indices[index * 6+4] = ((v + 1) * hsection + h) + 1;
                    indices[index * 6+5] = (v * hsection + h) + 1;
                }
            }
        }
        TextureLoader * tl = [TextureLoader shareTextureLoader];
        CGImageRef tile = [UIImage imageNamed:@"earth.png"].CGImage;
        [tl loadTextureWith:tile Index:5];
        textures = tl.textures;
        
    }

    return self;
}
-(void)draw{
    glColor4f(1, 1, 1,1);
    glEnable(GL_TEXTURE_2D);
    
//    glEnableClientState(GL_COLOR_ARRAY);
//    glColorPointer(4, GL_FLOAT, 0, color);
//    glTranslatef(0, 0, 1);
    glBindTexture(GL_TEXTURE_2D, textures[5]);
    glTexCoordPointer(2, GL_FLOAT, 0, texCoor);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);

    glVertexPointer(3, GL_FLOAT, 0, vertex);
    glDrawElements(GL_TRIANGLES, vsize * 6, GL_UNSIGNED_BYTE, indices);
//    glDisableClientState(GL_COLOR_ARRAY);
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);

}
@end
