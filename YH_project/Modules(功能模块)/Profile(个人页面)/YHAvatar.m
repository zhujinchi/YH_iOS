//
//  YHAvatar.m
//  YH_project
//  用户头像框
//  Created by Angzeng on 2018/5/16.
//  Copyright © 2018年 Angzeng. All rights reserved.
//

#import "YHAvatar.h"
#import "YHPeopleInfoPopView.h"
#import "UtilsMacros.h"
#import "FontAndColorMacros.h"
#import "SDWebImageManager.h"
#import "SDWebImageDownloader.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation YHAvatar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI {
    self.isShowInfo = YES;
    self.backgroundColor = YHColor_ChineseRed;
    self.layer.cornerRadius = self.frame.size.width/2;
    self.backgroundColor = [UIColor whiteColor];
    //
    self.AvatarImg = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.width-2, self.frame.size.height-2)];
    self.AvatarImg.contentMode = UIViewContentModeScaleAspectFill;
    self.AvatarImg.layer.cornerRadius = (self.frame.size.width-2)/2;
    self.AvatarImg.clipsToBounds = YES;
    
    [self addSubview:self.AvatarImg];
    //
    UITapGestureRecognizer *showInfo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showInfo)];
    [self addGestureRecognizer:showInfo];
}

- (void)setAvaterImgWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholder{
    [self.AvatarImg sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder];
}

//网络图片获取
- (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
//长方形图片处理
- (UIImage*)getSubImage:(UIImage *)image centerBool:(BOOL)centerBool{
    CGRect mCGRect;
    if (image.size.width >= image.size.height) {
        mCGRect = CGRectMake(0, 0, image.size.height, image.size.height);
    }else {
        mCGRect = CGRectMake(0, 0, image.size.width, image.size.width);
    }
    /*如若centerBool为Yes则是由中心点取mCGRect范围的图片*/
    float imgWidth = image.size.width;
    float imgHeight = image.size.height;
    float viewWidth = mCGRect.size.width;
    float viewHidth = mCGRect.size.height;
    CGRect rect;
    if(centerBool){
        rect = CGRectMake((imgWidth-viewWidth)/2,(imgHeight-viewHidth)/2,viewWidth,viewHidth);
    }else{
        if(viewHidth < viewWidth){
            if(imgWidth <= imgHeight){
                rect = CGRectMake(0, 0, imgWidth, imgWidth*imgHeight/viewWidth);
            }else{
                float width = viewWidth*imgHeight/viewHidth;
                float x = (imgWidth - width)/2;
                if(x > 0){
                    rect = CGRectMake(x, 0, width, imgHeight);
                }else{
                    rect = CGRectMake(0, 0, imgWidth, imgWidth*viewHidth/viewWidth);
                }
            }
        }else{
            if(imgWidth <= imgHeight){
                float height = viewHidth*imgWidth/viewWidth;
                if(height < imgHeight){
                    rect = CGRectMake(0,0, imgWidth, height);
                }else{
                    rect = CGRectMake(0,0, viewWidth*imgHeight/viewHidth,imgHeight);
                }
            }else{
                float width = viewWidth * imgHeight / viewHidth;
                if(width < imgWidth){
                    float x = (imgWidth - width)/2;
                    rect = CGRectMake(x,0,width, imgHeight);
                }else{
                    rect = CGRectMake(0,0,imgWidth, imgHeight);
                }
            }
        }
    }
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0,0,CGImageGetWidth(subImageRef),CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

//方形图片处理
- (UIImage *)circleImage:(UIImage*)image withParam:(CGFloat)inset {
    image = [self getSubImage:image centerBool:YES];
    //
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillPath(context);
    CGContextSetLineWidth(context, .5);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    
    CGContextClip(context);
    
    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

- (void)showInfo {
    if (self.isShowInfo == YES&&self.userId) {
        [YHPeopleInfoPopView initUserViewWithID:_userId];
    }
}

@end
