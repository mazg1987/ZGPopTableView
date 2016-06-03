//
//  PopTableViewController.m
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import "PopTableViewController.h"
#import "PopTableViewItem.h"
#import "PopTabelViewCell.h"
#import "PopTableViewDetail.h"

@interface PopTableViewController ()<popTableViewCellDelegate>

@end

static NSString *identifier=@"PoptableViewCell";

@implementation PopTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath=[[NSBundle mainBundle]pathForResource:@"friends" ofType:@"plist"];
    NSArray *list=[[NSArray alloc]initWithContentsOfFile:filePath];
    [self loadIntialData:list];
    [self reloadShowIngData];
}

//把plist中内容加载到self.contentArr中
-(void)loadIntialData:(NSArray *)arr{
    for (NSDictionary *dic in arr) {
        PopTableViewItem *item=[[PopTableViewItem alloc]init];
        [item decodeValue:dic];
        [self.contentArr addObject:item];
    }
}

//加载页面显示内容的数据源
-(void)reloadShowIngData{
    [self.contentForShow removeAllObjects];
    [self reloadShowingDataFrom:self.contentArr to:self.contentForShow];
    [self.tableView reloadData];
}

//页面内容的数据源是从self.contentArr中加载的
-(void)reloadShowingDataFrom:(NSArray *)initialData to:(NSMutableArray *)contentForShow{
    //遍历数据源中的每一个item，将item添加到contentForShow数组。如果item的状态是打开的，则把item下面的sections数组中内容也添加到contentForShow数组中
    for (id item in initialData) {
        if ([item isKindOfClass:[PopTableViewItem class]]) {
            [contentForShow addObject:item];
            if (YES == [item isOpen]) {
                [self reloadShowingDataFrom:[(PopTableViewItem *)item setions] to:contentForShow];//递归继续添加数据
            }
        }
        else{
            [contentForShow addObject:item];
        }
    }
}

#pragma mark 延迟实列化
-(NSMutableArray *)contentArr{
    if (_contentArr==nil) {
        _contentArr=[[NSMutableArray alloc]init];
    }
    return _contentArr;
}

-(NSMutableArray *)contentForShow{
    if (_contentForShow==nil) {
        _contentForShow=[[NSMutableArray alloc]init];
    }
    return _contentForShow;
}

-(NSMutableArray *)selectedArr{
    if (!_selectedArr) {
        _selectedArr=[[NSMutableArray alloc]init];
    }
    return _selectedArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentForShow.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopTabelViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell=[[PopTabelViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.delegate=self;//指定cell代理为自己
    }
    [cell setContent:self.contentForShow[indexPath.row]];//给cell设置具体内容
    id item=self.contentForShow[indexPath.row];
    //如果item是PopTableViewItem类型
    if ([item isKindOfClass:[PopTableViewItem class]]) {
        cell.accessoryType=UITableViewCellAccessoryNone;//不需要打勾
        //如果该item已经被选中
        if ([(PopTableViewItem *)item isSelected]) {
            [cell.checkButton setTitle:@"已选" forState:UIControlStateNormal];
        }
        else{
            [cell.checkButton setTitle:@"未选" forState:UIControlStateNormal];
        }
    }
    //如果item是PopTableViewItem类型
    else{
        if ([(PopTableViewDetail *)item isSelected]) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;//打勾
        }
        else{
            cell.accessoryType=UITableViewCellAccessoryNone;//取消打勾
        }
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.contentForShow[indexPath.row] isKindOfClass:[PopTableViewItem class]]) {
        PopTableViewItem *item=self.contentForShow[indexPath.row];
        item.isOpen=!item.isOpen;//选中该行后，改变item的isOpen属性，用来控制子菜单打开关闭的状态
        [self reloadShowIngData];//重新加载数据源
    }
    else{
        PopTableViewDetail *detail=self.contentForShow[indexPath.row];
        detail.isSelected=!detail.isSelected;//选中该行后，改变isSelected属性，表示该detail信息是否被选中并添加到selectedArr数组
        if (detail.isSelected) {
            [self.selectedArr addObject:detail];
        }
        else{
            [self.selectedArr removeObject:detail];
        }
        [self changeFatherStatus:detail];//改变当前选中item父级的状态
        [tableView reloadData];
    }
}

#pragma mark cellDelegate －－点中cell里面选择按钮后执行的方法
-(void)batchControl:(PopTableViewItem *)item{
    if (item.isSelected) {
        [self selectedAllChildItemSections:item];//选中当前item的所有子菜单
    }
    else{
        [self noSelectedAllChildItemSections:item];//取消选中当前item的所有子菜单
    }
    [self changeFatherStatus:item];//刷新当前item父级的显示状态
    [self.tableView reloadData];
}


//选中当前item的所有子菜单
-(void)selectedAllChildItemSections:(PopTableViewItem *)item{
    for (id tmp in item.setions) {
        if ([tmp isKindOfClass:[PopTableViewItem class]]) {
            PopTableViewItem *tmpItem=tmp;
            tmpItem.isSelected=YES;
            [self selectedAllChildItemSections:tmpItem];//递归item下面的子级菜单
        }
        else{
            PopTableViewDetail *detail=tmp;
            detail.isSelected=YES;
            if (![self.selectedArr containsObject:detail]) {
                [self.selectedArr addObject:detail];
            }
        }
    }
}


//取消选中当前item的所有子菜单
-(void)noSelectedAllChildItemSections:(PopTableViewItem *)item{
    for (id tmp in item.setions) {
        if ([tmp isKindOfClass:[PopTableViewItem class]]) {
            PopTableViewItem *tmpItem=tmp;
            tmpItem.isSelected=NO;
            [self noSelectedAllChildItemSections:tmpItem];//递归item下面的子级菜单
        }
        else{
            PopTableViewDetail *detail=tmp;
            detail.isSelected=NO;
            if ([self.selectedArr containsObject:detail]) {
                [self.selectedArr removeObject:detail];
            }
        }
    }
}


//刷新当前item父级的显示状态
-(void)changeFatherStatus:(id)item{
    PopTableViewItem *father=[(PopTableViewItem *)item father];
    father.isSelected=YES;
    for (id child in father.setions) {
        if ([(PopTableViewItem *)child isSelected]==NO) {
            father.isSelected=NO;
            [self changeFatherStatus:father];//递归item的父级，父级的父级
        }
    }
}

@end
