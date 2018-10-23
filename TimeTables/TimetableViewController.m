//
//  TimetableViewController.m
//  TimeTables
//
//  Created by Golden on 2018/10/11.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "TimetableViewController.h"
#import "TitleView.h"
#import "MyTimetablesView.h"
#import "AllTimetablesView.h"
#import "TimeTablesDefine.h"

@interface TimetableViewController ()

@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) MyTimetablesView *myTimetables;
@property (nonatomic, strong) AllTimetablesView *allTimetables;

@end

@implementation TimetableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self creatUI];
}

- (void)creatUI {
    //title
    self.titleView = [TitleView createTitleViewWithTitleType:MyTimetableTitle];
    __weak typeof(self) weakSelf = self;
    [self.titleView setTitleClickedBlock:^(TitleType type) {
        if (type == MyTimetableTitle) {
            [weakSelf.allTimetables removeFromSuperview];
            weakSelf.myTimetables = [[MyTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [weakSelf.view addSubview:weakSelf.myTimetables];
        }else if (type == AllTimetableTitle) {
            [weakSelf.myTimetables removeFromSuperview];
            weakSelf.allTimetables = [[AllTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [weakSelf.view addSubview:weakSelf.allTimetables];
        }
    }];
    self.navigationItem.titleView = self.titleView;
    
    //timeTableView
    switch (self.timetableViewType) {
        case MyTimetableViewType:{
            self.myTimetables = [[MyTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [self.view addSubview:self.myTimetables];
            break;
        }
        case AllTimetableViewType:{
            self.allTimetables = [[AllTimetablesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - getHeight(64))];
            [self.view addSubview:self.allTimetables];
            break;
        }
        default:
            break;
    }
}

@end
