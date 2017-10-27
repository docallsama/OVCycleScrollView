//
//  ViewController.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "ViewController.h"
#import "OVCycleScrollView.h"

@interface ViewController () <OVCycleScrollViewDelegate> {
    UIScrollView *backScrollView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    backScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    backScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    [self.view addSubview:backScrollView];
    
    [self addCycleScrollView];
}

- (void)addCycleScrollView {
    //加载本地图片
    NSArray *localImageArray = @[@"demo_1.jpg",@"demo_2.jpg",@"demo_3.jpg"];
    OVCycleScrollView *cycleScrollView = [OVCycleScrollView setCycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)
                                                                     andLocalImageArray:localImageArray];
    cycleScrollView.isAutoScroll = true;
    
    [cycleScrollView reloadScrollViewData];
    
    [backScrollView addSubview:cycleScrollView];
    
    
    //加载远程图片
    NSArray *remoteImageArray = @[@"https://avatars2.githubusercontent.com/u/17563998?s=460&v=4",
                                  @"https://avatars1.githubusercontent.com/u/433320?s=460&v=4",
                                  @"https://avatars2.githubusercontent.com/u/6493255?s=460&v=4"];
    OVCycleScrollView *remoteCycleScrollView = [OVCycleScrollView setCycleScrollViewWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 200)
                                                                          andRemoteImageArray:remoteImageArray];
    remoteCycleScrollView.gapTime = 2.5;
    remoteCycleScrollView.isAutoScroll = true;
    [remoteCycleScrollView reloadScrollViewData];
    
    //延迟加载
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        remoteCycleScrollView.remoteImageURLArray = @[@"https://avatars2.githubusercontent.com/u/6493255?s=460&v=4",
                                                      @"https://avatars1.githubusercontent.com/u/433320?s=460&v=4",
                                                      @"https://avatars2.githubusercontent.com/u/17563998?s=460&v=4"];
    });
    
    remoteCycleScrollView.cycleDelegate = self;
    
    [backScrollView addSubview:remoteCycleScrollView];
}

#pragma mark - OVCycleScrollViewDelegate

- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onClickItemAtIndex:(int)index {
    NSLog(@"on click -> %d",index);
}

- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onScrollAtIndex:(int)index {
    NSLog(@"on scroll -> %d",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
