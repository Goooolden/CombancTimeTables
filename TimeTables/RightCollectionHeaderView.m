//
//  RightCollectionHeaderView.m
//  TimeTables
//
//  Created by Golden on 2018/10/10.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "RightCollectionHeaderView.h"
#import "UIColor+TimeTables.h"
#import "TimeTablesDefine.h"

@implementation RightCollectionHeaderView

- (void)createRightHeaderView:(RightHeaderViewType)type {
    switch (type) {
        case RightHeaderViewDayWeek: {
            [self createDayweekHeaderView];
            break;
        }
        case RightheaderviewMonthWeek:{
            [self createMonthweekHeaderView];
            break;
        }
        default:
            break;
    }
}

- (instancetype)initWithType:(RightHeaderViewType)type {
    if (self = [super init]) {
        switch (type) {
            case RightHeaderViewDayWeek: {
                [self createDayweekHeaderView];
                break;
            }
            case RightheaderviewMonthWeek:{
                [self createMonthweekHeaderView];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

- (void)createDayweekHeaderView {
    for (int i = 0; i < 7; i++) {
        CGFloat x = getWidth(23);
        CGFloat y = getHeight(8);
        CGFloat w = getWidth(20);
        CGFloat h = getHeight(20);
        //日期
        UILabel *dateLabel = [[UILabel alloc]init];
        dateLabel.frame = CGRectMake(x + getWidth(66) * i, y, w, h);
        dateLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        dateLabel.textColor = [UIColor colorWithHex:@"#38383d"];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.text = @"18";
        [self addSubview:dateLabel];
        //星期
        UILabel *weeklabel = [[UILabel alloc]init];
        CGFloat weekX = getWidth(19);
        weeklabel.frame = CGRectMake(weekX + getWidth(66) * i, y + h + 4, getWidth(30), getHeight(30));
        weeklabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        weeklabel.layer.masksToBounds = YES;
        weeklabel.layer.cornerRadius = getHeight(30)/2;
        weeklabel.textAlignment = NSTextAlignmentCenter;
        weeklabel.text = @"三";
        if (i == 3) {
            weeklabel.textColor = [UIColor whiteColor];
            weeklabel.backgroundColor = [UIColor colorWithHex:@"007aff"];
        }
        [self addSubview:weeklabel];
    }
}

- (void)createMonthweekHeaderView {
    for (int i = 0; i < 7; i++) {
        CGFloat x = getWidth(2);
        CGFloat y = getHeight(8);
        CGFloat w = getWidth(163);
        CGFloat h = getHeight(44);
        UILabel *dateLabel = [[UILabel alloc]init];
        dateLabel.frame = CGRectMake((x + w) * i, y, w, h);
        dateLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        dateLabel.textColor = [UIColor colorWithHex:@"#38383d"];
        dateLabel.backgroundColor = [UIColor whiteColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        dateLabel.text = @"7月18日  周一";
        [self addSubview:dateLabel];
    }
}

@end
