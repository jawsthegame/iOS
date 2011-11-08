//
//  TodoDatabase.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Todo.h"

@interface TodoDatabase : NSObject

+(void)makeWritableDatabase;

-(NSString *)dbPath;
-(NSArray *)fetchTodos;
-(void)updateTodo:(Todo *)todo;
-(void)insertTodo:(Todo *)todo;
-(void)deleteTodo:(int)todoId;

@end
