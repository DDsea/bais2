//
//  DDRecommendViewController.m
//  bs
//
//  Created by dt on 16/3/4.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDRecommendViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "DDRecommendCategoryCell.h"
#import "MJExtension.h"
#import "DDRecommendCategory.h"
#import "DDRecommendUserCell.h"
#import "DDRecommendUser.h"
#import "MJRefresh.h"
#define DDSelectedCategory  self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface DDRecommendViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *categories;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic,strong) AFHTTPSessionManager *manager;
@end

@implementation DDRecommendViewController

static NSString * const DDCategoryId = @"category";
static NSString * const DDUserId = @"user";

- (AFHTTPSessionManager *)manager{

    if (!_manager) {
        _manager = [AFHTTPSessionManager  manager];
    }
    return _manager;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self  setupTableView];
    [self  setupRefresh];
    [self  loadCategories];
    
    
    
    
}


- (void)loadCategories{

    [SVProgressHUD  showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager     GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD  dismiss];
       // NSLog(@"===%@",responseObject);
        self.categories = [DDRecommendCategory    objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView   reloadData];
        
        [self.categoryTableView  selectRowAtIndexPath:[NSIndexPath  indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        [self.userTableView.header   beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD   showErrorWithStatus:@"加载推荐信息失败"];
    }];



}


- (void)setupTableView{


    [self.categoryTableView   registerNib:[UINib  nibWithNibName:NSStringFromClass([DDRecommendCategoryCell  class]) bundle:nil] forCellReuseIdentifier:DDCategoryId];
    
    [self.userTableView  registerNib:[UINib  nibWithNibName:NSStringFromClass([DDRecommendUserCell  class]) bundle:nil] forCellReuseIdentifier:DDUserId];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    
    
    
  self.title = @"推荐关注";
    self.view.backgroundColor = XMGGlobalBg;




}


- (void)setupRefresh{

    self.userTableView.header = [MJRefreshNormalHeader   headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.footer.hidden = YES;


}

- (void)loadNewUsers{

    DDRecommendCategory *rc = DDSelectedCategory;
    
    rc.currentPage = 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"categoty_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
   [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
       NSArray *users = [DDRecommendUser  objectArrayWithKeyValuesArray:responseObject[@"list"]];
       [rc.users   removeAllObjects];
       [rc.users   addObjectsFromArray:users];
       rc.total = [responseObject[@"total"] integerValue];
       if (self.params != params)  return ;
       [self.userTableView  reloadData];
       [self.userTableView.header   endRefreshing];
       [self  checkFooterState];
   } failure:^(NSURLSessionDataTask *task, NSError *error) {
       if (self.params != params) {
           return ;
       }
       
       [SVProgressHUD  showErrorWithStatus:@"加载NewUser数据失败"];
       [self.userTableView.header   endRefreshing];
   }];
    
    

}

- (void)loadMoreUsers{

    DDRecommendCategory *category = DDSelectedCategory;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id
    );
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *users = [DDRecommendUser  objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [category.users   addObjectsFromArray:users];
        if (self.params != params) {
            return ;
            
        }
        
        [self.userTableView reloadData];
        [self   checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) {
            return ;
        }
        
        [SVProgressHUD  showErrorWithStatus:@"加载DDRecommendViewController用户失败"];
        [self.userTableView.footer   endRefreshing];
    }];
    
  


}




- (void)checkFooterState{

    DDRecommendCategory *rc = DDSelectedCategory;
    self.userTableView.footer.hidden = (rc.users.count ==0);
    
    if (rc.users.count == rc.total) {
        [self.userTableView.footer  noticeNoMoreData];
    }else {
    
        [self.userTableView.footer   endRefreshing];
    
    }




}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
    
    [self  checkFooterState];
    
    return [DDSelectedCategory  users].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableView==self.categoryTableView) {
        DDRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DDCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    }else {
    
        DDRecommendUserCell *cell = [tableView  dequeueReusableCellWithIdentifier:DDUserId];
        cell.user  = [DDSelectedCategory  users][indexPath.row];
        return cell;

    }



}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    [self.userTableView.header  endRefreshing];
    [self.userTableView.footer  endRefreshing];
    
    DDRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        [self.userTableView  reloadData];
    }else{
    
        [self.userTableView  reloadData];
        [self.userTableView.header  beginRefreshing];
    
    }


}

- (void)dealloc{

    [self.manager.operationQueue  cancelAllOperations];

}

@end
