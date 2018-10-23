//
//  TitleView.m
//  TimeTables
//
//  Created by Golden on 2018/10/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "TitleView.h"
#import "UIColor+TimeTables.h"
#import "Masonry.h"
#import "TimeTablesDefine.h"

@interface TitleView ()

@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, copy  ) NSString *title;

@end

@implementation TitleView

+ (instancetype)createTitleViewWithTitleType:(TitleType)titleType {
    TitleView *titleView = [[TitleView alloc]initWithTitleType:titleType];
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, getHeight(44));
    return titleView;
}

- (instancetype)initWithTitleType:(TitleType)type {
    if (self = [super init]) {
        if (type == MyTimetableTitle) {
            _title = @"我的课表";
        }else if (type == AllTimetableTitle) {
            _title = @"全部课表";
        }
        [self configUI];
    }
    return self;
}

- (void)configUI {
    self.titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Bold" size:18];
    self.titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.titleBtn setTitle:_title forState:UIControlStateNormal];
    [self.titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.titleBtn setImage:[UIImage imageNamed:@"Resource.boundle/icon_switch.png"] forState:UIControlStateNormal];
    [self.titleBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -165)];
    [self.titleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.titleBtn];
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)titleBtnClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"我的课表"]) {
        [sender setTitle:@"全部课表" forState:UIControlStateNormal];
        if (self.titleClickedBlock) {
            self.titleClickedBlock(AllTimetableTitle);
        }
    }else if ([sender.titleLabel.text isEqualToString:@"全部课表"]) {
        [sender setTitle:@"我的课表" forState:UIControlStateNormal];
        if (self.titleClickedBlock) {
            self.titleClickedBlock(MyTimetableTitle);
        }
    }
}

@end
