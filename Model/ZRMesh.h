//
//  BBMesh.h
//  SpaceRocks
//
//  Created by ben smith on 3/07/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>
#import "OpenGLCommon.h"
@interface ZRMesh : NSObject {
	// mesh data
	Vertex3D * vertexes;
	Color3D * colors;
	
	GLenum renderStyle;
	NSInteger vertexCount;
	NSInteger vertexSize;
	NSInteger colorSize;	
	
	Vertex3D centroid;
	CGFloat radius;
}

@property (assign) NSInteger vertexCount;
@property (assign) NSInteger vertexSize;
@property (assign) NSInteger colorSize;
@property (assign) GLenum renderStyle;

@property (assign) Vertex3D centroid;
@property (assign) CGFloat radius;

@property (assign) Vertex3D * vertexes;
@property (assign) Color3D      * colors;

- (id)initWithVertexes:(Vertex3D*)verts 
					 vertexCount:(NSInteger)vertCount 
					 renderStyle:(GLenum)style;

+(Rect3D)meshBounds:(ZRMesh*)mesh scale:(Vector3D)scale;

-(Vertex3D)calculateCentroid;
-(CGFloat)calculateRadius;
-(void)render;

@end
