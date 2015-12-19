//
//  ViewController.m
//  网易标签
//
//  Created by Xie Yong on 15/12/19.
//  Copyright © 2015年 Xie Yong. All rights reserved.
//

#import "ViewController.h"
#import "CLGInterestCollectionViewCell.h"
#import "CLGInterestHeadGorup.h"
#import "CLGCollectionReusableHeadView.h"
#define kMarginTop 20
#define kMarginColumn 34
#define kHeight 26
#define kColumn 4
#define kHeadViewHeight 30
#define kEdgeInset ((UIEdgeInsets){20,20,20,20})

#define CLGScreenbounds [UIScreen mainScreen].bounds
#define CLGScreenSize CLGScreenbounds.size

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak,nonatomic) UICollectionView *collView;
/***  数据集合 CLGInterestHeadGorup */
@property (strong,nonatomic) NSMutableArray *dataArray;

/***  <#释义#> */
@property (assign,nonatomic) BOOL isEdit;
@end

@implementation ViewController

static NSString * const reuseID = @"reuseID";
static NSString * const reuseHeaderViewID = @"HeaderView";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    [self initdata];
    [self initCollectionView];
}

- (void)initCollectionView
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = (CLGScreenSize.width -(2 * kEdgeInset.left) - (kColumn -1) * kMarginColumn  ) / kColumn;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize =CGSizeMake(width , kHeight);
    flowLayout.minimumLineSpacing = kMarginTop ;
    flowLayout.minimumInteritemSpacing = kMarginColumn ;
    
    
    CGRect screenRect =CLGScreenbounds;
    UICollectionView *cView = [[UICollectionView alloc] initWithFrame:screenRect
                                                 collectionViewLayout:flowLayout];
    
    
    cView.collectionViewLayout = flowLayout;
    cView.pagingEnabled = NO;
    
    cView.dataSource = self;
    cView.delegate = self;
    cView.backgroundColor =[UIColor orangeColor];
    
    [cView registerNib:[UINib nibWithNibName:@"CLGInterestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    [cView registerNib:[UINib nibWithNibName:@"CLGCollectionReusableHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderViewID];
    cView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.collView = cView;
    
    [self.view addSubview:cView];
    
    
}

- (void)initdata
{
    __weak typeof (self)weakSelf = self;
    {
        CLGInterestHeadGorup *group = [[CLGInterestHeadGorup alloc] init];
        group.items = [NSMutableArray array];
        group.groupHeadTilte = @"我的兴趣标签";
        group.groupRightTitle = @"编辑";
        [group setCallBack:^(CLGInterestHeadGorup *gp,UIButton *btn) {
            
            [gp.items enumerateObjectsUsingBlock:^(CLGInterestTag *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BOOL _isEidt = !obj.isDeleteStaut;
                [obj setDeleteStaut:_isEidt];
                
            }];
            weakSelf.isEdit = !weakSelf.isEdit;
            gp.groupRightTitle = [gp.groupRightTitle isEqualToString:@"编辑"] ? @"删除" : @"编辑";
            [btn setTitle:gp.groupRightTitle forState:UIControlStateNormal];
            
            [weakSelf.collView reloadData];
        }];
        [self randomData:group count:0];
        [self.dataArray addObject:group];
        
    }
    {
        CLGInterestHeadGorup *group = [[CLGInterestHeadGorup alloc] init];
        group.groupHeadTilte = @"推荐标签";
        group.groupRightTitle = @"换一组";
        group.items = [NSMutableArray array];
        [group setCallBack:^(CLGInterestHeadGorup *gp,UIButton *btn) {
            if(weakSelf.isEdit)return ;
            [gp.items removeAllObjects];
            [weakSelf randomData:gp count:0];
            [weakSelf.collView reloadData];
        }];
        [self  randomData:group count:0];
        [self.dataArray addObject:group];
    }
}



- (void)randomData:(CLGInterestHeadGorup *)group count:(NSUInteger) count;
{
    // NSUInteger count = 1;
    count = arc4random_uniform(10);
    if(count == 0) count = 10 ;
    for (NSUInteger i = 0 ; i< count; i++) {
        NSString *str = [NSString stringWithFormat:@"%ld",time(NULL)- arc4random_uniform(1000)];
        NSInteger start = str.length - 3;
        NSString *title = [str substringWithRange:NSMakeRange( start, str.length - start)];
        CLGInterestTag *tag = [CLGInterestTag interestTagWith:str interestTitle:title];
        [group.items addObject:tag];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UICollectionViewDataSource,UICollectionViewDelegate - 数据源,代理方法
#pragma mark 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    CLGInterestHeadGorup *group = self.dataArray[section];
    return group.items.count;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CLGInterestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    CLGInterestHeadGorup *group = self.dataArray[indexPath.section];
    cell.interestTag = group.items[indexPath.row];
    return cell;
    
}

/**
 *  分组头高度
 */
- (CGSize)collectionView:(UICollectionView * _Nonnull)collectionView
                  layout:(UICollectionViewLayout * _Nonnull)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CLGScreenSize.width, kHeadViewHeight);
}
/**
 *  分组头
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CLGCollectionReusableHeadView *reusableView =  [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseHeaderViewID forIndexPath:indexPath];
    CLGInterestHeadGorup *group = self.dataArray[indexPath.section];
    group.idxPath = indexPath;
    reusableView.group = group;
    return reusableView;
    
}
/**
 * 设置 collectionView 内边距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return kEdgeInset;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    注意: deleteItemsAtIndexPaths insertItemsAtIndexPaths 重新请求
    - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
     两个方法;所以必须要先改动数据源在删除或者增加; 否则异常!!! 弄了我一天的时间.....擦...
   */
    NSLog(@"indexPath: %@",indexPath);
    if (indexPath.section == 1)
    {
        if(self.isEdit)  return;
        
        CLGInterestHeadGorup *gp0 = self.dataArray[indexPath.section];
        CLGInterestTag *tag = gp0.items[indexPath.row];
        
        [gp0.items removeObject:tag];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        
        [tag setDeleteStaut:NO];
        CLGInterestHeadGorup *gp1 = self.dataArray[0];
        [gp1.items addObject:tag];
        NSIndexPath *addpath = [NSIndexPath indexPathForRow:gp1.items.count -1  inSection:0];
        [collectionView insertItemsAtIndexPaths:@[addpath]];
    
      
    }else
    {
        if(self.isEdit)
        {
            CLGInterestHeadGorup *gp0 = self.dataArray[indexPath.section];
            CLGInterestTag *tag = gp0.items[indexPath.row];
            
           [tag setDeleteStaut:NO];
            CLGInterestHeadGorup *gp1 = self.dataArray[1];
            [gp1.items addObject:tag];
            
            NSIndexPath *addpath = [NSIndexPath indexPathForRow:gp1.items.count -1  inSection:1];
            [collectionView insertItemsAtIndexPaths:@[addpath]];
            
            
            [gp0.items removeObject:tag];
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
        }
    }
}


@end
