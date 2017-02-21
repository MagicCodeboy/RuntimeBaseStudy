//
//  main.m
//  Runtime实战（简单）
//
//  Created by lalala on 17/2/15.
//  Copyright © 2017年 lsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyClass.h"
#import <objc/runtime.h>


int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        MyClass * myClass = [[MyClass alloc]init];
        unsigned int outCount = 0;
        Class  cls = myClass.class;
        //类名
        NSLog(@"class name is %s",class_getName(cls));
        
        //父类
        NSLog(@"super class name is %s",class_getName(class_getSuperclass(cls)));
        
        //是否是元类
        NSLog(@"MyClass is %@ a meta-class",(class_isMetaClass(cls)?@"":@"not"));
        
        Class meta_class = objc_getMetaClass(class_getName(cls));
        NSLog(@"%s meta-class is %s",class_getName(cls),class_getName(meta_class));
        
        //实例变量大小
        NSLog(@"instance size is %zu",class_getInstanceSize(cls));
        
        //成员变量
        Ivar * ivars = class_copyIvarList(cls, &outCount);
        for (int i=0; i<outCount; i++) {
            Ivar ivar = ivars[i];
            NSLog(@"instance variable's name is %s at index %d",ivar_getName(ivar),i);
        }
        free(ivars);
        //属性操作
        objc_property_t * properties = class_copyPropertyList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t propertie = properties[i];
            NSLog(@"property's name is %s",property_getName(propertie));
        }
        free(properties);
        
        objc_property_t array = class_getProperty(cls, "array");
        if (array != NULL) {
            NSLog(@"property %s",property_getName(array));
        }
        
        //方法操作
        Method * methods = class_copyMethodList(cls, &outCount);
        for (int i = 0 ; i < outCount ; i++) {
            Method method = methods[i];
            NSLog(@"method's signature: %s", method_getName(method));
        }
        free(methods);
        
        Method method1 = class_getInstanceMethod(cls, @selector(method1));
        if (method1 != NULL) {
            NSLog(@"method1 %s",method_getName(method1));
        }
        Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
        if (classMethod != NULL) {
            NSLog(@"class method %s",method_getName(classMethod));
        }
        
//        NSLog(@"MyClass is %@ responsd to selector:method3WithArg1:Arg2:",class_respondsToSelector(cls, @selector(meth))?@"":"not");
       
        IMP imp = class_getMethodImplementation(cls, @selector(method1));
        imp();
        
        
        //协议
        Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
        Protocol * protocol;
        for (int i = 0; i< outCount ; i++) {
//            protocol = (__bridge Protocol *)(properties[i]);
//            NSLog(@"protocol name %s",protocol_getName(protocol));
        }
       
//        Class clss = objc_allocateClassPair(myClass.class, "MySubClass", 0);
//        class_addMethod(clss, @selector(method1), IMP(imp_sub), "v@:");
        
        int numClasses;
        Class * classes = NULL;
        
        numClasses = objc_getClassList(NULL, 0);
        if (numClasses > 0) {
//            classes = malloc(sizeof(Class) * numClasses);
            numClasses = objc_getClassList(classes, numClasses);
            NSLog(@"number of classes :%d",numClasses);
            
//            for (int i = 0; i < numClasses; i++) {
//                if (classes) {
//                    Class cls = classes[i];
//                    NSLog(@"class name %s",class_getName(cls));
//                }
//            }
            free(classes);
        }
        
        int a[] = {1,2,3};
        NSLog(@"array encoding type %s",@encode(typeof(a)));
        
        SEL sel1 = @selector(method1);
        NSLog(@"sel :%p",sel1);//OC在编译时 会依据每一个方法的名字、参数序列 生成唯一的整形标识（int类型的地址）这个标识就是SEL
        
        //objc_msgSend 这个函数完成了动态绑定的所有的事情
        /*
            1、首先找到selector对应的方法的实现 因为同一个方法可能在不同的类中有不同的实现 所以我们需要依赖于接受者的类来找到确切的实现
            2、他调用方法实现 并将接受者对象及方法的所有的参数传给它
            3、最后 他将实现返回的值作为他自己的返回值
         */
        
        //查看methodForSelector的使用
//        void (*setter)(id,SEL,BOOL);
//        int i;
        
       
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
