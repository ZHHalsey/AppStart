//
//  ZHMoviePlayerController.h
//  AppStart
//
//  Created by 张豪 on 2018/4/25.
//  Copyright © 2018年 张豪. All rights reserved.
//

#import "ViewController.h"

@interface ZHMoviePlayerController : ViewController

/**
 *  @param movieURL 网上url视频
 *  @param localMovieName 本地视频
 */
- (void)setMoviePlayerInIndexWithURL:(NSURL *)movieURL localMovieName:(NSString *)localMovieName;

/**
 *  @param imageURL 网上url图片
 *  @param localImageName 本地图片
 *  @param timeCount 倒计时时间
 */

- (void)setImageInIndexWithURL:(NSURL *)imageURL localImageName:(NSString *)localImageName timeCount:(int)timeCount;

@end
