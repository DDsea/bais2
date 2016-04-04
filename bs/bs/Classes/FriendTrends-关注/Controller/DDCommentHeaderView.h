//
//  DDCommentHeaderView.h
//  bs
//
//  Created by dt on 16/3/21.
//  Copyright © 2016年 dt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDCommentHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
