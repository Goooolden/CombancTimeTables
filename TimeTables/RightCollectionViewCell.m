//
//  RightCollectionViewCell.m
//  TimeTables
//
//  Created by Golden on 2018/10/10.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "RightCollectionViewCell.h"
#import "UIColor+TimeTables.h"
#import "Masonry.h"

@interface RightCollectionViewCell ()

@end

@implementation RightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.courseLabel = [[UILabel alloc]init];
    self.courseLabel.textAlignment = NSTextAlignmentCenter;
    self.courseLabel.numberOfLines = 0;
    self.courseLabel.text = @"数学\n高三五班\n502教室";
    self.courseLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    self.courseLabel.backgroundColor = [UIColor whiteColor];
    self.courseLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    [self.contentView addSubview:self.courseLabel];
    
    [self.courseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

@end
