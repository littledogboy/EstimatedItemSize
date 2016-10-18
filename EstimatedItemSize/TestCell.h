//
//  TestCell.h
//  EstimatedItemSize
//
//  Created by 吴书敏 on 16/10/16.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isHeightCalculated;


@property (strong, nonatomic) IBOutlet UILabel *descLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end
