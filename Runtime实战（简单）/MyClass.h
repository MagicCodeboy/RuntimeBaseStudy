//
//  MyClass.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/16.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
//测试runtime的函数的实例效果
@interface MyClass : NSObject<NSCopying,NSCoding>

@property(nonatomic,strong) NSArray * array;

@property(nonatomic,copy) NSString * string;

-(void)method1;

-(void)method2;

+(void)classMethod1;

@end
