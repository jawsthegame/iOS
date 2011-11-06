//
//  Todo.h
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Todo : NSObject {
    NSString *text;
    BOOL completed;
}

@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL completed;

-(id)initWithText:(NSString *)text;

@end
