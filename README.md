# NetEase_Tag
仿网易的 添加删除栏目;(无移动动画)
![image](https://github.com/xiexy/NetEase_Tag/blob/master/screenshots/1.gif)

***
+ 解决上一个版本需要两个UICollectionView 的问题;

```
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
/*
    注意: deleteItemsAtIndexPaths insertItemsAtIndexPaths 重新请求
    - (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
    - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
    两个方法;所以必须要先改动数据源在删除或者增加; 否则异常!!! 弄了我一天的时间.....擦...
*/
}
```
