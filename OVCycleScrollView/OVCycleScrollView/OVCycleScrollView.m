//
//  OVCycleScrollView.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "OVCycleScrollView.h"

@interface OVCycleScrollView () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    UICollectionView *mainCollectionView;
    int fullArrayCount;
    NSArray *imageNameArray;
}

@end

@implementation OVCycleScrollView

- (void)configCycleScrollView {
    imageNameArray = @[@"demo_1.jpg",@"demo_2.jpg",@"demo_3.jpg"];
    fullArrayCount = (int)imageNameArray.count * 100;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = self.frame.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    mainCollectionView.pagingEnabled = true;
    mainCollectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:mainCollectionView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (fullArrayCount > 0) {
        [mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:fullArrayCount / 2  inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    }
}

- (void)reloadScrollViewData {
    [mainCollectionView reloadData];
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return fullArrayCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [cell.contentView addSubview:imageView];
    
    int index = [self pageControlIndexWithCurrentCellIndex:indexPath.row];
    
    imageView.image = [UIImage imageNamed:imageNameArray[index]];
    
    return cell;
}

- (int)pageControlIndexWithCurrentCellIndex:(NSInteger)index
{
    return (int)index % imageNameArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.frame.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"on click -> %d",[self pageControlIndexWithCurrentCellIndex:indexPath.row]);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int rawIndex = scrollView.contentOffset.x / self.frame.size.width;
    NSLog(@"on scroll -> %d",[self pageControlIndexWithCurrentCellIndex:rawIndex]);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    int rawIndex = scrollView.contentOffset.x / self.frame.size.width;
    NSLog(@"on scroll -> %d",[self pageControlIndexWithCurrentCellIndex:rawIndex]);
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
