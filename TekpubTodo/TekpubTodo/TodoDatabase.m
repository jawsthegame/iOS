//
//  TodoDatabase.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoDatabase.h"
#import "FileHelper.h"
#import <sqlite3.h>
#import "Todo.h"

const NSString *DATABASE_FILENAME = @"todo.db";

@implementation TodoDatabase

+(NSString *)dbPath {
    return [DocumentsDirectory() stringByAppendingPathComponent:(NSString *)DATABASE_FILENAME];
}

+(void)makeWritableDatabase {
    NSString *targetPath = [self dbPath];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if ([fileMgr fileExistsAtPath:targetPath]) {
        NSLog(@"File already exists in the documents direcotry.");
        return;
    }
    
    NSString *sourcePath = PathForResource((NSString *)DATABASE_FILENAME);
    [fileMgr copyItemAtPath:sourcePath toPath:targetPath error:nil];
    
    NSLog(@"Copied %@ from bundle path to documents directory.", DATABASE_FILENAME);
}

-(NSString *)dbPath {
    return [DocumentsDirectory() stringByAppendingPathComponent:(NSString *)DATABASE_FILENAME];
}

-(sqlite3 *)getDb {
    sqlite3 *db;
    int status = sqlite3_open([[self dbPath] UTF8String], &db);
    if (status != SQLITE_OK) {
        NSLog(@"Error opening database: %s", sqlite3_errmsg(db));
        exit(1);
    }
    return db;
}

-(sqlite3_stmt *)getStatement:(char *)statement withDb:(sqlite3 *)db {
    sqlite3_stmt *stmt;
    int status = sqlite3_prepare_v2(db, statement, -1, &stmt, NULL);    
    if (status != SQLITE_OK) {
        NSLog(@"Error preparing statement: %s", sqlite3_errmsg(db));
        exit(1);
    }
    
    return stmt;
}

-(int)runSimpleStatement:(sqlite3_stmt *)stmt withDb:(sqlite3 *)db {
    int result = sqlite3_step(stmt);
    if (result != SQLITE_DONE) {
        NSLog(@"An error occurred while executing the statement! %s", sqlite3_errmsg(db));
        exit(1);
    }
    
    return result;
}

-(int)lastInsertedIdForDb:(sqlite3 *)db {
    sqlite3_stmt *stmt = [self getStatement:"SELECT last_insert_rowid();" withDb:db];
    sqlite3_step(stmt);
    int rowId = sqlite3_column_int(stmt, 0);
    sqlite3_finalize(stmt);
    
    return rowId;
}

-(NSArray *)fetchTodos {
    sqlite3 *db = [self getDb];
    
    sqlite3_stmt *stmt = [self getStatement:"SELECT id, text, completed FROM todos;" withDb:db];
    
    NSMutableArray *todos = [[NSMutableArray alloc] init];
    
    while (sqlite3_step(stmt) == SQLITE_ROW) {
        Todo *todo = [[Todo alloc] init];
        todo.todoId = sqlite3_column_int(stmt, 0);
        todo.text = [NSString stringWithFormat:@"%s", sqlite3_column_text(stmt, 1)];
        todo.completed = [[NSNumber numberWithInt:sqlite3_column_int(stmt, 2)] boolValue];
        [todos addObject:todo];
        [todo release];
    }
    
    sqlite3_finalize(stmt);    
    sqlite3_close(db);
    
    return [todos autorelease];
}

-(void)updateTodo:(Todo *)todo {
    sqlite3 *db = [self getDb];
    
    sqlite3_stmt *stmt = [self getStatement:"UPDATE todos SET text = ?, completed = ? WHERE id = ?" withDb:db];
    sqlite3_bind_text(stmt, 1, [todo.text UTF8String], -1, SQLITE_TRANSIENT);
    sqlite3_bind_int(stmt, 2, todo.completed);
    sqlite3_bind_int(stmt, 3, todo.todoId);
    
    [self runSimpleStatement:stmt withDb:db];
    
    sqlite3_finalize(stmt);   
    sqlite3_close(db);
}

-(void)insertTodo:(Todo *)todo {
    sqlite3 *db = [self getDb];
    
    sqlite3_stmt *stmt = [self getStatement:"INSERT INTO todos (text, completed) VALUES (?, 0);" withDb:db];
    sqlite3_bind_text(stmt, 1, [todo.text UTF8String], -1, SQLITE_TRANSIENT);
    
    [self runSimpleStatement:stmt withDb:db];
    todo.todoId = [self lastInsertedIdForDb:db];
    
    sqlite3_finalize(stmt);   
    sqlite3_close(db);
}

-(void)deleteTodo:(int)todoId {
    sqlite3 *db = [self getDb];
    
    sqlite3_stmt *stmt = [self getStatement:"DELETE FROM todos WHERE id = ?" withDb:db];
    sqlite3_bind_int(stmt, 1, todoId);
    
    [self runSimpleStatement:stmt withDb:db];
    
    sqlite3_finalize(stmt);   
    sqlite3_close(db);
}

@end
