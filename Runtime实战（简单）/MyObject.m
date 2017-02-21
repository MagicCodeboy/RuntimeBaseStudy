//
//  MyObject.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/17.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "MyObject.h"
#import <objc/runtime.h>
static NSMutableDictionary * map = nil;

@implementation MyObject

+(void)load{
    map = [NSMutableDictionary dictionary];
    
    map[@"name1"] = @"name";
    map[@"status1"] = @"status";
    map[@"name2"] = @"name";
    map[@"status2"] = @"status";
}

-(void)setDataWithDic:(NSDictionary *)dic{
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString * propretyKey = [self propertyForKey:key];
        if (propretyKey) {
            objc_property_t property = class_getProperty([self class], [propretyKey UTF8String]);
            
            //TODO：针对特殊数据类型做处理
            NSString * attrubuteString = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            
            [self setValue:obj forKey:propretyKey];
        }
    }];
    
//    if ([self methodForSelector:@selector(propertyForKey:)]) {
//        
//    }
}

-(NSString *)propertyForKey:(NSString *)key{
    return key;
}
@end
