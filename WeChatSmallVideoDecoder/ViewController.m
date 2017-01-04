//
//  ViewController.m
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//
//此方案为微信小视频方案，微信小视频大小在2M左右,微信小视频为下完再播;如果视频文件太大会爆内存
//参考链接//http://www.jianshu.com/p/3d5ccbde0de1
//参考公众号WeMobileDev,此公众号为微信移动客户端开发团队官号,里面历史消息有篇文章讲微信团队为什么选择这种方案

#import "ViewController.h"
#import "MoviePlayerView.h"

@interface ViewController ()
@property (nonatomic, strong) MoviePlayerView *playerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playerView = ({
        MoviePlayerView *view = [[MoviePlayerView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
        view.backgroundColor = [UIColor clearColor];
        [self.view addSubview:view];
        
        view;
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.playerView setFilePath:[[NSBundle mainBundle] pathForResource:@"" ofType:@""]];//设置本地文件链接，不能播放网络文件，因为微信方案为下完再播
}

@end
