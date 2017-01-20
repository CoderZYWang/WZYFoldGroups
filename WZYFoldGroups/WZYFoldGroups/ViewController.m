//
//  ViewController.m
//  WZYFoldGroups
//
//  Created by 奔跑宝BPB on 2017/1/19.
//  Copyright © 2017年 wzy. All rights reserved.
//

#import "ViewController.h"

#import "WZYTestTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView; // 主展示 tableView
@property (nonatomic, strong) NSMutableArray *listArrM;  // 组内部cell的数据
@property (nonatomic, strong) NSMutableArray *titlesArrM;  // 分组的名称
@property (nonatomic, strong) NSMutableDictionary *openSectionDictM; // 记录哪个组展开

@end

static NSString *mainCellId = @"mainCellId";

@implementation ViewController

- (NSMutableArray *)listArrM {
    if (!_listArrM) {
        _listArrM = [NSMutableArray array];
    }
    return _listArrM;
}

- (NSMutableArray *)titlesArrM {
    if (!_titlesArrM) {
        _titlesArrM = [NSMutableArray array];
    }
    return _titlesArrM;
}

- (NSMutableDictionary *)openSectionDictM {
    if (!_openSectionDictM) {
        _openSectionDictM = [NSMutableDictionary dictionary];
    }
    return _openSectionDictM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 初始化tableView
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64 * 2) style:UITableViewStyleGrouped];
    _mainTableView = mainTableView;
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    [mainTableView registerNib:[UINib nibWithNibName:@"WZYTestTableViewCell" bundle:nil] forCellReuseIdentifier:mainCellId];
    [self.view addSubview:mainTableView];

    [self loadData];
}

/** 加载数据源 */
- (void)loadData {
    
    for (int i = 0; i < 3; i++) {  // 组
        [self.titlesArrM addObject:[NSString stringWithFormat:@"好友列表 %d", i + 1]];
    }
}
    
#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.openSectionDictM valueForKey:[NSString stringWithFormat:@"%ld", section]] integerValue] == 0) { //根据记录的展开状态设置row的数量
        return 0;
    } else {
        return 15;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WZYTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainCellId];
    
    [cell cellWithIconStr:[NSString stringWithFormat:@"cat_%ld", indexPath.row + 1] nameStr:[NSString stringWithFormat:@"cat_%ld", indexPath.row] statusStr:indexPath.row % 2 == 0 ? @"4G在线" : @"电脑在线" supStr:@"我是一只可爱的小猫咪 ..."];
    
    return cell;
}

#pragma mark - Table View Delegate
/** 行高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

/** 组头部高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

/** 组尾部高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2;
}

/** 组头部的数据源 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    // 组头部 底层大view
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.tag = section;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, view.bounds.size.width, view.bounds.size.height)];
    label.text = self.titlesArrM[section];
    [view addSubview:label];
    
    if ([[self.openSectionDictM valueForKey:[NSString stringWithFormat:@"%ld", section]] integerValue] == 0) {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (view.bounds.size.height - 10) / 2, 7, 10)];
        imageView.image = [UIImage imageNamed:@"Triangular_right"];
        [view addSubview:imageView];
    
    } else {
        //
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (view.bounds.size.height - 7) / 2, 10, 7)];
        imageView.image = [UIImage imageNamed:@"Triangular_up"];
        [view addSubview:imageView];
    }
    
    // 添加点击监听事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collegeTaped:)];
    [view addGestureRecognizer:tap];
    return view;
}

#pragma mark - Section Header Clicked
- (void)collegeTaped:(UITapGestureRecognizer *)sender {
    NSString *key = [NSString stringWithFormat:@"%ld", sender.view.tag];
    // 给展开标识赋值
    if ([[self.openSectionDictM objectForKey:key] integerValue] == 0) {
        [self.openSectionDictM setObject:@"1" forKey:key];
    } else {
        [self.openSectionDictM setObject:@"0" forKey:key];
    }
    NSUInteger index = sender.view.tag;
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
    [self.mainTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
