//
//  ViewController.m
//  WeChatDemo
//
//  Created by zhuang chaoxiao on 14-9-23.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)btnClicked:(id)sender
{
    AppDelegate * del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [del shareWithImage];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
