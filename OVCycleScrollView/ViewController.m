//
//  ViewController.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "ViewController.h"
#import "OVCycleScrollView.h"

@interface ViewController () <OVCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addCycleScrollView];
}

- (void)addCycleScrollView {
    NSArray *localImageArray = @[@"demo_1.jpg",@"demo_2.jpg",@"demo_3.jpg"];
    OVCycleScrollView *cycleScrollView = [OVCycleScrollView setCycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)
                                                                     andLocalImageArray:localImageArray];
    [self.view addSubview:cycleScrollView];
    
    [cycleScrollView reloadScrollViewData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cycleScrollView.localImageNameArray = @[@"demo_3.jpg",@"demo_2.jpg",@"demo_1.jpg"];
    });
    
    cycleScrollView.cycleDelegate = self;
}

#pragma mark - OVCycleScrollViewDelegate

- (void)onClickItemAtIndex:(int)index {
    NSLog(@"on click -> %d",index);
}

- (void)onScrollAtIndex:(int)index {
    NSLog(@"on scroll -> %d",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
