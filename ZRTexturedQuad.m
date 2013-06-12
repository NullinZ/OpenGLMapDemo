//
//  ZRTexturedQuad.m
//  SpaceRocks
//
//  Created by ben smith on 14/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ZRTexturedQuad.h"
#define meshSize 0.3
static Vertex3D BBTexturedQuadVertexes[8] = {-meshSize,-meshSize,0, meshSize,-meshSize,0, -meshSize,meshSize,0, meshSize,meshSize,0};
static Color3D BBTexturedQuadColorValues[16] = {1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0, 1.0,1.0,1.0,1.0};

@implementation ZRTexturedQuad

@synthesize uvCoordinates,materialKey;

- (id) init
{
	self = [super initWithVertexes:BBTexturedQuadVertexes vertexCount:4 renderStyle:GL_TRIANGLE_STRIP];
	if (self != nil) {
		// 4 vertexes
		uvCoordinates = (CGFloat *) malloc(8 * sizeof(CGFloat));
		colors = BBTexturedQuadColorValues;
		colorSize = 4;
	}
	return self;
}


// called once every frame
-(void)render
{
	glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorSize, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);	
	
	if (materialKey != nil) {
		[[ZRMaterialController sharedMaterialController] bindMaterial:materialKey];

		glEnableClientState(GL_TEXTURE_COORD_ARRAY); 
		glTexCoordPointer(2, GL_FLOAT, 0, uvCoordinates);

	} 
	//render
	glDrawArrays(renderStyle, 0, vertexCount);	
}



- (void) dealloc
{
	free(uvCoordinates);
	[super dealloc];
}

@end
