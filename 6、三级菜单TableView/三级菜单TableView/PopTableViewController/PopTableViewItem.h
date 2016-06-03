//
//  PopTableViewItem.h
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopTableViewItem : NSObject

/*
 PopTableViewItem:凡是界面上可以被展开的内容都归为本类管理，比如本例子中的同学、高中同学、大学同学、小学同学，都属于能够被展开的数据，他们下面都有深一层的数据。用本类进行封装。
 */

@property(nonatomic,strong) NSString *title;//内容
@property(nonatomic,assign) BOOL isOpen;//当前item是否代开
@property(nonatomic,strong) id father;//当前item的父级是谁
@property(nonatomic,assign) int indentationLevel;//当前item的缩进值
@property(nonatomic,strong) NSMutableArray *setions;//当前item的子内容
@property(nonatomic,assign) BOOL isSelected;//当前item是否被选中

-(void)decodeValue:(NSDictionary *)dic;//用item解析数据源的方法

-(NSInteger)getIndentationLevel;//获取缩进数据的方法

@end
