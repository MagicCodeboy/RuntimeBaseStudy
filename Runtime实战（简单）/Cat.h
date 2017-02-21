//
//  Cat.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fish.h"
@interface Cat : NSObject
@property(nonatomic,copy) NSString * name;
@property(nonatomic,assign) double price;

//属性是一个对象
@property(nonatomic,strong) Fish * fish;
@end
