//
//  TekpubTodoAppDelegate.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TekpubTodoViewController;

@interface TekpubTodoAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TekpubTodoViewController *viewController;

@end
