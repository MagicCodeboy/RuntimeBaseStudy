//
//  ViewController.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "User.h"
#import "NSObject+JSONExtension.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController
void functionForMethod1(id self,SEL _cmd){
    NSLog(@"%@,%p",self,_cmd);
}
//动态方法解析
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSString * selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"method1"]) {
        class_addMethod(self.class, @selector(methodForSelector:), (IMP)functionForMethod1, "@:");
    }
    
    return [super resolveInstanceMethod:sel];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    /*
        @下面的几个方法实现了方法的交换
         //获取类方法使用 getclassMethod 获取实例方法使用getinstanceMethod
         Method m1 = class_getClassMethod([Person class], @selector(run));
         Method m2 = class_getClassMethod([Person class], @selector(study));
         //开始交换方法的实现
         method_exchangeImplementations(m1, m2);
     */
    
    
    [Person run];
    [Person study];
    
    [self jsonToModel];
    [self archiver];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSLog(@"获取指定类所在的动态库");
    NSLog(@"UIView's Framework :%s",class_getImageName(NSClassFromString(@"UIView")));
    
    //获取指定库或框架中所有类的类名
    unsigned int outCount;
    const char ** classes = objc_copyClassNamesForImage(class_getImageName(NSClassFromString(@"UIView")), &outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"class name:%s",classes[i]);
    }
    free(classes);
}
//字典转模型
-(void)jsonToModel{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"model" ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    User * user = [User objectWithDict:json];
    Book * book = user.books[0];
    NSLog(@"%@  %@",book.name,user.name);
    
}

//解归档demo
-(void)archiver{
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"temp.plist"];
    
//    Person * person = [[Person alloc]init];
//    
//    //归档
//    person.name = @"好人";
//    [NSKeyedArchiver archiveRootObject:person toFile:path];
    
//    解档
    Person * person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    NSLog(@"%@",person.name);
    
    NSLog(@"%@",path);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
