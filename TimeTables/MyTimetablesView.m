//
//  MyTimetablesViewController.m
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "MyTimetablesView.h"
#import "LeftTableViewCell.h"
#import "RightCollectionViewCell.h"
#import "LeftHeaderView.h"
#import "RightCollectionHeaderView.h"
#import "UIColor+TimeTables.h"
#import "WeekView.h"
#import "PopTimeTablesView.h"
#import "TimeTablesDefine.h"
#import "NSDate+TimeTables.h"
#import "TimesTableInterfaceMacro.h"
#import "TimesTableInterfaceRequest.h"
#import "NSDate+TimeTables.h"

#define CELL_WIDTH  getWidth(66)
#define CELL_HEIGHT getHeight(80)

static NSString *const LEFT_CELLID = @"LEFT_CELLID";
static NSString *const RIGHT_CELLID = @"RIGHT_CELLID";
static NSString *const COLLECTION_HEADER = @"COLLECTION_HEADER";

@interface MyTimetablesView()<
UITableViewDelegate,
UITableViewDataSource,
UIScrollViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
WeekViewDelegate>

@property (nonatomic, copy  ) NSArray *datas;
@property (nonatomic, strong) WeekView *weekView;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UIScrollView *rightScrollView;
@property (nonatomic, strong) UICollectionView *rightCollectionView;
@property (nonatomic, strong) NSDate *currentDate;

@end

@implementation MyTimetablesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.currentDate = [NSDate new];
        [self configUI];
    }
    return self;
}

- (void)setDateArray:(NSArray<MyCourseModel *> *)dateArray {
    _dateArray = dateArray;
    [self.rightCollectionView reloadData];
}

- (void)configUI {
    //获取今年中最近的三周为第几周
    int currentWeeks = [self.currentDate weeksInYear];
    NSMutableArray *weekArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"第%d周",currentWeeks - 1],[NSString stringWithFormat:@"第%d周",currentWeeks],[NSString stringWithFormat:@"第%d周",currentWeeks + 1], nil];
    
    WeekView *weekView = [WeekView creatWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, getHeight(46)) infoArray:weekArray];
    weekView.weekViewDelegate = self;
    [self addSubview:weekView];
    
    self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, getHeight(46), getWidth(42), self.bounds.size.height - getHeight(46)) style:UITableViewStylePlain];
    self.leftTableView.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    self.leftTableView.delegate = self;
    self.leftTableView.dataSource = self;
    self.leftTableView.bounces = NO;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorColor = [UIColor blueColor];
    [self.leftTableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:LEFT_CELLID];
    if ([self.leftTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.leftTableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    if ([_leftTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.leftTableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    [self addSubview:self.leftTableView];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:self.currentDate.month]];
    self.leftTableView.tableHeaderView = [LeftHeaderView createLeftHeaderView:LeftHeaderMonth title:[NSString stringWithFormat:@"%@月",string]];
    
    self.rightScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.leftTableView.frame.size.width, getHeight(46), SCREEN_WIDTH - getWidth(42), self.bounds.size.height - getHeight(46))];
    self.rightScrollView.contentSize = CGSizeMake((CELL_WIDTH + 1)* 7, self.leftTableView.frame.size.height);
    self.rightScrollView.bounces = NO;
    self.rightScrollView.showsVerticalScrollIndicator = NO;
    self.rightScrollView.showsHorizontalScrollIndicator = NO;
    self.rightScrollView.delegate = self;
    [self addSubview:self.rightScrollView];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 8, 1);
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, (CELL_WIDTH + 1) * 7, self.bounds.size.height - getHeight(46)) collectionViewLayout:flowLayout];
    self.rightCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.rightCollectionView.delegate = self;
    self.rightCollectionView.dataSource = self;
    self.rightCollectionView.backgroundColor = [UIColor colorWithHex:@"#EBEBF1"];
    [self.rightScrollView addSubview:self.rightCollectionView];
    [self.rightCollectionView registerClass:[RightCollectionViewCell class] forCellWithReuseIdentifier:RIGHT_CELLID];
    [self.rightCollectionView registerClass:[RightCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECTION_HEADER];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.rightCollectionView) {
        if (self.leftTableView.contentOffset.y != self.rightCollectionView.contentOffset.y) {
            self.leftTableView.contentOffset = CGPointMake(0, self.rightCollectionView.contentOffset.y);
        }
    } else if (scrollView == self.leftTableView) {
        if (self.rightCollectionView.contentOffset.y != self.leftTableView.contentOffset.y) {
            self.rightCollectionView.contentOffset = CGPointMake(self.rightCollectionView.contentOffset.x, self.leftTableView.contentOffset.y);
        }
    }
}

#pragma mark - TableViewDataSource && Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LEFT_CELLID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInteger:indexPath.section + 1]];
    cell.leftLabel.text = [NSString stringWithFormat:@"第%@节",string];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RightCollectionViewCell *cell = (RightCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:RIGHT_CELLID forIndexPath:indexPath];
    cell.courseLabel.text = @"";
    for (MyCourseModel *model in self.dateArray) {
        if (indexPath.row + 1 == [model.week intValue] &&
            indexPath.section + 1 == [model.numofday intValue]) {
            cell.courseLabel.text = [NSString stringWithFormat:@"%@\n%@\n%@",model.subject,model.clazz,model.teacherName];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (MyCourseModel *model in self.dateArray) {
        if (indexPath.row + 1 == [model.week intValue] &&
            indexPath.section + 1 == [model.numofday intValue]) {
            [TimesTableInterfaceRequest requestCourseInfo:courseInfoParam(model.courseId) success:^(id json) {
                PopTimeTablesView *popView = [[PopTimeTablesView alloc]initWithPopTimeTablesViewType:MyPopTimeTablesViewType InfoArray:json];
                [[UIApplication sharedApplication].keyWindow addSubview:popView];
            } failed:^(NSError *error) {}];
        }
    }
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(getWidth(66.5) * 7, getHeight(66));
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RightCollectionHeaderView *tempHeaderView = (RightCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECTION_HEADER forIndexPath:indexPath];
        [tempHeaderView createRightHeaderView:RightHeaderViewDayWeek];
        [tempHeaderView updateDate:[self.currentDate getCurrentWeekAllDate:@"dd"] currentWeek:self.currentDate.week];
        reusableView = tempHeaderView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
    }
    return reusableView;
}

#pragma mark - WeekViewDelegate
- (void)weekViewSelectedWithName:(NSString *)name {
    self.currentDate = [NSDate new];
    [self.dateArray removeAllObjects];
    if ([name isEqualToString:@"last"]) {
        self.currentDate = [self.currentDate lastWeek];
        NSArray *weeks = [self.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
        [TimesTableInterfaceRequest requestMyCouresList:myCourseParam([weeks firstObject], [weeks lastObject]) success:^(id json) {
            self.dateArray = json;
            [self.rightCollectionView reloadData];
        } failed:^(NSError *error) {}];
    }else if ([name isEqualToString:@"current"]) {
        NSArray *weeks = [self.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
        [TimesTableInterfaceRequest requestMyCouresList:myCourseParam([weeks firstObject], [weeks lastObject]) success:^(id json) {
            self.dateArray = json;
            [self.rightCollectionView reloadData];
        } failed:^(NSError *error) {}];
    }else if ([name isEqualToString:@"next"]) {
        self.currentDate = [self.currentDate nextWeek];
        NSArray *weeks = [self.currentDate getCurrentWeekAllDate:@"yyyy/MM/dd"];
        [TimesTableInterfaceRequest requestMyCouresList:myCourseParam([weeks firstObject], [weeks lastObject]) success:^(id json) {
            self.dateArray = json;
            [self.rightCollectionView reloadData];
            } failed:^(NSError *error) {}];
        }
}

@end
