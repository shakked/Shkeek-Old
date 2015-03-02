//
//  ZSSFeedCell.m
//  Shkeek
//
//  Created by Zachary Shakked on 2/27/15.
//  Copyright (c) 2015 Shkeek Inc. All rights reserved.
//

#import "ZSSFeedCell.h"

@implementation ZSSFeedCell

- (void)awakeFromNib {
    // Initialization code
    
    self.groupImageView.layer.cornerRadius = 25.0f;
    self.groupImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
