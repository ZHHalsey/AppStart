//
//  ZHMoviePlayerController.m
//  AppStart
//
//  Created by 张豪 on 2018/4/25.
//  Copyright © 2018年 张豪. All rights reserved.
//
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width


#import "ZHMoviePlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "ViewController.h"

@interface ZHMoviePlayerController ()

// 播放器ViewController
@property (nonatomic, strong)AVPlayerViewController *AVPlayer;
@property (nonatomic, strong)UIButton *enterMainButton;
@property (nonatomic, assign) int timeCount;
@property (nonatomic, weak)NSTimer *timer;
@property (nonatomic, weak)NSTimer *timer1;


@end

@implementation ZHMoviePlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)setMoviePlayerInIndexWithURL:(NSURL *)movieURL localMovieName:(NSString *)localMovieName
{
    self.AVPlayer = [[AVPlayerViewController alloc]init];
    // 多分屏功能取消
    self.AVPlayer.allowsPictureInPicturePlayback = NO;
    // 是否显示媒体播放组件
    self.AVPlayer.showsPlaybackControls = false;
    AVPlayerItem *item;
    if (movieURL) {
        NSLog(@"传入了网络视频url过来");
        item = [[AVPlayerItem alloc]initWithURL:movieURL];
    }else if (localMovieName) {
        NSLog(@"加载的是本地的视频");
        NSString *path =  [[NSBundle mainBundle] pathForResource:@"movie.mp4" ofType:nil];
        NSLog(@"path---%@", path);
        item = [[AVPlayerItem alloc]initWithURL:[NSURL fileURLWithPath:path]];
    }
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    // layer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    [layer setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    // 填充模式
//    layer.videoGravity = AVLayerVideoGravityResizeAspect; // 保持视频的纵横比
    layer.videoGravity = AVLayerVideoGravityResize; // 不保持视频的纵横比, 填充整个屏幕
    self.AVPlayer.player = player;
    [self.view.layer addSublayer:layer];
    [self.AVPlayer.player play];
    
    // 重复播放。
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
//    [self createLoginBtn]; // 3秒后自动就停止(这里自行选择)
    [self createLoginBtn1]; // 不点的话 就一直播放视频
    
}

- (void)setImageInIndexWithURL:(NSURL *)imageURL localImageName:(NSString *)localImageName timeCount:(int)timeCount{
    
    _timeCount = timeCount;
    // http://fimg.yucuizhubao.com/img/start.png
    UIImageView *imagev1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (imageURL) {
        NSLog(@"加载的是网络上的图片");
        NSData *data = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image1 = [UIImage imageWithData:data];
        imagev1.image = image1;
        
    }
    if (localImageName) {
        NSLog(@"加载的是本地的图片");
        UIImage *image = [UIImage imageNamed:@"bj.png"];
        imagev1.image = image;
    }
    
    [self.view addSubview:imagev1];
    [self createLoginBtn];
}

// 播放完成代理
- (void)playDidEnd:(NSNotification *)Notification{
    // 播放完成后。设置播放进度为0 。 重新播放
    [self.AVPlayer.player seekToTime:CMTimeMake(0, 1)];
    [self.AVPlayer.player play];
}

// 用户不用点击, 几秒后自动进入程序
- (void)createLoginBtn
{
    NSLog(@"创建按钮");
    // 进入按钮
    _enterMainButton = [[UIButton alloc] init];
    _enterMainButton.frame = CGRectMake(SCREEN_WIDTH - 90, 50, 60, 30);
    _enterMainButton.backgroundColor = [UIColor grayColor];
    _enterMainButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _enterMainButton.layer.cornerRadius = 15;
    NSString *title = [NSString stringWithFormat:@"跳过 %d", _timeCount];
    [_enterMainButton setTitle:title forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(DaoJiShi) userInfo:nil repeats:YES];
    [self.view addSubview:_enterMainButton];
    [_enterMainButton addTarget:self action:@selector(enterMainAction) forControlEvents:UIControlEventTouchUpInside];
}
// 倒计时
- (void)DaoJiShi{
    if (_timeCount > 0) {
        _timeCount -= 1;
        NSString *title = [NSString stringWithFormat:@"跳过 %d", _timeCount];
        [_enterMainButton setTitle:title forState:UIControlStateNormal];
    }else{
        [_timer invalidate]; // 停止timer
        _timer = nil;
        [self enterMainAction];
    }
}

// 不会自动停止, 需要用户点击按钮才能进入应用
- (void)createLoginBtn1{ // 这里的时间是3秒后视频页面出现按钮
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(showClickBtn) userInfo:nil repeats:YES];
}
- (void)showClickBtn{
    NSLog(@"显示进入应用按钮");
    UIButton *btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(30, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 60, 40);
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 20;
    btn.alpha = 0.5;
    [btn setTitle:@"进入应用" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(enterMainAction) forControlEvents:UIControlEventTouchUpInside];
    [_timer1 invalidate];
    _timer1 = nil;// timer置为nil

}
// 按钮响应时间
- (void)enterMainAction{
    NSLog(@"点击了进入应用按钮");
    ViewController *vc = [[ViewController alloc]init];
    self.view.window.rootViewController = vc;
    [self.AVPlayer.player pause];
}
@end
