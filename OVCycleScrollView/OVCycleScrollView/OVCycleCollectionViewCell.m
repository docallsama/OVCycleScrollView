//
//  OVCycleCollectionViewCell.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/25.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "OVCycleCollectionViewCell.h"

@implementation OVCycleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configDisplayImateView];
    }
    return self;
}

- (void)configDisplayImateView {
    self.displayImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.displayImageView];
}

@end
