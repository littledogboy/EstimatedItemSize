//
//  ViewController.m
//  EstimatedItemSize
//
//  Created by 吴书敏 on 16/10/16.
//  Copyright © 2016年 littledogboy. All rights reserved.
//

#import "ViewController.h"
#import "TestCell.h"

#define KTestCellIdentifier @"testCell"

#define URLString @"http://bangumi.bilibili.com/api/bangumi_recommend?access_key=a97c86bad48e821156213b9728ba3cec&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3910&cursor=0&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=a23ccdd20f2c2d9ae38bc52c5a5a3a5f&ts=1476273037"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *descArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(300, 180); // 测试estimatedItemSize
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    // register
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    UINib *cellNib = [UINib nibWithNibName:@"TestCell" bundle:[NSBundle mainBundle]];
    [_collectionView registerNib:cellNib forCellWithReuseIdentifier:KTestCellIdentifier];
    // Do any additional setup after loading the view, typically from a nib.
    [self request];
}


- (void)request {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:URLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
        NSArray *array = rootDic[@"result"];
        self.descArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            NSString *string = dic[@"desc"];
            [self.descArray addObject:string];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [dataTask resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.descArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KTestCellIdentifier forIndexPath:indexPath];
    cell.isHeightCalculated = false;
    cell.backgroundColor = [UIColor redColor];
    cell.descLabel.text = self.descArray[indexPath.item];
    
    return cell;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
