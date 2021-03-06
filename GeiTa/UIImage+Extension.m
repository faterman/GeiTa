//
//  UIImage+Extension.m
//  LaShouMovie
//
//  Created by LiXiangYu on 13-8-30.
//  Copyright (c) 2013年 LiXiangYu. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

static BOOL isRetina=NO;
+ (void)setIsRetina
{
    isRetina=[UIScreen instancesRespondToSelector:@selector(currentMode)]?CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size):NO;
}

+ (UIImage*)lsImageNamed:(NSString*)name
{
    NSString* path=nil;
    if([name rangeOfString:@".png"].location!=NSNotFound)
    {
        path=[[name substringToIndex:name.length-4] stringByAppendingString:(isRetina?@"@2x":@"")];
        //NSLog(@"%@",path);
    }
    else
    {
        path=[name stringByAppendingString:(isRetina?@"@2x":@"")];
    }
    path=[[NSBundle mainBundle] pathForResource:path ofType:@"png"];
    return [UIImage  imageWithContentsOfFile:path];
}

+ (UIImage *)stretchableImageWithImage:(UIImage *)image top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    if(image)
    {
        if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
        {
            return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
        }
        else
        {
            return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
        }
    }
    return nil;
}

@end
