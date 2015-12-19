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

#define CLGScreenSizebounds [UIScreen mainScreen].bounds
#define CLGScreenSize CLGScreenSizebounds.size

@interface ViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak,nonatomic) UICollectionView *topCollView;
@property (weak,nonatomic) UICollectionView *bottomCollView; 

/***  <#释义#> */
@property (strong,nonatomic) CLGInterestHeadGorup *topgroup;
@property (strong,nonatomic) CLGInterestHeadGorup *bottongroup;
/***  <#释义#> */
@property (assign,nonatomic) BOOL isEdit;
@end

@implementation ViewController

static NSString * const reuseID = @"reuseID";
static NSString * const reuseHeaderViewID = @"HeaderView";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.topgroup = [[CLGInterestHeadGorup alloc] init];
    self.bottongroup = [[CLGInterestHeadGorup alloc] init];
    
    [self initdata];
    [self initCollectionView]; 
}

- (void)initCollectionView
{
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = (CLGScreenSize.width -(2 * kEdgeInset.left) - (kColumn -1) * kMarginColumn  ) / kColumn;
    {
        //UICollectionViewFlowLayout 这里不能和下面的bottomCollView共用,否则更新数据出错
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize =CGSizeMake(width , kHeight);
        flowLayout.minimumLineSpacing = kMarginTop ;
        flowLayout.minimumInteritemSpacing = kMarginColumn ;
        self.topCollView = [self collectionView:flowLayout parentView:self.topView];
 
    }
    {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize =CGSizeMake(width , kHeight);
        flowLayout.minimumLineSpacing = kMarginTop ;
        flowLayout.minimumInteritemSpacing = kMarginColumn ;
        self.bottomCollView = [self collectionView:flowLayout parentView:self.bottomView];
    }
}
- (UICollectionView *)collectionView :(UICollectionViewFlowLayout *)flowLayout parentView:(UIView *)parentView
{
    CGRect screenRect = parentView.bounds;
    screenRect.size.width = CLGScreenSize.width;
    UICollectionView *CollView = [[UICollectionView alloc] initWithFrame:screenRect
                                                    collectionViewLayout:flowLayout];
    
    
    CollView.collectionViewLayout = flowLayout;
    CollView.pagingEnabled = NO;
    
    CollView.dataSource = self;
    CollView.delegate = self;
    CollView.backgroundColor =[UIColor orangeColor];
    
    [CollView registerNib:[UINib nibWithNibName:@"CLGInterestCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
    [CollView registerNib:[UINib nibWithNibName:@"CLGCollectionReusableHeadView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseHeaderViewID];
    [parentView addSubview:CollView];
    return CollView;
}

- (void)initdata
{
    __weak typeof (self)weakSelf = self;
    {
        CLGInterestHeadGorup *group = self.topgroup;
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
            
            [weakSelf.topCollView reloadData];
        }];
        [self  randomData:group count:0];
        
    }
    {
        CLGInterestHeadGorup *group = self.bottongroup;
        group.groupHeadTilte = @"推荐标签";
        group.groupRightTitle = @"换一组";
        group.items = [NSMutableArray array];
        [group setCallBack:^(CLGInterestHeadGorup *gp,UIButton *btn) {
            if(weakSelf.isEdit)return ;
            [gp.items removeAllObjects];
            [weakSelf randomData:gp count:0];
            [weakSelf.bottomCollView reloadData];
        }];
        [self  randomData:group count:0]; 
    }
}



- (void)randomData:(CLGInterestHeadGorup *)group count:(NSUInteger) count;
{
    // NSUInteger count = 1;
    count = arc4random_uniform(10);
    
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
//    if(collectionView == _topCollView)
//    {
//        return  1;
//    }
//    return 1;
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(collectionView == _topCollView)
    {
        return self.topgroup.items.count;
    }
    return self.bottongroup.items.count;
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CLGInterestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    if(collectionView == _topCollView)
    {
        
        cell.interestTag = self.topgroup.items[indexPath.row];
        return cell;
    }else
    {
        cell.interestTag =self.bottongroup.items[indexPath.row];
        return cell;
    }
    
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
    if(collectionView == _topCollView)
    {
      
        CLGInterestHeadGorup *group = self.topgroup;
        group.idxPath = indexPath;
        reusableView.group = group;
        return reusableView;
    }
    else
    {
        CLGInterestHeadGorup *group = self.bottongroup;
        group.idxPath = indexPath;
        reusableView.group = group;
        return reusableView;
    }
    
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
    NSLog(@"indexPath: %@",indexPath);
    if(self.isEdit)
    {
        if(collectionView == self.bottomCollView) return; 
        CLGInterestHeadGorup *group = self.topgroup;
        CLGInterestTag *tag =  group.items[indexPath.row];
        [group.items removeObject:tag];
        [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        CLGInterestHeadGorup *group2 = self.bottongroup;
        [tag setDeleteStaut:NO];
        [group2.items addObject:tag];
        [self.bottomCollView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:group2.items.count -1 inSection:0]]];

        
    }else{
        if(collectionView == self.bottomCollView)
        {
            CLGInterestHeadGorup *group = self.bottongroup;
            CLGInterestTag *tag =  group.items[indexPath.row];
            [tag setDeleteStaut:NO];
            [group.items removeObject:tag];
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
            
            CLGInterestHeadGorup *group2 = self.topgroup;
            [group2.items addObject:tag];
            
            [self.topCollView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:group2.items.count -1 inSection:0]]];
           
        }
    }
} 


@end
