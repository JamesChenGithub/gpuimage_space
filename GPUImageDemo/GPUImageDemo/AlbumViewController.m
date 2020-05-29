//
//  AlbumViewController.m
//  GPUImageDemo
//
//  Created by AlexiChen on 2020/5/28.
//  Copyright © 2020 AlexiChen. All rights reserved.
//

#import "AlbumViewController.h"
#import "GPUFilterCell.h"
#import <GPUImage/GPUImage.h>

@interface AlbumViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) GPUImageFilter *selectedFilter;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIImageView *cpuImageView;
@property (nonatomic, weak) IBOutlet UIImageView *coreImageView;
@property (nonatomic, weak) IBOutlet UIImageView *gpuImageView;

@property (nonatomic, weak) IBOutlet UICollectionView *filterCollectionView;

@property (nonatomic, weak) IBOutlet UILabel *cpuLable;
@property (nonatomic, weak) IBOutlet UILabel *coreGraphLable;
@property (nonatomic, weak) IBOutlet UILabel *gpuImageLable;



@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onTakePhoto:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self; //设置代理
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片来源
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.image = image;
    self.sourceImage = image;
    //使用黑白素描滤镜
    GPUImageSketchFilter *disFilter = [[GPUImageSketchFilter alloc] init];
    //设置要渲染的区域
    [disFilter forceProcessingAtSize:image.size];
    [disFilter useNextFrameForImageCapture];
    //获取数据源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc]initWithImage:image];
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    self.gpuImageView.image = newImage;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"GPUFilterCell";
    GPUFilterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.filterName.text = [NSString stringWithFormat:@"Filter %ld",(long)indexPath.item];

    return cell;
}

@end
