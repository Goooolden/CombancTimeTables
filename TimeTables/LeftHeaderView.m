//
//  LeftHeaderView.m
//  TimeTables
//
//  Created by Golden on 2018/10/10.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "LeftHeaderView.h"
#import "UIColor+TimeTables.h"
#import "Masonry.h"
#import "TimeTablesDefine.h"

@implementation LeftHeaderView

+ (instancetype)createLeftHeaderView:(LeftHeaderType)type title:(NSString *)title {
    NSAssert(title != nil, @"标题不能为空");
    
    LeftHeaderView *headerView;
    switch (type) {
        case LeftHeaderMonth:{
            //月份
            headerView = [[LeftHeaderView alloc]initWithFrame:CGRectMake(0, 0, getWidth(42), getHeight(66)) type:type title:title];
            break;
        }
        case LeftHeaderSection:{
            //节次
            headerView = [[LeftHeaderView alloc]initWithFrame:CGRectMake(0, 0, getWidth(43), getHeight(60)) type:type title:title];
            break;
        }
        default:
            break;
    };
    return headerView;
}

- (instancetype)initWithFrame:(CGRect)frame type:(LeftHeaderType)type title:(NSString *)title {
    if (self = [super initWithFrame:frame]) {
        switch (type) {
            case LeftHeaderMonth:{
                [self creatMonthHeader:title];
                break;
            }
            case LeftHeaderSection: {
                [self creatSectionHeader:title];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)creatMonthHeader:(NSString *)title {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    label.textColor = [UIColor colorWithHex:@"#38383d"];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)creatSectionHeader:(NSString *)title {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
    label.textColor = [UIColor colorWithHex:@"#38383d"];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    [self addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(getHeight(8));
        make.height.mas_equalTo(getHeight(44));
        make.width.mas_equalTo(getWidth(41));
    }];
}

@end
