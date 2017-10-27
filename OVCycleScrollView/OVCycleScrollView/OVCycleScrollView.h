//
//  OVCycleScrollView.h
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OVCycleScrollView;

@protocol OVCycleScrollViewDelegate <NSObject>

@optional

- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onClickItemAtIndex:(int)index;

- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onScrollAtIndex:(int)index;

@end

@interface OVCycleScrollView : UIView

@property (nonatomic, assign) BOOL isAutoScroll;

@property (nonatomic, retain) NSArray *localImageNameArray;

@property (nonatomic, retain) NSArray *remoteImageURLArray;

@property (nonatomic, assign) NSTimeInterval gapTime;

@property (nonatomic, weak) id<OVCycleScrollViewDelegate> cycleDelegate;

+ (instancetype)setCycleScrollViewWithFrame:(CGRect)frame andLocalImageArray:(NSArray *)images;

+ (instancetype)setCycleScrollViewWithFrame:(CGRect)frame andRemoteImageArray:(NSArray *)images;

- (void)reloadScrollViewData;

@end
