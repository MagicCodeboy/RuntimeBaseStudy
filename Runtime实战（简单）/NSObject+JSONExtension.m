//
//  NSObject+JSONExtension.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "NSObject+JSONExtension.h"
#import <objc/runtime.h>
@implementation NSObject (JSONExtension)
-(void)setDict:(NSDictionary *)dict{
    Class c = self.class;
    while (c && c != [NSObject class]) {
        unsigned int outCount = 0;
        Ivar * ivars = class_copyIvarList(c, &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //成员变量转为属性名（去掉下划线）
            key = [key substringFromIndex:1];
            //取出字典的值
            id value = dict[key];
            /*重点操作*/
            //如果模型属性数量大于键值对数量 模型属性会被赋值为nil而报错
            if (value==nil) {
                continue;
            }
            
            //获取成员变量的类型
            NSString * type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
            //如果属性是对象类型
            NSRange range = [type rangeOfString:@"@"];
            if (range.location != NSNotFound) {
                 //那么截取对象的名字（比如@"Dog",截取为Dog）
                type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
                //排除系统的对象类型
                if (![type hasPrefix:@"NS"]) {
                     //将对象名转换为对象的类型，将新的对象字典转模型（递归）
                    Class class = NSClassFromString(type);
                    value = [class objectWithDict:value];
                } else if ([type isEqualToString:@"NSArray"]){
                    //如果是数组类型 将数组中的每个模型进行字典转模型 先创建一个临时数组存放模型
                    NSArray * array = (NSArray *)value;
                    NSMutableArray * tempArray = [NSMutableArray array];
                    //获取到每个模型的类型
                    id class;
                    if ([self respondsToSelector:@selector(arrayObjectClass)]) {
                        NSString * classStr = [self arrayObjectClass];
                        class = NSClassFromString(classStr);
                    } else {
                        NSLog(@"数组内模型是未知类型");
                        return;
                    }
                    //将数组中的所有的模型进行字典转模型
                    for (int i = 0; i < array.count; i++) {
                            [tempArray addObject:[class objectWithDict:value[i]]];
                    }
                    value = tempArray;
                }
            }
            
            
            //将字典中的值设置到模型上
            [self setValue:value forKey:key];
            
        }
        free(ivars);
        c = [c superclass];
    }
}
+(instancetype)objectWithDict:(NSDictionary *)dict{
    NSObject * obj = [[self alloc]init];
    [obj setDict:dict];
    return obj;
}

@end
