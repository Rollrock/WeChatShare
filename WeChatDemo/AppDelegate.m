//
//  AppDelegate.m
//  WeChatDemo
//
//  Created by zhuang chaoxiao on 14-9-23.
//  Copyright (c) 2014年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [WXApi registerApp:@"wx8ae0a52d0b488e34"];
    
    return YES;
}


-(BOOL)application:(UIApplication*)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self];
}

-(BOOL)application:(UIApplication*)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self];
}


-(void) onReq:(BaseReq*)req
{
   if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        //NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%u bytes\n\n", msg.title, msg.description, obj.extInfo, msg.thumbData.length];
        
       // NSLog(@"strMsg:%@",strMsg);
      
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        NSLog(@"strMsg:%@",strMsg);
        
        
        if( resp.errCode == 0 )
        {
            //发送成功
        }
        else if( resp.errCode == -2 )
        {
            //主动取消 
        }
    }
}

-(void) shareWithTextUrl
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"专访张小龙：产品之上的世界观";
    message.description = @"微信的平台化发展方向是否真的会让这个原本简洁的产品变得臃肿？在国际化发展方向上，微信面临的问题真的是文化差异壁垒吗？腾讯高级副总裁、微信产品负责人张小龙给出了自己的回复。";
    [message setThumbImage:[UIImage imageNamed:@"res2.png"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://tech.qq.com/zt2012/tmtdecode/252.htm";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}

- (void)shareWithImage
{
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:[UIImage imageNamed:@"weixin_share"]];
    
    WXImageObject *ext = [WXImageObject object];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"weixin_share" ofType:@"png"];
    NSLog(@"filepath :%@",filePath);
    ext.imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImage* image = [UIImage imageWithData:ext.imageData];
    ext.imageData = UIImagePNGRepresentation(image);
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}




- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
