//
//  PopTableViewDetail.h
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopTableViewDetail : NSObject

/*
 PopTableViewDetail:凡是界面上到最低层的数据都用本类管理。用本类进行封装。
 */

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) id father;//父级
@property(nonatomic,assign) int indentationLevel;//缩进值
@property(nonatomic,assign) BOOL isSelected;//是否被选中

-(NSInteger)getIndentationLevel;//获取缩紧值的方法

@end
