//
//  DDTopicVideoView.m
//  bs
//
//  Created by dt on 16/3/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopicVideoView.h"
#import "DDTopic.h"
#import "UIImageView+WebCache.h"
#import "DDShowPictureViewController.h"
@interface DDTopicVideoView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation DDTopicVideoView
+ (instancetype)videoView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView  addGestureRecognizer:[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(showPicture)]];

}


- (void)showPicture{

    DDShowPictureViewController *showPicture = [[DDShowPictureViewController  alloc] init];
    
    showPicture.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:showPicture animated:YES completion:nil];

}


- (void)setTopic:(DDTopic *)topic{
    _topic = topic;
    
    [self.imageView  sd_setImageWithURL:[NSURL  URLWithString:topic.large_image]];
    
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    
    NSInteger mintue = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    
    self.videotimeLabel.text = [NSString  stringWithFormat:@"%02zd:%02zd",mintue,second];



}







@end
