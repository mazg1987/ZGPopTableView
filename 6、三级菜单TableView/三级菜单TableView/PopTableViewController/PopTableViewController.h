//
//  PopTableViewController.h
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTableViewController : UITableViewController

@property(nonatomic,strong)NSMutableArray *contentArr;//plist中内容转换为对象后存放在改数组中
@property(nonatomic,strong)NSMutableArray *contentForShow;//显示当前页面内容的数组
@property(nonatomic,strong)NSMutableArray *selectedArr;//所选中的数据存放的数组

@end
