//
//  FMDBTodoDatabase.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FMDBTodoDatabase.h"

@implementation FMDBTodoDatabase

-(id)init {
    if(self = [super init]) {
        db = [[FMDatabase alloc] initWithPath:[self dbPath]];
    }
    return self;
}

-(NSArray *)fetchTodos {
    [db open];
    
    NSMutableArray *todos = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"SELECT * FROM todos"];
    while ([rs next]) {
        Todo *todo = [[Todo alloc] init];
        todo.todoId = [rs intForColumn:@"id"];
        todo.text = [rs stringForColumn:@"text"];
        todo.completed = [rs boolForColumn:@"completed"];
        
        [todos addObject:todo];
        [todo release];
    }
    
    [rs close];
    [db close];
    
    return todos;
}

-(void)updateTodo:(Todo *)todo {
    [db open];
    
    [db executeUpdate:@"UPDATE todos SET text = ?, completed = ? WHERE id = ?", todo.text, [NSNumber numberWithBool:todo.completed], [NSNumber numberWithInt:todo.todoId]];
    
    [db close];
}

-(void)insertTodo:(Todo *)todo {
    [db open];
    
    [db executeUpdate:@"INSERT INTO todos (text, completed) VALUES (?, ?)", todo.text, [NSNumber numberWithBool:todo.completed]];
    
    [db close];
}

-(void)deleteTodo:(int)todoId {
    [db open];
    
    [db executeUpdate:@"DELETE FROM todos WHERE id = ?", [NSNumber numberWithInt:todoId]];
    
    [db close];
}

-(void)dealloc {
    [db release];
    
    [super dealloc];
}

@end
