//
//  DiYuCell2.m
//  IYLM
//
//  Created by JianYe on 13-1-11.
//  Copyright (c) 2013年 Jian-Ye. All rights reserved.
//

#import "Cell2.h"

@implementation Cell2
@synthesize titleLabel;
@synthesize m_subTitleLabel;
@synthesize m_cellImageView;
- (void)dealloc
{
    self.titleLabel = nil;
    [m_subTitleLabel release];
    [m_cellImageView release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        [self  addSubview:self.m_cellImageView];
//        [self  addSubview:self.titleLabel];
//        [self  addSubview:self.m_subTitleLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
