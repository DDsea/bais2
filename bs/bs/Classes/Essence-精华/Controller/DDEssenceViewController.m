//
//  DDEssenceViewController.m
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDEssenceViewController.h"
#import "DDRecommendTagsViewController.h"
#import "DDTopicViewController.h"
@interface DDEssenceViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIView *indicatorView;
@property (nonatomic, weak) UIButton *selectedButton;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation DDEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self  setupNav];
    
    [self  setupChildVces];
    [self  setupTitlesView];
    
    [self  setupContentView];
    
}


- (void)setupChildVces{

    DDTopicViewController *all = [[DDTopicViewController  alloc] init];
    all.title = @"全部";
    all.type = DDTopicTypeAll;
    [self    addChildViewController:all];
    
    DDTopicViewController *video = [[DDTopicViewController  alloc] init];
    video.title = @"视频";
    video.type = DDTopicTypeVideo;
    [self addChildViewController:video];
    
    DDTopicViewController *voice = [[DDTopicViewController  alloc] init];
    voice.title = @"声音";
    voice.type = DDTopicTypeVoice;
    [self  addChildViewController:voice];
    
    
    DDTopicViewController *picture = [[DDTopicViewController  alloc] init];
    picture.title = @"图片";
    picture.type = DDTopicTypePicture;
    [self  addChildViewController:picture];
    
    DDTopicViewController *word = [[DDTopicViewController  alloc] init];
    word.title = @"段子";
    word.type = DDTopicTypeWord;
    [self  addChildViewController:word];
    



}


- (void)setupTitlesView{

    UIView *titlesView = [[UIView alloc] init];
    
    titlesView.backgroundColor = [[UIColor   whiteColor]  colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    
    [self.view  addSubview:titlesView];
    
    self.titlesView = titlesView;
    
    
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor  redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    
    
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i= 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        
        button.x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button   setTitleColor:[UIColor  grayColor] forState:UIControlStateNormal];
        [button   setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont  systemFontOfSize:14];
        [button  addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [titlesView  addSubview:button];
        
        if (i==0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            [button.titleLabel  sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX= button.centerX;
        }
        
        
    }
    
    [titlesView  addSubview:indicatorView];

}


- (void)titleClick:(UIButton *)button{
    self.selectedButton.enabled = YES;
    
    button.enabled = NO;
    
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView  setContentOffset:offset animated:YES];


}

- (void)setupContentView{

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view   insertSubview:contentView atIndex:0];
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;


    [self   scrollViewDidEndScrollingAnimation:contentView];




}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    
    UITableViewController *vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    
    [scrollView  addSubview:vc.view];



}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{


    [self  scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self  titleClick:self.titlesView.subviews[index]];



}





- (void)setupNav{

    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem  itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = XMGGlobalBg;


}


- (void)tagClick{

    DDRecommendTagsViewController *tags = [[DDRecommendTagsViewController  alloc] init];
    
    [self.navigationController  pushViewController:tags animated:YES];


}





@end
