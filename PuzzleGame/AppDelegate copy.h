//
//  AppDelegate.h
//  PuzzleGame
//
//  Created by IPHONE-17  on 2/12/14.
//  Copyright (c) 2014 IPHONE-17 . All rights reserved.
//

#import <UIKit/UIKit.h>

@class GridViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) GridViewController *gridViewController;
@property (readwrite) BOOL isEdge;
@end
