//
//  TimetableViewController.m
//  TimeTables
//
//  Created by Golden on 2018/10/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "TimetableViewController.h"
#import "MyTimetablesView.h"         //我的课表
#import "AllTimetablesView.h"        //全部课表
#import "TitleView.h"                //title
#import "DropDownTimeTablesView.h"   //全部课表下拉框
#import "TimeTablesDefine.h"
#import "UIColor+TimeTables.h"
#import "NSDate+TimeTables.h"
#import "TimesTableInterfaceMacro.h"
#import "TimesTableInterfaceRequest.h"

@interface TimetableViewController ()
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) MyTimetablesView *myTimetables;
@property (nonatomic, strong) AllTimetablesView *allTimetables;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) DropDownTimeTablesView *dropView;
@property (nonatomic, strong) NSDate *currentDate;
@end

@implementation TimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults]setObject:self.token forKey:TimesTablesToken];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.currentDate = [NSDate new];
    [self creatUI];
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.frame = CGRectMake(0, 0, 40, 40);
        _searchBtn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        [_searchBtn setTitle:@"筛选" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor colorWithHex:@"#007aff"] forState:UIControlStateNormal];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}

- (void)creatUI {
    //暂时不需要大课表
#if 0
    //title
    self.titleView = [TitleView createTitleViewWithTitleType:MyTimetableTitle];
    __weak typeof(self) weakSelf = self;
    //title点击回调
    [self.titleView setTitleClickedBlock:^(TitleType type) {
        if (type == MyTimetableTitle) {
            [weakSelf.allTimetables removeFromSuperview];
            weakSelf.myTimetables = [[MyTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [weakSelf.searchBtn removeFromSuperview];
            weakSelf.searchBtn = nil;
            [weakSelf.view addSubview:weakSelf.myTimetables];
            //请求数据并刷新
            NSArray *weeks = [weakSelf.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
            [TimesTableInterfaceRequest requestMyCouresList:myCourseParam([weeks firstObject], [weeks lastObject]) success:^(id json) {
                weakSelf.myTimetables.dateArray = json;
            } failed:^(NSError *error) {}];
        }else if (type == AllTimetableTitle) {
            [weakSelf.myTimetables removeFromSuperview];
            weakSelf.allTimetables = [[AllTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            weakSelf.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:weakSelf.searchBtn];
            [weakSelf.view addSubview:weakSelf.allTimetables];
            //请求数据并刷新
            NSArray *weeks = [weakSelf.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
            [TimesTableInterfaceRequest requestAllCouresList:allCourseParam(@"", @"", @"", @"", @"", [weeks firstObject], [weeks lastObject]) success:^(id json) {
                
            } failed:^(NSError *error) {}];
        }
    }];
    self.navigationItem.titleView = self.titleView;
#endif
    
    //timeTableView
    switch (self.timetableViewType) {
        case MyTimetableViewType:{
            //跳转到我的课表
            self.myTimetables = [[MyTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [self.view addSubview:self.myTimetables];
            //请求数据并刷新
            NSArray *weeks = [self.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
            [TimesTableInterfaceRequest requestMyCouresList:myCourseParam([weeks firstObject], [weeks lastObject]) success:^(id json) {
                self.myTimetables.dateArray = json;
            } failed:^(NSError *error) {}];
            break;
        }
        case AllTimetableViewType:{
            self.allTimetables = [[AllTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [self.view addSubview:self.allTimetables];
            //请求数据并刷新
            NSArray *weeks = [self.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
            [TimesTableInterfaceRequest requestAllCouresList:allCourseParam(@"", @"", @"", @"", @"", [weeks firstObject], [weeks lastObject]) success:^(id json) {
            } failed:^(NSError *error) {}];
            break;
        }
        default:
            break;
    }
}

- (void)searchBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setTitle:@"取消" forState:UIControlStateNormal];
    }else {
        [sender setTitle:@"筛选" forState:UIControlStateNormal];
        [self.dropView removeFromSuperview];
        return;
    }
    
    self.dropView = [[DropDownTimeTablesView alloc]initWithTitles:@[@"年级",@"班级",@"科目"] WithInfo:@[@{@"初一":@"1",
                                                                                                    @"初二":@"2",
                                                                                                    @"初三":@"3",
                                                                                                    @"高一":@"4",
                                                                                                    @"高二":@"5",
                                                                                                    @"高三":@"6"
                                                                                                    },@{@"一班":@"7",
                                                                                                        @"二班":@"8",
                                                                                                        @"三班":@"9",
                                                                                                        @"四班":@"10",
                                                                                                        @"五班":@"11",
                                                                                                        @"六班":@"12"
                                                                                                        },@{@"语文":@"13",
                                                                                                            @"数学":@"14",
                                                                                                            @"英语":@"15",
                                                                                                            @"思想品德":@"",
                                                                                                            @"物理":@"16",
                                                                                                            }]];
    [self.view addSubview:self.dropView];
    [self.dropView setDropDownSelectedBlcok:^(NSString *first, NSString *sencond, NSString *third) {
        NSLog(@"%@,%@,%@",first,sencond,third);
    }];
}

@end
