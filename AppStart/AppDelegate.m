//
//  AppDelegate.m
//  AppStart
//
//  Created by 张豪 on 2018/4/25.
//  Copyright © 2018年 张豪. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHMoviePlayerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 这是图片还有视频的url链接
    NSString *getUrlStr = @"http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"; // 网络视频
    //    NSString *getUrlStr = @"http://fimg.yucuizhubao.com/img/start.png"; // 网络图片
    
    NSLog(@"后缀是--%@", [getUrlStr substringFromIndex:[getUrlStr length] - 4]);
    ZHMoviePlayerController *ZHVC = [[ZHMoviePlayerController alloc]init];
    
    if ([[getUrlStr substringFromIndex:[getUrlStr length] - 4] isEqualToString:@".mp4"] ) {
        NSLog(@"加载的是视频");
        //        [ZHVC setMoviePlayerInIndexWithURL:[NSURL URLWithString:getUrlStr] localMovieName:nil]; // 加载网络url视频
        [ZHVC setMoviePlayerInIndexWithURL:nil localMovieName:@"movie.mp4"]; // 加载本地视频
        self.window.rootViewController = ZHVC;
        
    }else if ([[getUrlStr substringFromIndex:[getUrlStr length] - 4] isEqualToString:@".png"]){
        NSLog(@"加载的是图片");
        //        [ZHVC setImageInIndexWithURL:[NSURL URLWithString:getUrlStr] localImageName:nil timeCount:4];// 加载网络图片
        [ZHVC setImageInIndexWithURL:nil localImageName:@"bj.png" timeCount:4]; // 加载本地图片
        self.window.rootViewController = ZHVC;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
