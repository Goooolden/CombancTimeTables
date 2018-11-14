//
//  AllTimetablesViewController.m
//  TimeTables
//
//  Created by Golden on 2018/10/9.
//  Copyright © 2018年 Combanc. All rights reserved.
//

#import "AllTimetablesView.h"
#import "LeftTableViewCell.h"
#import "RightCollectionViewCell.h"
#import "LeftHeaderView.h"
#import "RightCollectionHeaderView.h"
#import "UIColor+TimeTables.h"
#import "WeekView.h"
#import "PopTimeTablesView.h"
#import "TimeTablesDefine.h"

#define CELL_WIDTH  getWidth(163)
#define CELL_HEIGHT getHeight(110)

static NSString *const LEFT_CELLID = @"LEFT_CELLID";
static NSString *const RIGHT_CELLID = @"RIGHT_CELLID";
static NSString *const COLLECTION_HEADER = @"COLLECTION_HEADER";

@interface AllTimetablesView ()<
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

@end

@implementation AllTimetablesView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    WeekView *weekView = [WeekView creatWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, getHeight(46)) infoArray:@[@"1",@"3"]];
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
    self.leftTableView.tableHeaderView = [LeftHeaderView createLeftHeaderView:LeftHeaderSection title:@"节次"];
    
    self.rightScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.leftTableView.frame.size.width, getHeight(46), SCREEN_WIDTH - getWidth(42), self.bounds.size.height - getHeight(46))];
    self.rightScrollView.contentSize = CGSizeMake((CELL_WIDTH + 2) * 7, self.leftTableView.frame.size.height);
    self.rightScrollView.bounces = NO;
    self.rightScrollView.showsVerticalScrollIndicator = NO;
    self.rightScrollView.showsHorizontalScrollIndicator = NO;
    self.rightScrollView.delegate = self;
    [self addSubview:self.rightScrollView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 2, 2);
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, (CELL_WIDTH + 2) * 7, self.bounds.size.height - getHeight(46)) collectionViewLayout:flowLayout];
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
    cell.leftLabel.text = @"第一节";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
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
    return 2;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

#pragma mark - CollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RightCollectionViewCell *cell = (RightCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:RIGHT_CELLID forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PopTimeTablesView *popView = [[PopTimeTablesView alloc]initWithPopTimeTablesViewType:AllPopTimeTablesViewType InfoArray:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:popView];
}

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(CELL_WIDTH * 7, getHeight(60));
    }
    return CGSizeMake(0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RightCollectionHeaderView *tempHeaderView = (RightCollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:COLLECTION_HEADER forIndexPath:indexPath];
        [tempHeaderView createRightHeaderView:RightheaderviewMonthWeek];
        reusableView = tempHeaderView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
    }
    return reusableView;
}

- (void)weekViewSelectedWithName:(NSString *)name {
    
}

@end
