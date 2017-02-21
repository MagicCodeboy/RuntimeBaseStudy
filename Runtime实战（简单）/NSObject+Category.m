//
//  NSObject+Category.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>
@implementation NSObject (Category)
//重写set和get方法 内部利用runtime给属性赋值和取值
char namekey;
-(void)setName:(NSString *)name{
    //将某个值跟对象关联起来 将某个值存储到某个对象中
    objc_setAssociatedObject(self, &namekey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)name{
   return  objc_getAssociatedObject(self, &namekey);
}

@end
