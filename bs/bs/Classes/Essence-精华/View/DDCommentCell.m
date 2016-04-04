//
//  DDCommentCell.m
//  bs
//
//  Created by dt on 16/3/21.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDCommentCell.h"
#import "DDComment.h"
#import "UIImageView+WebCache.h"
#import "DDUser.h"
@interface DDCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *prfileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voiceButton;

@end

@implementation DDCommentCell

- (BOOL)canBecomeFirstResponder{

    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{

    return NO;

}


- (void)awakeFromNib{

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage  imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}


- (void)setComment:(DDComment *)comment{


    _comment = comment;
    
//    [self.prfileImageView    sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    
//
    
    [self.prfileImageView  setHeader:comment.user.profile_image];
    
    
    self.sexView.image = [comment.user.sex   isEqualToString:DDUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    self.contentLabel.text = comment.content;
    self.usernameLabel.text = comment.user.username;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceButton.hidden = NO;
        [self.voiceButton  setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:UIControlStateNormal];
    }else{
        self.voiceButton.hidden = YES;
    
    }


}

- (void)setFrame:(CGRect)frame{

    frame.origin.x = DDTopicCellMargin;
    frame.size.width -= 2*DDTopicCellMargin;
    
    [super setFrame:frame];

}



@end
