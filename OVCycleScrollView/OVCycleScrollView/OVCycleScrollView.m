//
//  OVCycleScrollView.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "OVCycleScrollView.h"
#import "OVCycleCollectionViewCell.h"
#import <UIImageView+WebCache.h>

static int reapeatCount = 100;

@interface OVCycleScrollView () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *mainCollectionView;
    int fullArrayCount;
    NSArray *imagePathsArray;
    NSTimer *timer;
}

@end

@implementation OVCycleScrollView

- (void)setLocalImageNameArray:(NSArray *)localImageNameArray {
    _localImageNameArray = localImageNameArray;
    imagePathsArray = [localImageNameArray copy];
    if (mainCollectionView) {
        [self reloadScrollViewData];
    }
}

- (void)setRemoteImageURLArray:(NSArray *)remoteImageURLArray {
    _remoteImageURLArray = remoteImageURLArray;
    imagePathsArray = [remoteImageURLArray copy];
    
    if (mainCollectionView) {
        [self reloadScrollViewData];
    }
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll {
    _isAutoScroll = isAutoScroll;
    if (isAutoScroll == true) {
        [self configTimer];
    }
}

- (NSTimeInterval)gapTime {
    if (_gapTime == 0) {
        return 1;
    }
    return _gapTime;
}

- (void)scrollToNext {
    CGFloat offset = mainCollectionView.contentOffset.x;
    offset += self.frame.size.width;
    [mainCollectionView setContentOffset:CGPointMake(offset, 0) animated:true];
}

+ (instancetype)setCycleScrollViewWithFrame:(CGRect)frame andLocalImageArray:(NSArray *)images {
    OVCycleScrollView *cycleScrollView = [[OVCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.localImageNameArray = images;
    [cycleScrollView configCycleScrollView];
    return cycleScrollView;
}

+ (instancetype)setCycleScrollViewWithFrame:(CGRect)frame andRemoteImageArray:(NSArray *)images {
    OVCycleScrollView *cycleScrollView = [[OVCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.remoteImageURLArray = images;
    [cycleScrollView configCycleScrollView];
    return cycleScrollView;
}

- (void)configCycleScrollView {
    fullArrayCount = (int)imagePathsArray.count * reapeatCount;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [mainCollectionView registerClass:[OVCycleCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    mainCollectionView.pagingEnabled = true;
    mainCollectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:mainCollectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (fullArrayCount > 0) {
        [mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:fullArrayCount / 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    }
}

- (void)reloadScrollViewData {
    [mainCollectionView reloadData];
}

- (void)configTimer {
    timer = [NSTimer timerWithTimeInterval:self.gapTime target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    [timer invalidate];
    timer = nil;
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return fullArrayCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OVCycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    int index = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
    NSString *imageString = imagePathsArray[index];
    if ([imageString hasPrefix:@"http"]) {
        [cell.displayImageView sd_setImageWithURL:[NSURL URLWithString:imageString] placeholderImage:nil];
    } else {
        cell.displayImageView.image = [UIImage imageNamed:imageString];
    }
    
    return cell;
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % imagePathsArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.frame.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    int index = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
    if ([self.cycleDelegate respondsToSelector:@selector(cycleScrollView:onClickItemAtIndex:)]) {
        [self.cycleDelegate cycleScrollView:self onClickItemAtIndex:index];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.isAutoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.isAutoScroll && !timer.isValid) {
        [self configTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int rawIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    int targetIndex = [self pageControlIndexWithCurrentCellIndex:rawIndex];
    if ([self.cycleDelegate respondsToSelector:@selector(cycleScrollView:onScrollAtIndex:)]) {
        [self.cycleDelegate cycleScrollView:self onScrollAtIndex:targetIndex];
    }
}

- (void)dealloc {
    [self invalidateTimer];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
