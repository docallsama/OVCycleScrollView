//
//  ViewController.m
//  OVCycleScrollView
//
//  Created by 谢艺欣 on 2017/10/23.
//  Copyright © 2017年 谢艺欣. All rights reserved.
//

#import "ViewController.h"
#import "OVCycleScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self addCycleScrollView];
}

- (void)addCycleScrollView {
    OVCycleScrollView *cycleScrollView = [[OVCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    cycleScrollView.backgroundColor = [UIColor redColor];
    [cycleScrollView configCycleScrollView];
    [self.view addSubview:cycleScrollView];
    
    [cycleScrollView reloadScrollViewData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
