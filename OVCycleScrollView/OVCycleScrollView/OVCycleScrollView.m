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
}

@end

@implementation OVCycleScrollView

- (void)configCycleScrollView {
    NSArray *imageNameArray = @[@"demo_1",@"demo_2",@"demo_3"];
    fullArrayCount = (int)imageNameArray.count * 100;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    mainCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    mainCollectionView.dataSource = self;
    mainCollectionView.delegate = self;
    mainCollectionView.pagingEnabled = true;
}

- (void)layoutSubviews {
    [super layoutSubviews];
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:collectionView.bounds];
    [cell.contentView addSubview:imageView];
    imageView.image= [UIImage imageNamed:[NSString stringWithFormat:@"demo_%d",indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
