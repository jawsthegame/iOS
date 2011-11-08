//
//  TekpubTodoViewController.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoEditorController.h"
#import "Todo.h"
#import "TodoDatabase.h"

@interface TekpubTodoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TodoEditorDelegate> {
    TodoDatabase *db;
    NSArray *todoItems;
    IBOutlet UITableView *tableView;
    BOOL editing;
    Todo *lastEditingTodo;
}

-(IBAction)add;
-(IBAction)edit;

@end
