//
//  FileHelper.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FileHelper.h"

NSString* PathForResource(NSString *filename) {
    NSString *leftPart = [filename stringByDeletingPathExtension];
    NSString *extension = [filename pathExtension];
    return [[NSBundle mainBundle] pathForResource:leftPart ofType:extension];
}

NSString* DocumentsDirectory() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}