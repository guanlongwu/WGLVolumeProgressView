//
//  WGLVolumeProgressView.h
//  WGLVolumeProgressView
//
//  Created by wugl on 2019/2/26.
//  Copyright © 2019年 WGLKit. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const WGLSystemVolumeDidChangeNotification; //系统音量变化通知

@interface WGLVolumeProgressView : UIView

@property (nonatomic, assign) CGFloat volumeValue;

- (void)setVolumeValue:(CGFloat)volumeValue animated:(BOOL)animated;

@end
