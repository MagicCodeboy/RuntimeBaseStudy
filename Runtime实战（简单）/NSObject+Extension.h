//
//  NSObject+Extension.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)
-(NSArray *)ignoredNames;
-(void)encode:(NSCoder *)aCoder;
-(void)decode:(NSCoder *)aCoder;
@end
