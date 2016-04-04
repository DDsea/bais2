//
//  DDCommentViewController.m
//  bs
//
//  Created by dt on 16/3/21.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDCommentViewController.h"
#import "DDTopicCell.h"
#import "DDTopic.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "DDComment.h"
#import "MJExtension.h"
#import "DDCommentHeaderView.h"
#import "DDCommentCell.h"

static NSString *const DDCommentId = @"comment";
@interface DDCommentViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSapce;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *hotComments;

@property (nonatomic, strong) NSMutableArray *latestComments;


@property (nonatomic, strong) DDComment *saved_top_cmt;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation DDCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self  setupBasic];
    
    [self  setupHeader];
    
    
    [self  setupRefresh];
    
}

- (AFHTTPSessionManager *)manager{

    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }

    return _manager;
}



- (void)setupRefresh{

    self.tableView.header = [MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    [self.tableView.header  beginRefreshing];
    
    self.tableView.footer = [MJRefreshAutoNormalFooter  footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableView.footer.hidden = YES;

}


- (void)loadMoreComments{


    [self.manager.tasks   makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger page = self.page + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(page);
    DDComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *newComments = [DDComment  objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.latestComments  addObjectsFromArray:newComments];
        
        self.page = page;
        [self.tableView  reloadData];
        
        NSInteger total = [responseObject[@"total"]  integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.footer.hidden = YES;
        }else{
        
            [self.tableView.footer  endRefreshing];
        
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.footer  endRefreshing];
    }];



}











- (void)setupHeader{

    UIView *header = [[UIView alloc] init];
    
    if (self.topic.top_cmt) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        
        [self.topic  setValue:@0 forKeyPath:@"cellHeight"];
    }

    DDTopicCell *cell = [DDTopicCell cell];
    
    cell.topic = self.topic;
    cell.size = CGSizeMake(DDScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    cell.contentView.backgroundColor = [UIColor  redColor];
    header.height = self.topic.cellHeight + DDTopicCellMargin;
    
    self.tableView.tableHeaderView = header;


}







- (void)loadNewComments{
    [self.manager.tasks   makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary  dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager  GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (![responseObject  isKindOfClass:[NSDictionary class]]) {
            [self.tableView.header  endRefreshing];
            return ;
        }
        
        
        
        self.hotComments = [DDComment  objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        
        self.latestComments = [DDComment  objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        self.page = 1;
        [self.tableView  reloadData];
        
        [self.tableView.header  endRefreshing];
        
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) {
            self.tableView.footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.header  endRefreshing];
    }];

}



- (void)setupBasic{
self.title = @"评论";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@" " highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    [[NSNotificationCenter   defaultCenter]  addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.backgroundColor =  XMGGlobalBg;

    
    [self.tableView    registerNib:[UINib  nibWithNibName:NSStringFromClass([DDCommentCell  class]) bundle:nil] forCellReuseIdentifier:DDCommentId];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, DDTopicCellMargin, 0);

}



- (void)keyboardWillChangeFrame:(NSNotification *)note{

    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey]  CGRectValue];
    
    self.bottomSapce.constant = DDScreenH - frame.origin.y ;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey]  doubleValue];
    
    [UIView  animateWithDuration:duration animations:^{
        [self.view  layoutIfNeeded];
    }];



}



- (void)dealloc{

    [[NSNotificationCenter  defaultCenter] removeObserver:self];
    
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        
        [self.topic  setValue:@0 forKeyPath:@"cellHeight"];
    }

    
    [self.manager  invalidateSessionCancelingTasks:YES];
}


- (NSArray *)commentInSection:(NSInteger)section{

    if (section == 0) {
        return self.hotComments.count ? self.hotComments : self.latestComments;
    }

    
    return self.latestComments;
}

- (DDComment *)commentInIndexPath:(NSIndexPath *)indexPath{


    return [self  commentInSection:indexPath.section][indexPath.row];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{


    [self.view  endEditing:YES];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    NSInteger hotCount = self.hotComments.count;
    
    NSInteger latestCount = self.latestComments.count;
    
    if (hotCount) return 2;
    
    if (latestCount) return 1;
    
    return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger hotCount = self.hotComments.count;
    
    NSInteger latestCount = self.latestComments.count;
    
    if (section==0) {
        return hotCount ? hotCount : latestCount;
    }

    return latestCount;
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSInteger hotCount = self.hotComments.count;
//    
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//
//return @"最新评论";
//
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    DDCommentHeaderView *header = [DDCommentHeaderView  headerViewWithTableView:tableView];
    
    NSInteger hotCount = self.hotComments.count;
    
    if (section == 0) {
        header.title = hotCount ? @"最热评论": @"最新评论";
    }else{
    
    header.title = @"最新评论";
    
    }


    return header;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    UITableViewCell *cell = [tableView  dequeueReusableCellWithIdentifier:@"comment"];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
//    }
//
//    
//    DDComment *comment  = [self  commentInIndexPath:indexPath];
//    
//    cell.textLabel.text = comment.content;
    
    
    DDCommentCell *cell = [tableView  dequeueReusableCellWithIdentifier:DDCommentId];
    
    cell.comment = [self  commentInIndexPath:indexPath];
    
    
    return cell;

}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{


    [self.view   endEditing:YES];
    
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];

}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    UIMenuController *menu = [UIMenuController  sharedMenuController];
    
    if (menu.isMenuVisible) {
        [menu  setMenuVisible:NO animated:YES];
    } else{
    
        DDCommentCell *cell = (DDCommentCell *)[tableView  cellForRowAtIndexPath:indexPath];
        
        [cell becomeFirstResponder];
        
        UIMenuItem *ding = [[UIMenuItem alloc] initWithTitle:@"顶" action:@selector(ding:)];
        
        UIMenuItem *replay = [[UIMenuItem alloc] initWithTitle:@"回复" action:@selector(replay:)];
        
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"举报" action:@selector(report:)];
        
        menu.menuItems = @[ding,replay,report];
        
        CGRect rect = CGRectMake(0, cell.height*0.5, cell.width, cell.height*0.5);
        
        [menu  setTargetRect:rect inView:cell];
        [menu  setMenuVisible:YES animated:YES];
    
    
    
    }




}


- (void)ding:(UIMenuController *)menu{

    NSIndexPath *indexPath = [self.tableView  indexPathForSelectedRow];

    NSLog(@"%s %@",__func__,[self   commentInIndexPath:indexPath].content);
}

- (void)replay:(UIMenuController *)menu{

    NSIndexPath *indexPath = [self.tableView  indexPathForSelectedRow];
    
    NSLog(@"%s %@",__func__, [self  commentInIndexPath:indexPath].content);

}

- (void)report:(UIMenuController *)menu{

    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    NSLog(@"%s, %@",__func__,[self commentInIndexPath:indexPath].content);

}








@end
