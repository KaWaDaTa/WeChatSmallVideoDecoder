//
//  MoviePlayerView.h
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDecoder.h"
#import "UIImage+SampleBuffer.h"

@interface MoviePlayerView : UIView<MovieDecoderDelegate>
@property (nonatomic, copy) NSString *filePath;
@end
