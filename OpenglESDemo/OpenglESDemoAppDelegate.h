//
//  OpenglESDemoAppDelegate.h
//  OpenglESDemo
//
//  Created by Nullin on 11-7-30.
//  Copyright 2011年 Innovation Workshop. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OpenglESDemoViewController;

@interface OpenglESDemoAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet OpenglESDemoViewController *viewController;

@end
