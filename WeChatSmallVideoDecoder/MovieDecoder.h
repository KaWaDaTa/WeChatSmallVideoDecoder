//
//  MovieDecoder.h
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class MovieDecoder;
@protocol MovieDecoderDelegate <NSObject>

- (void)movieDecoder:(MovieDecoder *)decoder onNewVideoFrameReady:(CMSampleBufferRef)buffer;
- (void)movieDecoderOnDecoderFinished:(MovieDecoder *)decoder;

@end

@interface MovieDecoder : NSObject

@property (nonatomic, weak) id<MovieDecoderDelegate> delegate;

- (void)transformVideoPathToSampBufferRef:(NSString *)videoPath;

@end
