//
//  PopTableViewDetail.m
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import "PopTableViewDetail.h"
#import "PopTableViewItem.h"

@implementation PopTableViewDetail


-(NSInteger)getIndentationLevel{
    PopTableViewItem *father=self.father;
    //有多少个父级就调用该方法多少次
    while (father) {
       self.indentationLevel++;
       father=father.father;
    }
    return self.indentationLevel;
}

@end
