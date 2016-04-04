//
//  DDCommentHeaderView.m
//  bs
//
//  Created by dt on 16/3/21.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDCommentHeaderView.h"

@interface DDCommentHeaderView ()
@property (nonatomic , weak) UILabel *label;
@end



@implementation DDCommentHeaderView

+ (instancetype)headerViewWithTableView:(UITableView *)tableView{

static NSString *ID = @"header";
    
    DDCommentHeaderView *header = [tableView  dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[DDCommentHeaderView  alloc] initWithReuseIdentifier:ID
                  ];
    }


    return header;

}



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{


    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor yellowColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = XMGRGBColor(67, 67, 67);
        label.width = 200;
        label.x = DDTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        
        [self.contentView  addSubview:label];
        
        self.label = label;
    }


    return self;


}




- (void)setTitle:(NSString *)title{

    _title = [title copy];
    
    self.label.text = title;




}






@end
