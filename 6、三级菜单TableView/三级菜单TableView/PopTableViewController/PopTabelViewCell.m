//
//  PopTabelViewCell.m
//  三级菜单TableView
//
//  Created by mazg on 15/2/1.
//  Copyright (c) 2015年 mazg. All rights reserved.
//

#import "PopTabelViewCell.h"
#import "PopTableViewItem.h"
#import "PopTableViewDetail.h"



@implementation PopTabelViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(UIImageView *)openImageView{
    if (!_openImageView) {
        _openImageView =[[UIImageView alloc]init];
        _openImageView.image=[UIImage imageNamed:@"close.png"];
        [self.contentView addSubview:_openImageView];
    }
    _openImageView.frame=CGRectMake(10+self.indentationLevel*15, 12, 20, 20);
    return _openImageView;
}


-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        [self.contentView addSubview:_titleLabel];
    }
    _titleLabel.frame=CGRectMake(40+self.indentationLevel*15, 0, 80, 44);
    return _titleLabel;
}

-(UIButton *)checkButton{
    if (!_checkButton) {
        _checkButton=[[UIButton alloc]initWithFrame:CGRectMake(270, 0, 50, 44)];
        [_checkButton setTitle:@"未选" forState:UIControlStateNormal];
        [_checkButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_checkButton addTarget:self action:@selector(chooseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}


-(void)setContent:(id)value{
    [(PopTableViewItem *)value setIndentationLevel:0];//每次调用改方法初始化value的缩进值为0
    if ([value isKindOfClass:[PopTableViewItem class]]) {
        self.currentItem=value;
        self.indentationLevel=[value getIndentationLevel];//取得value计算后的缩进值
        self.titleLabel.text=[(PopTableViewItem *)value title];
        self.openImageView.hidden=NO;
        self.checkButton.hidden=NO;
        if ([(PopTableViewItem *)value isOpen]) {
            _openImageView.image=[UIImage imageNamed:@"open.png"];
        }
        else{
            _openImageView.image=[UIImage imageNamed:@"close.png"];
        }
    }
    else{
        self.indentationLevel=[value getIndentationLevel];
        self.openImageView.hidden=YES;
        self.titleLabel.text=[(PopTableViewDetail*)value title];
        self.checkButton.hidden=YES;
    }
}


-(void)chooseBtnClicked:(id)sender{
    self.currentItem.isSelected=!self.currentItem.isSelected;//点中选择按钮后改变isSelected属性
    [self.delegate batchControl:self.currentItem];//调用代理方法
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
