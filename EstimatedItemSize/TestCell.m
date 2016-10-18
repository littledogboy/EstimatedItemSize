//
//  TestCell.m
//  EstimatedItemSize
//
//  Created by 吴书敏 on 16/10/16.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#import "TestCell.h"
#import "Masonry.h"

@interface TestCell ()


@end

@implementation TestCell


- (void)awakeFromNib {
    [super awakeFromNib];
    __weak typeof(self) ws = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(@(0));
        make.width.mas_equalTo(@(300));
        make.bottom.mas_equalTo(ws.descLabel.mas_bottom).offset(12.0);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.mas_equalTo(ws.contentView);
        make.height.mas_equalTo(@(150));
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ws.imageView.mas_bottom).offset(10.0);
        make.left.width.mas_equalTo(ws.imageView);
        make.height.mas_greaterThanOrEqualTo(@(21)).priority(1000);
    }];
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];
    CGRect newFrame = layoutAttributes.frame;
    newFrame.size.height = size.height;
    layoutAttributes.frame = newFrame;
    return layoutAttributes;
}




@end
