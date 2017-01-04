//
//  UIImage+SampleBuffer.h
//  WeChatSmallVideoDecoder
//
//  Created by appteam on 2017/1/4.
//  Copyright © 2017年 colin.liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (SampleBuffer)
+ (CGImageRef)imageFromSampleBufferRef:(CMSampleBufferRef)sampleBufferRef;
@end
