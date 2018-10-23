//
//  MyPopView.m
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyPopView.h"
#import "UIColor+TimeTables.h"
#import "Masonry.h"

@interface MyPopView ()
//左侧周次
@property (nonatomic, strong) UILabel *weekLabel;
//中间日期
@property (nonatomic, strong) UIView *dateView;
//日期
@property (nonatomic, strong) UILabel *dayLabel;
//月份
@property (nonatomic, strong) UILabel *monthLabel;
//右侧节次
@property (nonatomic, strong) UILabel *sectionLabel;
//学科名称
@property (nonatomic, strong) UILabel *courseNameLabel;
//班级
@property (nonatomic, strong) UILabel *classLabel;
//上课地点
@property (nonatomic, strong) UILabel *placeLabel;
@end

@implementation MyPopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        [self configUI];
        
        self.weekLabel.text = @"周三";
        self.dayLabel.text = @"15";
        self.monthLabel.text = @"10月";
        self.sectionLabel.text= @"第二节";
        self.courseNameLabel.text = @"社会与科学";
        self.classLabel.text = @"高三1班";
        self.placeLabel.text = @"教学楼502教室";
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.weekLabel];
    [self.weekLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.top.equalTo(self).offset(18);
    }];
    
    [self addSubview:self.dateView];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.dateView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(6,6)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.dateView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.dateView.layer.mask = maskLayer;
    
    [self.dateView addSubview:self.dayLabel];
    [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dateView);
        make.top.equalTo(self.dateView).offset(5);
    }];
    
    [self.dateView addSubview:self.monthLabel];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.dateView);
        make.top.equalTo(self.dayLabel.mas_bottom);
    }];
    
    [self addSubview:self.sectionLabel];
    [self.sectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekLabel.mas_top);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    
    [self addSubview:self.courseNameLabel];
    [self.courseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateView.mas_bottom).offset(11);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.classLabel];
    [self.classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.courseNameLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self);
    }];
    
    [self addSubview:self.placeLabel];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.classLabel.mas_bottom).offset(4);
        make.centerX.equalTo(self);
    }];
}

- (UILabel *)weekLabel {
    if (!_weekLabel) {
        _weekLabel = [[UILabel alloc]init];
        _weekLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _weekLabel.textColor = [UIColor colorWithHex:@"#007aff"];
    }
    return _weekLabel;
}

- (UIView *)dateView {
    if (!_dateView) {
        _dateView = [[UIView alloc]initWithFrame:CGRectMake(78, 0, 44, 54)];
        _dateView.backgroundColor = [UIColor colorWithHex:@"#007aff"];
    }
    return _dateView;
}

- (UILabel *)dayLabel {
    if (!_dayLabel) {
        _dayLabel = [[UILabel alloc]init];
        _dayLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _dayLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
    }
    return _dayLabel;
}

- (UILabel *)monthLabel {
    if (!_monthLabel) {
        _monthLabel = [[UILabel alloc]init];
        _monthLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        _monthLabel.textColor = [UIColor colorWithHex:@"#ffffff"];
    }
    return _monthLabel;
}

- (UILabel *)sectionLabel {
    if (!_sectionLabel) {
        _sectionLabel = [[UILabel alloc]init];
        _sectionLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        _sectionLabel.textColor = [UIColor colorWithHex:@"#007aff"];
    }
    return _sectionLabel;
}

- (UILabel *)courseNameLabel {
    if (!_courseNameLabel) {
        _courseNameLabel = [[UILabel alloc]init];
        _courseNameLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _courseNameLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    }
    return _courseNameLabel;
}

- (UILabel *)classLabel {
    if (!_classLabel) {
        _classLabel = [[UILabel alloc]init];
        _classLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _classLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    }
    return _classLabel;
}

- (UILabel *)placeLabel {
    if (!_placeLabel) {
        _placeLabel = [[UILabel alloc]init];
        _placeLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _placeLabel.textColor = [UIColor colorWithHex:@"#38383d"];
    }
    return _placeLabel;
}

@end
