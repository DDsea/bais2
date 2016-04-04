//
//  DDTopicCell.m
//  bs
//
//  Created by dt on 16/3/9.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopicCell.h"
#import "DDTopic.h"
#import "UIImageView+WebCache.h"
#import "DDTopicPictureView.h"
#import "DDTopicVoiceView.h"
#import "DDTopicVideoView.h"
#import "DDComment.h"
#import "DDUser.h"
@interface DDTopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (nonatomic, weak) DDTopicPictureView *pictureView;

@property (nonatomic, weak) DDTopicVoiceView *voiceView;

@property (nonatomic, weak) DDTopicVideoView *videoView;

@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end



@implementation DDTopicCell


+ (instancetype)cell{


    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]   firstObject];

}


- (DDTopicPictureView *)pictureView{

    if (!_pictureView) {
        DDTopicPictureView *pictureView = [DDTopicPictureView  pictureView];
        [self.contentView    addSubview:pictureView];
        _pictureView = pictureView;
    }

    return _pictureView;
}

- (DDTopicVoiceView *)voiceView{
    if (!_voiceView) {
        DDTopicVoiceView *voiceView = [DDTopicVoiceView voiceView];
        [self.contentView  addSubview:voiceView];
        _voiceView = voiceView;
    }

    return _voiceView;
}


- (DDTopicVideoView *)videoView{

    if (!_videoView) {
        DDTopicVideoView *videoView = [DDTopicVideoView videoView];
        [self.contentView  addSubview:videoView];
        
        _videoView = videoView;
    }

    return _videoView;
}



- (void)awakeFromNib{

    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;

}

- (void)setTopic:(DDTopic *)topic{


    _topic = topic;
    
    self.sinaVView.hidden = !topic.isSina_v;

    [self.profileImageView   sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    
    self.createTimeLabel.text = topic.create_time;
    
    
    [self  setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    
    
    [self   setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    
    [self  setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    
    [self  setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    self.text_label.text = topic.text;
    
    if (topic.type == DDTopicTypePicture) {
        self.pictureView.hidden = NO;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
        
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == DDTopicTypeVoice){
        self.voiceView.hidden = NO;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceF;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    }else if (topic.type == DDTopicTypeVideo){
        
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoF;
        
        self.voiceView.hidden = YES;
        self.pictureView.hidden = YES;
    }else {
        self.videoView.hidden = YES;
        
        self.voiceView.hidden = YES;
        
        self.pictureView.hidden = YES;
    
    }
    
    //DDComment *cmt = [topic.top_cmt  firstObject];
    
    if (topic.top_cmt) {
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",topic.top_cmt.user.username, topic.top_cmt.content];
    }else{
    
        self.topCmtView.hidden = YES;
    }
    
    
    

}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{


    if (count > 10000) {
        placeholder = [NSString  stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
    
        placeholder = [NSString stringWithFormat:@"%zd",count];
    
    }

    [button  setTitle:placeholder forState:UIControlStateNormal];

}


- (void)setFrame:(CGRect)frame{

    frame.origin.x = DDTopicCellMargin;
    frame.size.width -= 2*DDTopicCellMargin;
    //frame.size.height -= DDTopicCellMargin;
    
    frame.size.height = self.topic.cellHeight - DDTopicCellMargin;
    frame.origin.y += DDTopicCellMargin;
    
    [super setFrame:frame];


}




- (IBAction)more {
    
    UIActionSheet *sheet =  [[UIActionSheet alloc] initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"收藏",@"举报", nil];
    [sheet  showInView:self.window];

    
}





@end
