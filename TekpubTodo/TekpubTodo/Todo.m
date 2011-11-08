//
//  Todo.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Todo.h"

@implementation Todo

@synthesize text, completed, todoId;

-(id)initWithText:(NSString *)someText {
    if (self = [super init]) {
        self.text = someText;
    }
    return self;
}

@end
