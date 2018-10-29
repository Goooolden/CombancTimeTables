//
//  WeekView.m
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "WeekView.h"
#import "UIColor+TimeTables.h"
#import "TimeTablesDefine.h"

@interface WeekView()

@property (nonatomic, copy  ) NSDictionary *infoDic;
@property (nonatomic, strong) UIButton *recordBtn;

@end

@implementation WeekView

+ (instancetype)creatWithFrame:(CGRect)frame infoDictionary:(NSDictionary *)dic {
    NSAssert(dic != nil, @"信息不能为空");
    
    if (CGRectIsNull(frame)) {
        frame = CGRectMake(0, 0, SCREEN_WIDTH, getHeight(46));
    }

    WeekView *weekView = [[WeekView alloc]initWithFrame:frame infoDic:dic];
    return weekView;
}

- (instancetype)initWithFrame:(CGRect)frame infoDic:(NSDictionary *)dic {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _infoDic = dic;
        [self configUI];
    }
    return self;
}

- (void)configUI {
    //周次仅显示三周
    for (int i = 0; i < 3; i++) {
        CGFloat x = getWidth(10);
        CGFloat y = getHeight(8);
        CGFloat w = getWidth(105);
        CGFloat h = getHeight(30);
        UIButton *weekBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        weekBtn.frame = CGRectMake(x + (w + getWidth(20)) * i, y, w, h);
        weekBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        weekBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [weekBtn setTitle:@"第十五周" forState:UIControlStateNormal];
        [weekBtn setBackgroundColor:[UIColor whiteColor]];
        [weekBtn setTitleColor:[UIColor colorWithHex:@"#7a7e85"] forState:UIControlStateNormal];
        if (i == 1) {
            [weekBtn setBackgroundColor:[UIColor colorWithHex:@"#007aff"]];
            [weekBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _recordBtn = weekBtn;
        }
        weekBtn.layer.borderColor = [[UIColor colorWithHex:@"#f8faff"] CGColor];
        weekBtn.layer.borderWidth = 1;
        weekBtn.layer.masksToBounds = YES;
        weekBtn.layer.cornerRadius = 15;
        weekBtn.tag = i;
        [weekBtn addTarget:self action:@selector(weekButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:weekBtn];
    }
}

- (void)weekButtonClick:(UIButton *)sender {
    if (self.weekViewClickedBlock) {
        self.weekViewClickedBlock(@"第十五周", @"typeid");
    }
    if (_recordBtn == sender) {
        //上次点击的按钮，不做处理
    }else {
        //本次点击的按钮
        [sender setBackgroundColor:[UIColor colorWithHex:@"#007aff"]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //上次点击的按钮
        [_recordBtn setBackgroundColor:[UIColor whiteColor]];
        [_recordBtn setTitleColor:[UIColor colorWithHex:@"#7a7e85"] forState:UIControlStateNormal];
    }
    _recordBtn = sender;
}

@end
