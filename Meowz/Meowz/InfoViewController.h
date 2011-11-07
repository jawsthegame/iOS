//
//  InfoViewController.h
//  Meowz
//
//  Created by Thomas Fleischer on 11/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol InfoViewDelegate;

@interface InfoViewController : UIViewController <AVAudioPlayerDelegate> {
    id<InfoViewDelegate> delegate;
}

@property (nonatomic, assign) id<InfoViewDelegate> delegate;

-(IBAction)hide;

@end


@protocol InfoViewDelegate

-(IBAction)hideInfo;

@end
