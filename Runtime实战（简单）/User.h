//
//  User.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cat.h"
@interface User : NSObject
@property(nonatomic,copy) NSString * name;
@property(nonatomic,assign) double height;
@property(nonatomic,assign) int age;

//属性是一个对象
@property(nonatomic,strong) Cat *cat;
//属性是一个数组
@property(nonatomic,strong) NSArray * books;
@end
