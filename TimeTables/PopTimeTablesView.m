//
//  PopTimeTablesView.m
//  TimeTables
//
//  Created by Golden on 2018/10/15.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "PopTimeTablesView.h"
#import "MyPopView.h"
#import "AllPopView.h"
#import "Masonry.h"

@interface PopTimeTablesView ()
//背景视图
@property (nonatomic, strong) UIView *backgroundView;
//弹出视图
@property (nonatomic, strong) UIView *popView;
//我的课表弹出视图
@property (nonatomic, strong) MyPopView *myPopView;
//全部课表弹出视图
@property (nonatomic, strong) AllPopView *allPopView;
//退出按钮
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation PopTimeTablesView

- (instancetype)initWithPopTimeTablesViewType:(PopTimeTablesViewType)type InfoArray:(NSArray<CourseInfoModel *> *)array {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.backgroundView];
        [self addSubview:self.deleteBtn];
        if (type == MyPopTimeTablesViewType) {
            MyPopView *myView = [[MyPopView alloc]init];
            myView.dataArray = array;
            [self addSubview:myView];
            [myView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.width.mas_equalTo(200);
                make.height.mas_equalTo(140);
            }];
            [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(myView.mas_bottom).offset(16);
                make.width.height.mas_equalTo(22);
            }];
        }else if (type == AllPopTimeTablesViewType) {
            AllPopView *allView = [[AllPopView alloc]init];
            [self addSubview:allView];
            [allView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.width.mas_equalTo(280);
                make.height.mas_equalTo(350);
            }];
            [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(allView.mas_bottom).offset(16);
                make.width.height.mas_equalTo(22);
            }];
        }
    }
    return self;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.3;
    }
    return _backgroundView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"Resource.bundle/icon_close.png"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

- (void)deleteBtnClicked:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
