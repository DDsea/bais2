//
//  DDRecommendCategoryCell.m
//  bs
//
//  Created by dt on 16/3/5.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDRecommendCategoryCell.h"
#import "DDRecommendCategory.h"

@interface DDRecommendCategoryCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation DDRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    
    self.backgroundColor = XMGRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = XMGRGBColor(219, 21, 26);
    
    
}

- (void)setCategory:(DDRecommendCategory *)category{

    _category = category;
    
    self.textLabel.text = category.name;


}

- (void)layoutSubviews{

    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;


}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected?self.selectedIndicator.backgroundColor:XMGRGBColor(78, 78, 78);
    
}

@end
