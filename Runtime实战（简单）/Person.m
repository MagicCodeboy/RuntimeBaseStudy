//
//  Person.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>

@interface Person ()<NSCoding>

@end
@implementation Person
//设置不需要解档的属性
-(NSArray *)ignoredNames{
    return @[@"_aaa",@"_bbb",@"_ccc"];
}

//解档的方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        //获取所有的成员变量
        unsigned int outCount = 0;
        Ivar * ivars = class_copyIvarList([Person class], &outCount);
        
        //遍历所有的成员变量
        for (int i = 0; i < outCount; i++) {
             //取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            //将每个成员变量名转换为NSString对象类型
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            //忽略不需要解档的属性
            if ([[self ignoredNames] containsObject:key]) {
                continue;
            }
            //根据变量名解档取值 无论是什么类型
            id value = [aDecoder decodeObjectForKey:key];
            //取出的值再设置给属性
            [self setValue:value forKey:key];
             // 这两步就相当于以前的 self.age = [aDecoder decodeObjectForKey:@"_age"];
            
            //获得成员变量的名字
            const char * name = ivar_getName(ivar);
            //获取成员变量的类型
            const char * type = ivar_getTypeEncoding(ivar);
            NSLog(@"成员变量的名字%s  成员变量的类型%s",name,type);
        }
        //注意释放内存
        free(ivars);
        
    }
    return self;
}
//归档调用的方法
-(void)encodeWithCoder:(NSCoder *)aCoder{
    //获取所有的成员变量
    unsigned int outCount = 0;
    Ivar * ivars = class_copyIvarList([Person class], &outCount);
    
    for (int i=0; i<outCount; i++) {
         //取出i位置对应的成员变量
        Ivar ivar = ivars[i];
        
        //将每个成员变量名转换为NSString类型
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        //忽略不需要归档的属性
        if ([[self ignoredNames] containsObject:key]) {
            continue;
        }
        //通过成员变量名 取出成员变量的值
        id value = [self valueForKey:key];
        //再将值归档
        [aCoder encodeObject:value forKey:key];
        //这两部就相当于 [aCoder encodeObject:@(self.age) forkey:@"_age"]
        
    }
    //释放内存
    free(ivars);
}


+(void)run{
    NSLog(@"跑🏃");
}
+(void)study{
    NSLog(@"学习");
}
//关联对象 将一个Tap手势操作连接到任何的UIView中 并且根据需要制定点击后的实际操作
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerTapBlockKey;
-(void)setTapActionWithBlock:(void(^)(void))block{
    UITapGestureRecognizer * gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
-(void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture{
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        if (action) {
            action();
        }
    }
}

@end
