//
//  NSObject+PHExtension.m
//  自动解归档
//
//  Created by 123 on 16/8/14.
//  Copyright © 2016年 彭洪. All rights reserved.
//

#import "NSObject+PHExtension.h"
#import <objc/runtime.h>


@implementation NSObject (PHExtension)

- (void)decode:(NSCoder *)aDecoder {
    //一层层父类往上找，对父类的属性执行归解档方法
    Class c = self.class;
    while (c && c != [NSObject class]) {
        
        unsigned int outCout = 0;
        Ivar * ivars = class_copyIvarList(c, &outCout);
        for (int i = 0; i < outCout; i++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
}


- (void)encode:(NSCoder *)aCoder {
    
    //一层层父类往上找 对父类的属性执行归解档方法
    Class c = self.class;
    
    while (c &&c != [NSObject class]) {
        
        unsigned int outCout = 0;
        Ivar * ivars = class_copyIvarList([self class], &outCout);
        
        for (int i=0; i <outCout; i++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            
            //如果有实现该方法再去调用
            if ([self respondsToSelector:@selector(ignoredNames)]) {
                if ([[self ignoredNames] containsObject:key]) continue;
            }
            
            id value = [self valueForKey:key];
            [aCoder encodeObject:value forKey:key];
        }
        free(ivars);
        c = [c superclass];
    }
}




























@end
