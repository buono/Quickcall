//
//  IconCell.m
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/02/01.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "IconCell.h"

@implementation IconCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(10, 10, 24, 24);
}

@end
