//
//  SquaresViewController.h
//  Squares
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SquaresViewController : UIViewController {
    NSMutableArray *squares;
}

-(IBAction)addTapped;
-(IBAction)randomizeTapped;
-(IBAction)deleteTapped;

@end
