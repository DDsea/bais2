//
//  DDTopicPictureView.m
//  bs
//
//  Created by dt on 16/3/12.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDTopicPictureView.h"
#import "DDTopic.h"
#import "UIImageView+WebCache.h"
#import "DDProgressView.h"
#import "DDShowPictureViewController.h"
@interface DDTopicPictureView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet DDProgressView *progressView;

@end





@implementation DDTopicPictureView



+ (instancetype)pictureView{

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}


- (void)awakeFromNib{

    self.autoresizingMask = UIViewAutoresizingNone;
    self.imageView.userInteractionEnabled = YES;
    [self.imageView  addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
    
}

- (void)showPicture{


    DDShowPictureViewController *showPicture = [[DDShowPictureViewController alloc] init];
    
    showPicture.topic = self.topic;
    
    [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:showPicture animated:YES completion:nil];



}


- (void)setTopic:(DDTopic *)topic{

    _topic = topic;
    
    [self.progressView  setProgress:topic.pictureProgress animated:NO];
    
    [self.imageView  sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        topic.pictureProgress = 1.0 * receivedSize/ expectedSize;
        [self.progressView  setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        if(topic.isBigPicture == NO) return ;
        
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image  drawInRect:CGRectMake(0, 0, width, height)];
        
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
    }];
    
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString  isEqualToString:@"gif"];
    
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
    
        self.seeBigButton.hidden = YES;
        
       // self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    }
    
    
    
    
}









@end
