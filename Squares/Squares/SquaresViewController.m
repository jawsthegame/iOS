//
//  SquaresViewController.m
//  Squares
//
//  Created by Thomas Fleischer on 11/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SquaresViewController.h"

@implementation SquaresViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:.3 green:.6 blue:.9 alpha:1.0];
    squares = [[NSMutableArray alloc] init];
}

-(int)randomIntBetween:(int)min and:(int)max {
    return (random() % (max - min)) + min;
}

- (CGRect)randomRect {
    int x = [self randomIntBetween:0 and:260];
    int y = [self randomIntBetween:0 and:370];
    int w = [self randomIntBetween:20 and:60];
    int h = [self randomIntBetween:20 and:60];
    
    CGRect rect = CGRectMake(x, y, w, h);
    return rect;
}

-(UIColor *)randomColor {
    float r = [self randomIntBetween:0 and:255] / 255.0;
    float g = [self randomIntBetween:0 and:255] / 255.0;
    float b = [self randomIntBetween:0 and:255] / 255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:.8];
}

-(IBAction)addTapped{
    NSLog(@"Add tapped...");

    UIView *sq = [[UIView alloc] initWithFrame:[self randomRect]];
    sq.backgroundColor = [self randomColor];
    
    [squares addObject:sq];
    [self.view addSubview:sq];
    
    [sq release];
}

-(IBAction)randomizeTapped{
    NSLog(@"Randomize tapped...");
    
    [UIView beginAnimations:@"randomize" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    for(UIView *sq in squares) {
        sq.frame = [self randomRect];
        sq.backgroundColor = [self randomColor];
        sq.transform = CGAffineTransformMakeRotation([self randomIntBetween:0 and:180]);
    }
    
    [UIView commitAnimations];
}

-(IBAction)deleteTapped{
    NSLog(@"Delete tapped...");
    
    if(squares.count > 0) {    
        UIView *sq = [squares objectAtIndex:0];
        [squares removeObjectAtIndex:0];
        
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView beginAnimations:@"removal" context:sq];
        [UIView setAnimationDuration:1];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        
        CGRect offScreenRect = sq.frame;
        offScreenRect.origin.y = 481;
        sq.frame = offScreenRect;
        sq.alpha = .05;        
        
        sq.transform = CGAffineTransformMakeRotation(80);
        
        [UIView commitAnimations];
    }
}

-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    if([animationID isEqualToString:@"removal"]) {
        UIView *sq = (UIView *) context;
        [sq removeFromSuperview];
        [sq release];
    }
}

-(void)dealloc {
    [squares dealloc];
    
    [super dealloc];
}

@end
