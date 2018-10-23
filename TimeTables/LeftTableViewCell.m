//
//  LeftTableViewCell.m
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "LeftTableViewCell.h"
#import "Masonry.h"
#import "UIColor+TimeTables.h"

@implementation LeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    //显示节次，先计算n每个字的宽度
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    CGSize sizeWord = [@"第" sizeWithAttributes:@{NSFontAttributeName:font}];
    
    self.leftLabel = [[UILabel alloc]init];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    self.leftLabel.numberOfLines = 0;
    self.leftLabel.font = font;
    self.leftLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(sizeWord.width);
    }];
    
    //右侧分割线
    UILabel *rightLine = [[UILabel alloc]init];
    rightLine.backgroundColor = [UIColor colorWithHex:@"#e6e6e6"];
    [self.contentView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right);
        make.width.mas_equalTo(1);
    }];
}

@end
