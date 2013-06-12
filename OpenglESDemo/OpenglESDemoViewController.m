//
//  OpenglESDemoViewController.m
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "OpenglESDemoViewController.h"
#import "EAGLView.h"
// Uniform index.
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface OpenglESDemoViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
@end

@implementation OpenglESDemoViewController
@synthesize animating, context, displayLink;

bool preveiw = false,changing = false;
float a = 0.f;

- (void)awakeFromNib
{
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (!aContext) {
        aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    }
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
   
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
   
//    materialController  = [ZRMaterialController sharedMaterialController];
//    padMargin = (ZRTexturedQuad*)[materialController quadFromAtlasKey:@"padCenter"];
//    padMarginActive = (ZRTexturedQuad*)[materialController quadFromAtlasKey:@"padCenterActive"];
    TextureLoader *tl =[TextureLoader shareTextureLoader];
    textures = [tl textures];
    glGenTextures(10, &textures[0]);
    rocker = [[IOSRocker alloc] init];
    sphere = [[Sphere alloc] init];
    wall = [[Wall alloc] init];
    map = [[Map alloc] init];
//    cylinder = [[Cylinder alloc] init];
}

- (void)dealloc
{
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1) {
        animationFrameInterval = frameInterval;
        
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating) {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}
GLfloat testPosition1[]= { -.0f, 0.7f, -4.0f, 1.0f };	// 光源位置


- (void)initLight{
    GLfloat LightDiffuse1[]= { 1.0f, 0.0f, 0.0f, 1.0f };	// 漫射光参数
//    GLfloat LightDirection[]= { -5.0f, .0f, -1.0f, 1.0f };	// 漫射光参数
    GLfloat LightPosition1[]= { -3.0f, -3.0f, 0.0f, 1.0f };	// 光源位置
    
    GLfloat LightDiffuse2[]= { 0.0f, 0.0f, 1.0f, 0.0f };	// 漫射光参数
    GLfloat LightPosition2[]= { 3.0f, -3.0f, 0.0f, 1.0f };	// 光源位置
    
    GLfloat LightDiffuse3[]= { 0.0f, 1.0f, 0.0f, 1.0f };	// 漫射光参数
    GLfloat LightPosition3[]= { 0.0f, 3.0f, 0.0f, 1.0f };	// 光源位置
   
    glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse1);	// 设置漫射光
    glLightfv(GL_LIGHT1, GL_POSITION,LightPosition1);	// 设置光源位置
    //glLightfv(GL_LIGHT1, GL_SPOT_DIRECTION, LightDirection);
    glEnable(GL_LIGHT1);
    glLightfv(GL_LIGHT2, GL_DIFFUSE, LightDiffuse2);	// 设置漫射光
    glLightfv(GL_LIGHT2, GL_POSITION,LightPosition2);	// 设置光源位置
    glEnable(GL_LIGHT2);
    glLightfv(GL_LIGHT3, GL_DIFFUSE, LightDiffuse3);	// 设置漫射光
    glLightfv(GL_LIGHT3, GL_POSITION,LightPosition3);	// 设置光源位置
    glEnable(GL_LIGHT3);
    glEnable(GL_LIGHTING);

}
int trt =-1;
- (void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];
    
    // Replace the implementation of this method to do your own custom drawing.
    glPointSize(5);
//    [self initLight];
    glClearColor(0, 0, 0, 1.0f);
    if (!preveiw) {
        glFogf(GL_FOG_START, 3.0f);
        glFogf(GL_FOG_END, 10.0f);
        glFogx(GL_FOG_MODE, GL_LINEAR);
        glEnable(GL_FOG);
    
    }else{
        glDisable(GL_FOG);
    }
    glDepthFunc(GL_LEQUAL);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_FASTEST);
    glMatrixMode(GL_MODELVIEW);
    glLoadIdentity();
    glEnableClientState(GL_VERTEX_ARRAY);

    glPushMatrix();
    glTranslatef(0, 0, -1.1);
    if (preveiw) {
        if (changing) {
            if (a<90) {
                a+=2;
            }else{
                changing = false;
            }
        }
        glTranslatef(-a/15, -a/21, -a/9);
        glScalef(1-a/120,1-a/120,1-a/120);
        glRotatef(a, 1, 0, 0);
        [rocker transfer];
    }else{
        a = 0;
        AirRoam(trt);
    }
    [map drawSelf];
//      [cylinder draw];
        [sphere draw];
    glPopMatrix();
    [wall draw];
    
    glDisableClientState(GL_VERTEX_ARRAY);
    [(EAGLView *)self.view presentFramebuffer];
}
-(void)stopAnim{
    trt = -1;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (preveiw) {
        [rocker doEvent:touches view:self.view eventType:EVENT_TYPE_BEGIN];
    }

    
    CGRect leftBtn = CGRectMake(0, 668, 200, 100);
    CGRect rightBtn = CGRectMake(824, 668, 200, 100);
    CGRect nextBtn = CGRectMake(0, 0, 200, 100);
    CGRect preBtn = CGRectMake(824, 0, 200, 100);
    CGRect upBtn = CGRectMake(0, 468, 100, 200);
    CGRect downBtn = CGRectMake(100, 468, 100, 200);
    CGRect frontBtn = CGRectMake(924, 468, 100, 200);
    CGRect backBtn = CGRectMake(824, 468, 100, 200);
    CGPoint location = [[touches anyObject] locationInView:self.view];
    if (CGRectContainsPoint(leftBtn, location)) {
        trt = CAM_LEFT;
    }else if(CGRectContainsPoint(rightBtn, location)){
        trt = CAM_RIGHT;
    }else if(CGRectContainsPoint(upBtn, location)){
        trt = CAM_UP;
    }else if(CGRectContainsPoint(downBtn, location)){
        trt = CAM_DOWN;
    }else if(CGRectContainsPoint(frontBtn, location)){
        trt = CAM_FORWARD;
    }else if(CGRectContainsPoint(backBtn, location)){
        trt = CAM_BACKWARD;
    }else if(CGRectContainsPoint(nextBtn, location)){
        [map nextMap];
    }else if(CGRectContainsPoint(preBtn, location)){
        [map previousMap];
    }else{
        if ([[touches anyObject] tapCount] == 4) {
            preveiw = !preveiw;
            
            if(preveiw)changing = true;
            return;
        }
    }
    if (preveiw) {
        trt = -1;
    }
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [rocker doEvent:touches view:self.view eventType:EVENT_TYPE_MOVE];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    trt = -1;
    [rocker doEvent:touches view:self.view eventType:EVENT_TYPE_END];

}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

@end
