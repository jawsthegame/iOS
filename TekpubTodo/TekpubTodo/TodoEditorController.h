//
//  TodoEditorController.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@protocol TodoEditorDelegate;

@interface TodoEditorController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
    id<TodoEditorDelegate> delegate;
    UITextField* textField;
    NSString *defaultText;
}

@property (nonatomic, assign) id<TodoEditorDelegate> delegate;
@property (nonatomic, readonly) NSString *text;
@property (nonatomic, copy) NSString *defaultText;

-(IBAction)cancel;
-(IBAction)save;

@end


@protocol TodoEditorDelegate

-(void)todoEditor:(TodoEditorController *)editor didFinishWithResult:(BOOL)result;

@end
