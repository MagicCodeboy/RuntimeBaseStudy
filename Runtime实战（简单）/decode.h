//
//  decode.h
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

//一句宏搞定解归档
#import "NSObject+Extension.h"


#define CodingImplementation \
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
if (self = [super init]) {\
[self decode:aDecoder];\
}\
return self;\
}\
\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
[self encode:aCoder];\
}
