//
//  AllPopTableViewCell.m
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "AllPopTableViewCell.h"
#import "UIColor+TimeTables.h"
#import "Masonry.h"

@interface AllPopTableViewCell ()
//标识点
@property (nonatomic, strong) UIImageView *pointImageView;
//科目名称
@property (nonatomic, strong) UILabel *courseNameLabel;
//班级名称
@property (nonatomic, strong) UILabel *classLabel;
//教师名字
@property (nonatomic, strong) UILabel *teacherLabel;
@end

@implementation AllPopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        
        self.pointImageView.backgroundColor = [UIColor colorWithHex:@"#007aff"];
        self.courseNameLabel.text = @"思想品德";
        self.classLabel.text = @"高三1班";
        self.teacherLabel.text = @"王云辉";
    }
    return self;
}

- (void)configUI {
    self.pointImageView = [[UIImageView alloc]init];
    self.pointImageView.layer.cornerRadius = 5;
    self.pointImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.pointImageView];
    
    self.courseNameLabel = [[UILabel alloc]init];
    self.courseNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.courseNameLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    [self.contentView addSubview:self.courseNameLabel];
    
    self.classLabel = [[UILabel alloc]init];
    self.classLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.classLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    [self.contentView addSubview:self.classLabel];
    
    self.teacherLabel = [[UILabel alloc]init];
    self.teacherLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.teacherLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    [self.contentView addSubview:self.teacherLabel];
    
    [self.courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView.mas_left).offset(44);
    }];
    
    [self.pointImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.centerY.equalTo(self.courseNameLabel);
        make.width.height.mas_equalTo(10);
    }];
    
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.courseNameLabel);
        make.top.equalTo(self.courseNameLabel.mas_bottom).offset(14);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
        make.width.mas_equalTo(94);
    }];
    
    [self.teacherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.classLabel.mas_right).offset(12);
        make.top.bottom.equalTo(self.classLabel);
    }];
}

@end
