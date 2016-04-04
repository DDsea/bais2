//
//  DDTopicVoiceView.m
//  bs
//
//  Created by dt on 16/3/16.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopicVoiceView.h"
#import "DDTopic.h"
#import "UIImageView+WebCache.h"
#import "DDShowPictureViewController.h"
@interface DDTopicVoiceView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;

@end



@implementation DDTopicVoiceView
+ (instancetype)voiceView{


    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}


- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    
    self.imageView.userInteractionEnabled = YES;
    [self.imageView  addGestureRecognizer:[[UITapGestureRecognizer  alloc] initWithTarget:self action:@selector(showPicture)]];

}

- (void)showPicture{
    DDShowPictureViewController *showPicture = [[DDShowPictureViewController alloc] init];
    showPicture.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:showPicture animated:YES completion:nil];



}







- (void)setTopic:(DDTopic *)topic{

    _topic = topic;
    
    [self.imageView  sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    self.playcountLabel.text = [NSString  stringWithFormat:@"%zd播放",topic.playcount];

    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetimeLabel.text = [NSString  stringWithFormat:@"%02zd:%02zd",minute,second];

}



@end
