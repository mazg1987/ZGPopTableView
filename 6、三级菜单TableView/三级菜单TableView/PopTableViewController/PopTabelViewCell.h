//
//  PopTabelViewCell.h
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopTableViewItem.h"
@protocol popTableViewCellDelegate<NSObject>
-(void)batchControl:(PopTableViewItem *)item;//点击选择按钮执行的代理方法
@end


@interface PopTabelViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *openImageView;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *checkButton;

@property(nonatomic,assign)NSInteger indentationLevel;//cell的缩进值

@property(nonatomic,strong)PopTableViewItem *currentItem;//当前cell的数据源

@property(nonatomic,weak)id<popTableViewCellDelegate>delegate;

-(void)setContent:(id)value;//设置cell数据的方法

@end
