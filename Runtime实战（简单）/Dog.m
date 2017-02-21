//
//  Dog.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "Dog.h"
#import "NSObject+Extension.h"

@interface Dog ()<NSCoding>

@end

@implementation Dog

//设置需要忽略的属性
-(NSArray *)ignoredNames{
    return @[@"bone"];
}
//在系统的方法内部调用我们的方法
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        [self decode:aDecoder];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [self encode:aCoder];
}
@end
