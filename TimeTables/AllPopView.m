//
//  AllPopView.m
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "AllPopView.h"
#import "AllPopTableViewCell.h"
#import "Masonry.h"
#import "UIColor+TimeTables.h"

static NSString *const CELL_ID = @"CELL_ID";

@interface AllPopView ()<
UITableViewDelegate,
UITableViewDataSource>
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
//分割线
@property (nonatomic, strong) UILabel *lineLabel;
//下方显示
@property (nonatomic, strong) UITableView *tablevView;
@end

@implementation AllPopView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 6;
        [self configUI];
        
        self.weekLabel.text = @"周三";
        self.dayLabel.text = @"15";
        self.monthLabel.text = @"10月";
        self.sectionLabel.text= @"第二节";
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
    
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateView.mas_bottom).offset(10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(2);
    }];
    
    [self addSubview:self.tablevView];
    [self.tablevView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.lineLabel.mas_bottom).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
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
        _dateView = [[UIView alloc]initWithFrame:CGRectMake(118, 0, 44, 54)];
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

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithHex:@"#007aff"];
    }
    return _lineLabel;
}

- (UITableView *)tablevView {
    if (!_tablevView) {
        _tablevView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tablevView.delegate = self;
        _tablevView.dataSource = self;
        _tablevView.showsVerticalScrollIndicator = NO;
        _tablevView.showsHorizontalScrollIndicator = NO;
        _tablevView.tableFooterView = [UIView new];
        _tablevView.rowHeight = UITableViewAutomaticDimension;
        _tablevView.estimatedRowHeight = 80;
        _tablevView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tablevView.layer.cornerRadius = 6;
    }
    return _tablevView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AllPopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if (!cell) {
        cell = [[AllPopTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
