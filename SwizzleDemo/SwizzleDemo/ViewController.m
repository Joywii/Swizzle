//
//  ViewController.m
//  SwizzleDemo
//
//  Created by joywii on 14-9-5.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"1", @"2",nil];
    
    NSString *string = [array objectAtIndex:2];
    if (string)
    {
        NSLog(@"%@",string);
    }
    else
    {
        NSLog(@"string is nil");
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:array];
    [mutableArray addObject:@"3"];
    NSString *mString = [mutableArray objectAtIndex:3];
    if (mString)
    {
        NSLog(@"%@",mString);
    }
    else
    {
        NSLog(@"mString is nil");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
