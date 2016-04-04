//
//  DDRecommendUserCell.m
//  bs
//
//  Created by dt on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDRecommendUserCell.h"
#import "DDRecommendUser.h"
#import "UIImageView+WebCache.h"
@interface DDRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end



@implementation DDRecommendUserCell

- (void)setUser:(DDRecommendUser *)user{

    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    
    NSString *fansCount = nil;
    
    if (user.fans_count<10000) {
        fansCount = [NSString  stringWithFormat:@"%zd人关注",user.fans_count];
    }else {
    
        fansCount = [NSString  stringWithFormat:@"%.1f万人关注",user.fans_count / 10000.0];
    }

    self.fansCountLabel.text = fansCount;
    [self.headerImageView   sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

}


@end
