//
//  ViewController.m
//  HDIJKMediaSDKDemo
//
//  Created by Harry on 16/10/17.
//  Copyright © 2016年 HarryDeng. All rights reserved.
//

#import "ViewController.h"

#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //rtmp://live.hkstv.hk.lxdns.com:1935/live/hks (流媒体数据)
    //rtmp://10.0.44.72:1935/denglibinglive/room (本地局域网的服务地址)
    //rtmp://115.28.135.68:1935/yuzhouheike/room (别人搭建好的云主机服务地址)
    _moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:@"rtmp://115.28.135.68:1935/yuzhouheike/room" withOptions:nil];
    _moviePlayer.view.frame = self.view.bounds;
    // 填充fill
    _moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    _moviePlayer.shouldAutoplay = NO;
    [self.view insertSubview:_moviePlayer.view atIndex:0];
    [_moviePlayer prepareToPlay];
    
    // 设置监听
    [self initObserver];
}


- (void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)stateDidChange{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
