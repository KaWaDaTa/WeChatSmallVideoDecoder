//
//  MoviePlayerView.m
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//

#import "MoviePlayerView.h"

@interface MoviePlayerView ()
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) MovieDecoder *decoder;
@end

@implementation MoviePlayerView

- (NSMutableArray *)images
{
    if (!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (MovieDecoder *)decoder
{
    if (!_decoder) {
        _decoder = [[MovieDecoder alloc] init];
        _decoder.delegate = self;
    }
    return _decoder;
}

- (void)setFilePath:(NSString *)filePath
{
    if (_filePath != filePath) {
        _filePath = filePath;
        [self.decoder transformVideoPathToSampBufferRef:_filePath];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.contentsGravity = kCAGravityResizeAspect;
    }
    return self;
}

- (void)movieDecoder:(MovieDecoder *)decoder onNewVideoFrameReady:(CMSampleBufferRef)buffer
{
    CGImageRef cgImage = [UIImage imageFromSampleBufferRef:buffer];
    if (!(__bridge id)cgImage) {
        return;
    }
    [self.images addObject:(__bridge id)cgImage];
    CGImageRelease(cgImage);
}

- (void)movieDecoderOnDecoderFinished:(MovieDecoder *)decoder
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.filePath] options:nil];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    animation.duration = asset.duration.value / asset.duration.timescale;
    animation.values = self.images;
    animation.repeatCount = 1;
    [self.layer addAnimation:animation forKey:nil];
    [self.images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj) {
            obj = nil;
        }
    }];
}

@end
