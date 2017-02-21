//
//  Book.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(nonatomic,copy) NSString * name;
@property(nonatomic,assign) double price;
@property(nonatomic,copy) NSString * publisher;
@end
