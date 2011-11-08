//
//  TekpubTodoViewController.m
//  TekpubTodo
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TekpubTodoViewController.h"
#import "Todo.h"
#import "TodoEditorController.h"
#import "FMDBTodoDatabase.h"

@implementation TekpubTodoViewController

#pragma mark Initialization

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
    }
    
    return self;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    db = [[FMDBTodoDatabase alloc] init];
    todoItems = [[db fetchTodos] retain];
    tableView.allowsSelectionDuringEditing = YES;
}

- (void)presentTodoEditor:(NSString *)text  {
    TodoEditorController *editor = [[TodoEditorController alloc] initWithNibName:@"TodoEditorController" bundle:nil];
    editor.defaultText = text;
    editor.delegate = self;
    [self presentModalViewController:editor animated:YES];
    [editor release];
    
}

#pragma mark -
#pragma mark Event handlers

- (IBAction)add {
    lastEditingTodo = nil;
    [self presentTodoEditor: nil];
}

-(IBAction)edit {
    editing = !editing;
    [tableView setEditing:editing animated:YES];
}

-(void)todoEditor:(TodoEditorController *)editor didFinishWithResult:(BOOL)result {
    if(result) {
        NSString *text = [editor text];
        
        if (lastEditingTodo == nil) {            
            Todo *todo = [[Todo alloc] initWithText:text];
            [db insertTodo:todo];
            [todoItems release];
            todoItems = [[db fetchTodos] retain];
            [todo release];
        }
        else {
            lastEditingTodo.text = text;
            [db updateTodo:lastEditingTodo];
        }        
        
        [tableView reloadData];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableView datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [todoItems count];
}

- (UITableViewCell *)tableView:(UITableView *)sourceTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [sourceTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];        
    }
    
    Todo *todo = [todoItems objectAtIndex:indexPath.row];
    cell.textLabel.text = todo.text;
    
    if (todo.completed) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)sourceTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        Todo *todo = [todoItems objectAtIndex:indexPath.row];
        [db deleteTodo:todo.todoId];
        [todoItems release];
        todoItems = [[db fetchTodos] retain];
        [sourceTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
}

#pragma mark -
#pragma mark TableView delegate methods
- (void)tableView:(UITableView *)sourceTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Did select row...");
    
    Todo *todo = [todoItems objectAtIndex:indexPath.row];
    
    if(editing) {
        [self presentTodoEditor: todo.text];       
        lastEditingTodo = todo;
    }
    else {
        todo.completed = !todo.completed;
        [db updateTodo:todo];
        [sourceTableView reloadData];
    }
    
    [sourceTableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc{
    [todoItems release];
    
    [super dealloc];
}

@end
