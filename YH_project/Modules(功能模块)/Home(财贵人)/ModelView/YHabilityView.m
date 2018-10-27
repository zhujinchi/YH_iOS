//
//  YHabilityView.m
//  YH_project
//
//  Created by Angzeng on 2018/8/17.
//  Copyright © 2018 Angzeng. All rights reserved.
//

#import "YHabilityView.h"
#import "FontAndColorMacros.h"
#import "UtilsMacros.h"

#define PI 3.14159265358979323846

@interface YHabilityView()

@property(nonatomic,strong)NSArray *ability;
@property(nonatomic,readwrite)UIEdgeInsets edgeInset;

@end

@implementation YHabilityView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.ability = @[@"成长",@"财值",@"情智",@"信念",@"工具"];
        self.edgeInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //绘制五角形
    CGPoint aPoint[6],bPoint[6],cPoint[2];
    CGFloat degree,present;
    CGFloat height = 10*FontPx;
    CGFloat max_length = self.frame.size.height;
    CGFloat length = (max_length-2*height)/(1+sin(PI*54/180));
    CGPoint CenterPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    length = (self.frame.size.width-2*height)/(cos(PI*26/180))<length?(self.frame.size.width-2*height)/(cos(PI*26/180)):length;
    CGFloat maxY = 0.0, minY = self.frame.size.height;
    
    cPoint[0] = CGPointMake(CenterPoint.x, CenterPoint.y);
    CGContextSetLineWidth(context, 0.6);
    [[UIColor grayColor] setStroke];
    for (NSInteger i = 0;i < 5;i++){
        degree = (72*fmod(i,5)/180 + 1)*PI;
        present = [self.capacity[i] floatValue]/10;
        if (present>1.0) {
            present = 1.0;
        }
        if (present<0.0) {
            present = 0.0;
        }
        cPoint[1] = CGPointMake(CenterPoint.x+length*sin(degree), CenterPoint.y+length*cos(degree));
        aPoint[i] = cPoint[1];
        bPoint[i] = CGPointMake(CenterPoint.x+length*sin(degree)*present, CenterPoint.y+length*cos(degree)*present);
        if (maxY < cPoint[1].y) {
            maxY = cPoint[1].y;
        }
        if (minY > cPoint[1].y) {
            minY = cPoint[1].y;
        }
        CGContextAddLines(context, cPoint, 2);
        CGContextDrawPath(context, kCGPathStroke);
        UILabel *abil = [[UILabel alloc] init];//能力标签
        abil.text = self.ability[i];
        abil.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.8];
        abil.layer.cornerRadius = 3;
        abil.clipsToBounds = YES;
        abil.font = [UIFont fontWithName:YHFont size:8*FontPx];
        abil.textColor = YHColor_Black;
        abil.textAlignment = NSTextAlignmentCenter;
//        UILabel *data = [[UILabel alloc] init];//能力标签
//        data.text = [NSString stringWithFormat:@"%0.2f",4.36];
//        data.font = [UIFont fontWithName:@"STHeitiTC-Light" size:8.0f];
//        data.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                [abil setFrame:CGRectMake(cPoint[1].x-height, cPoint[1].y-1, 2*height, -1.2*height)];
                //[data setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height, -height)];
                break;
            case 1:
                [abil setFrame:CGRectMake(cPoint[1].x, cPoint[1].y, -2*height, -1.2*height)];
                //[data setFrame:CGRectMake(cPoint[1].x, cPoint[1].y, -2*height,  height)];
                break;
            case 2:
                [abil setFrame:CGRectMake(cPoint[1].x, cPoint[1].y, -2*height,  1.2*height)];
                //[data setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height,  height)];
                break;
            case 3:
                [abil setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height,  1.2*height)];
                //[data setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height,  height)];
                break;
            case 4:
                [abil setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height, -1.2*height)];
                //[data setFrame:CGRectMake(cPoint[1].x, cPoint[1].y,  2*height,  height)];
                break;
            default:
                [abil setFrame:CGRectZero];
                break;
        }
        [self addSubview:abil];
        //[self addSubview:data];
    }
    aPoint[5] = aPoint[0];
    bPoint[5] = bPoint[0];
    CGContextSetLineWidth(context, 1.6);
    [YHColor_Black setStroke];
    [YHColor_Black setFill];
    CGContextAddLines(context, aPoint, 6);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetLineWidth(context, 0.1);
    [[UIColor clearColor] setStroke];
    [YHColor_ChineseRed setFill];
    CGContextAddLines(context, bPoint, 6);
    CGContextDrawPath(context, kCGPathFillStroke);
    
}


@end
