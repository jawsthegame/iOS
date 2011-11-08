//
//  FMDBTodoDatabase.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TodoDatabase.h"
#import "FMDatabase.h"

@interface FMDBTodoDatabase : TodoDatabase {
    FMDatabase *db;
}

@end
