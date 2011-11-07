//
//  ViewController.h
//  Meowz
//
//  Created by Thomas Fleischer on 11/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "InfoViewController.h"

@interface ViewController : UIViewController <AVAudioPlayerDelegate, InfoViewDelegate>

-(IBAction)meow;

-(IBAction)showInfo;
-(IBAction)hideInfo;

@end
