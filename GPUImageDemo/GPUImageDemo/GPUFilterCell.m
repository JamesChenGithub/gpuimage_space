//
//  GPUFilterCell.m
//  GPUImageDemo
//
//  Created by AlexiChen on 2020/5/29.
//  Copyright © 2020 AlexiChen. All rights reserved.
//

#import "GPUFilterCell.h"

@implementation GPUFilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGFloat hue = arc4random() % 256 / 256.0; //色调随机:0.0 ~ 1.0
        CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //饱和随机:0.5 ~ 1.0
        CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //亮度随机:0.5 ~ 1.0
        self.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    CGFloat hue = arc4random() % 256 / 256.0; //色调随机:0.0 ~ 1.0
    CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5; //饱和随机:0.5 ~ 1.0
    CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5; //亮度随机:0.5 ~ 1.0
    self.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

@end
