//
//  OVCycleScrollView.h
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OVCycleScrollViewDelegate <NSObject>

- (void)onClickItemAtIndex:(int)index;

- (void)onScrollAtIndex:(int)index;

@end

@interface OVCycleScrollView : UIView

@property (nonatomic, retain) NSArray *localImageNameArray;

@property (nonatomic, weak) id<OVCycleScrollViewDelegate> cycleDelegate;

+ (instancetype)setCycleScrollViewWithFrame:(CGRect)frame andLocalImageArray:(NSArray *)images;

- (void)reloadScrollViewData;

@end
