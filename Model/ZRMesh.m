//
//  ZRMesh.m
//  OpenglESDemo
//
//  Created by &#36213; &#30427; on 11-8-23.
//  Copyright (c) 2011年 Innovation Workshop. All rights reserved.
//

#import "ZRMesh.h"

@implementation ZRMesh
@synthesize vertexCount,vertexSize,colorSize,renderStyle,vertexes,colors,centroid,radius;
- (id)initWithVertexes:(Vertex3D*)verts 
           vertexCount:(int)vertCount 
           renderStyle:(GLenum)style;
{
	self = [super init];
	if (self != nil) {
		self.vertexes = verts;
		self.vertexCount = vertCount;
		self.vertexSize = 3;//vertSize;
		self.renderStyle = style;
		self.centroid = [self calculateCentroid];
		self.radius = [self calculateRadius];
	}
	return self;
}

-(Vector3D)calculateCentroid
{
	CGFloat xTotal = 0;
	CGFloat yTotal = 0;
	CGFloat zTotal = 0;
	int index;
	// step through each vertex and add them all up
	for (index = 0; index < vertexCount; index++) {
		xTotal += vertexes[index].x;
		yTotal += vertexes[index].y;
		zTotal += vertexes[index].z;
	}
	// now average each total over the number of vertexes
	return Vector3DMake(xTotal/(CGFloat)vertexCount, yTotal/(CGFloat)vertexCount, zTotal/(CGFloat)vertexCount);
}

-(CGFloat)calculateRadius
{
	CGFloat rad = 0.0;
	int index;
	for (index = 0; index < vertexCount; index++) {
		Vector3D vert;
			vert = Vector3DMake(vertexes[index].x, vertexes[index].y, vertexes[index].z);		
		CGFloat thisRadius = distance(centroid, vert);
		if (rad < thisRadius) rad = thisRadius;
	}
	return rad;
}


// called once every frame
-(void)render
{
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisable(GL_TEXTURE_2D);
	// load arrays into the engine
	glVertexPointer(vertexSize, GL_FLOAT, 0, vertexes);
	glEnableClientState(GL_VERTEX_ARRAY);
	glColorPointer(colorSize, GL_FLOAT, 0, colors);	
	glEnableClientState(GL_COLOR_ARRAY);
	
	//render
	glDrawArrays(renderStyle, 0, vertexCount);	
}


+(Rect3D)meshBounds:(ZRMesh*)mesh scale:(Vector3D)scale
{
	if (mesh == nil) return Rect3DMake(0, 0, 0, 0, 0, 0);
	// need to run through my vertexes and find my extremes
	if (mesh.vertexCount < 2) return Rect3DMake(0, 0, 0, 0, 0, 0);
	CGFloat xMin,yMin,xMax,yMax,zMin,zMax;
	xMin = xMax = mesh.vertexes[0].x;
	yMin = yMax = mesh.vertexes[0].y;
    zMin = zMax = mesh.vertexes[0].z;
	int index;
	for (index = 0; index < mesh.vertexCount; index++) {
		if (xMin > mesh.vertexes[index].x * scale.x) xMin = mesh.vertexes[index].x * scale.x;
		if (xMax < mesh.vertexes[index].x * scale.x) xMax = mesh.vertexes[index].x * scale.x;
		if (yMin > mesh.vertexes[index].y * scale.y) yMin = mesh.vertexes[index].y * scale.y;
		if (yMax < mesh.vertexes[index].y * scale.y) yMax = mesh.vertexes[index].y * scale.y;
		if (zMin > mesh.vertexes[index].z * scale.z) yMax = mesh.vertexes[index].z * scale.z;
		if (zMax < mesh.vertexes[index].z * scale.z) yMax = mesh.vertexes[index].z * scale.z;
	}
	Rect3D meshBounds = Rect3DMake(xMin, yMin, zMin, xMax - xMin, yMax - yMin, zMax - zMin);
	if (meshBounds.size.x < 1.0) meshBounds.size.x = 1.0;
	if (meshBounds.size.y < 1.0) meshBounds.size.y = 1.0;
	if (meshBounds.size.z < 1.0) meshBounds.size.z = 1.0;
	return meshBounds;
}

- (void) dealloc
{
	[super dealloc];
}

@end
