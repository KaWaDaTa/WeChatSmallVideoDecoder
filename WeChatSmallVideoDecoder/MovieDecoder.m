//
//  MovieDecoder.m
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//

#import "MovieDecoder.h"

@implementation MovieDecoder

- (void)transformVideoPathToSampBufferRef:(NSString *)videoPath
{
    NSURL *fileUrl = [NSURL fileURLWithPath:videoPath];
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:fileUrl options:nil];
    NSError *error = nil;
    AVAssetReader *reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
    NSArray *videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    AVAssetTrack *videoTrack = videoTracks[0];
    AVAssetReaderTrackOutput *videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:@{(id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA)}];
    [reader addOutput:videoReaderOutput];
    [reader startReading];
    while ([reader status] == AVAssetReaderStatusReading && videoTrack.nominalFrameRate > 0) {
        NSLog(@"reading");
        CMSampleBufferRef videoBuffer = [videoReaderOutput copyNextSampleBuffer];
        if (self.delegate && [self.delegate respondsToSelector:@selector(movieDecoder:onNewVideoFrameReady:)]) {
            [self.delegate movieDecoder:self onNewVideoFrameReady:videoBuffer];
        }
        [NSThread sleepForTimeInterval:0.001];
    }
    NSLog(@"finish");
    if (self.delegate && [self.delegate respondsToSelector:@selector(movieDecoderOnDecoderFinished:)]) {
        [self.delegate movieDecoderOnDecoderFinished:self];
    }
}

@end
