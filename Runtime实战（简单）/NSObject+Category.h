//
//  NSObject+Category.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>
//这个是实现关联对象的
/*
    在分类中是无法设置属性的 如果在分类的声明中写@property 只能为其生成set和get方法的声明  但是无法生成成员变量  就是虽然点语法能够调用出来 但是程序执行后会crash 如果用全局变量的话（全局变量在整个程序的执行过程中只有一份，我们创建的多个对象修改其属性值都会修改同一个变量，这样就没有办法保证像属性一样，每个对象都有自己的属性值） 这时候就要借助runtime为分类增加属性的功能了
 */
@interface NSObject (Category)
@property(nonatomic,copy) NSString * name;//首先声明出get和set方法 方便点语法调用
@end
