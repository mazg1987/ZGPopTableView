//
//  PopTableViewItem.m
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import "PopTableViewItem.h"
#import "PopTableViewDetail.h"

@implementation PopTableViewItem

-(NSArray *)setions{
    if (_setions==nil) {
        _setions=[[NSMutableArray alloc]init];
    }
    return _setions;
}

//解析数据源
-(void)decodeValue:(NSDictionary *)dic{
    self.title=[dic objectForKey:@"name"];
    self.isOpen=NO;
    self.isSelected=NO;
    NSArray *contents=[dic objectForKey:@"data"];
    if ([contents[0] isKindOfClass:[NSDictionary class]]) {
        for (NSDictionary *tmpDic in contents) {
            PopTableViewItem *item=[[PopTableViewItem alloc]init];
            item.title=[tmpDic objectForKey:@"name"];
            item.isOpen=NO;
            item.father=self;
            item.isSelected=NO;
            [self.setions addObject:item];
            [item decodeValue:tmpDic];//递归继续解析
        }
    }
    else{
        for (NSString *str in contents) {
            PopTableViewDetail *detail=[[PopTableViewDetail alloc]init];
            detail.title=str;
            detail.father=self;
            detail.isSelected=NO;
            [self.setions addObject:detail];
        }
    }
}

-(NSInteger)getIndentationLevel{
    PopTableViewItem *father=self.father;
    //有多少个父级，_indentationLevel就加多少次
    while (father) {
        _indentationLevel++;
        father=father.father;
    }
    return _indentationLevel;
}

@end
