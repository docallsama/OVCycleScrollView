# OVCycleScrollView
实现轮播控件 原理参考SDCycleScrollView

## 使用方式

1.加载本地图片

```objc
NSArray *localImageArray = @[@"demo_1.jpg",@"demo_2.jpg",@"demo_3.jpg"];
OVCycleScrollView *cycleScrollView = [OVCycleScrollView setCycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)
                                                                 andLocalImageArray:localImageArray];
cycleScrollView.isAutoScroll = true;
[cycleScrollView reloadScrollViewData];
[backScrollView addSubview:cycleScrollView];

```
2.加载远程图片

```objc
NSArray *remoteImageArray = @[@"https://avatars2.githubusercontent.com/u/17563998?s=460&v=4",
                              @"https://avatars1.githubusercontent.com/u/433320?s=460&v=4",
                              @"https://avatars2.githubusercontent.com/u/6493255?s=460&v=4"];
OVCycleScrollView *remoteCycleScrollView = [OVCycleScrollView setCycleScrollViewWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 200)
                                                                          andRemoteImageArray:remoteImageArray];
remoteCycleScrollView.gapTime = 2.5;  //设置轮播间隔
remoteCycleScrollView.isAutoScroll = true;  
[remoteCycleScrollView reloadScrollViewData];
remoteCycleScrollView.cycleDelegate = self;
[backScrollView addSubview:remoteCycleScrollView];
```

3.支持的回调方法

* 当前点击的index

```objc
- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onClickItemAtIndex:(int)index
```

* 当前滚动到的index

```objc
- (void)cycleScrollView:(OVCycleScrollView *)cycleScrollView onScrollAtIndex:(int)index
```
