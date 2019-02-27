//
//  WGLVolumeProgressView.m
//  WGLVolumeProgressView
//
//  Created by wugl on 2019/2/26.
//  Copyright © 2019年 WGLKit. All rights reserved.
//

#import "WGLVolumeProgressView.h"

NSString *const WGLSystemVolumeDidChangeNotification = @"WGLSystemVolumeDidChangeNotification";

@interface WGLVolumeProgressView ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *iconView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WGLVolumeProgressView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark - UI

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self addNotifications];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.iconView];
    [self.bgView addSubview:self.progressView];
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}

- (UIButton *)iconView {
    if (!_iconView) {
        _iconView = [[UIButton alloc] init];
        [_iconView setImage:[UIImage imageNamed:@"icon_player_volume_open"] forState:UIControlStateNormal];
        [_iconView setImage:[UIImage imageNamed:@"icon_player_volume_close"] forState:UIControlStateHighlighted];
        [_iconView setImage:[UIImage imageNamed:@"icon_player_volume_close"] forState:UIControlStateSelected];
    }
    return _iconView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.trackTintColor = [UIColor grayColor];
        _progressView.progressTintColor = [UIColor whiteColor];
        [_progressView setProgress:0];
    }
    return _progressView;
}

#pragma mark - layout

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(20, self.center.y - self.iconView.frame.size.height / 2, self.iconView.frame.size.width, self.iconView.frame.size.height);
    
    self.progressView.frame = CGRectMake(14, 0, self.frame.size.width - 14 * 2, self.frame.size.height);
}

#pragma mark - 音量变化通知

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(n_volumeChange:) name:WGLSystemVolumeDidChangeNotification object:nil];
}

- (void)n_volumeChange:(NSNotification *)noti {
    NSNumber *obj = noti.object;
    if (obj && [obj isKindOfClass:[NSNumber class]]) {
        CGFloat value = obj.floatValue;
        [self setVolumeValue:value animated:YES];
    }
}

#pragma mark -

- (void)setVolumeValue:(CGFloat)volumeValue {
    _volumeValue = volumeValue;
    [self setVolumeValue:volumeValue animated:NO];
}

- (void)setVolumeValue:(CGFloat)volumeValue animated:(BOOL)animated {
    self.hidden = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideCoverView) object:nil];
    [self performSelector:@selector(hideCoverView) withObject:nil afterDelay:1.0];
    [self.progressView setProgress:volumeValue animated:animated];
    self.iconView.selected = volumeValue < 0.02;
}

- (void)hideCoverView {
    self.hidden = YES;
}

@end
