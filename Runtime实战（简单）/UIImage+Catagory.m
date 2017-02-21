//
//  UIImage+Catagory.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "UIImage+Catagory.h"
#import <objc/runtime.h>
@implementation UIImage (Catagory)
+(void)load{
    Method m1 = class_getClassMethod([UIImage class], @selector(imageNamed:));
    Method m2 = class_getClassMethod([UIImage class], @selector(xh_imageNamed:));
    //交换两个方法的实现
    method_exchangeImplementations(m1, m2);
}
+(UIImage *)xh_imageNamed:(NSString *)name{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (version >= 7.0) {
         //如果系统是7.0以上的版本  使用另外一套文件名结尾是"_os7"的扁平化图片
        name = [name stringByAppendingString:@"_os7"];
    }
    return [UIImage xh_imageNamed:name];
}
@end
