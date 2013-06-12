//
//  ZRObject.h
//  OpenglESDemo
//
//  Created by &#36213; &#30427; on 11-8-22.
//  Copyright (c) 2011年 Innovation Workshop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OpenGLCommon.h"
#import "ZRMesh.h"
@interface ZRObject : NSObject{
    Vector3D position;
    Rotation3D angles;
    Vector3D scale;

    BOOL active;
    
	ZRMesh * mesh;
	
	CGFloat * matrix;
	
	CGRect meshBounds;
	
	//BBCollider * collider;

}

@end
