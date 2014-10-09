//
//  AppDelegate.h
//  WeChatDemo
//
//  Created by zhuang chaoxiao on 14-9-23.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


-(void) shareWithImage;
-(void) shareWithTextUrl;
@end

