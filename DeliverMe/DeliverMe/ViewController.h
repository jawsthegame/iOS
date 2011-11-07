//
//  ViewController.h
//  DeliverMe
//
//  Created by Thomas Fleischer on 11/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tableView;
    NSMutableArray *items;
}

-(IBAction)add;
-(IBAction)edit;

@end
