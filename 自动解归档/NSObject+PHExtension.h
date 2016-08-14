//
//  NSObject+PHExtension.h
//  自动解归档
//
//  Created by 123 on 16/8/14.
//  Copyright © 2016年 彭洪. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  分类使用方法:在需要归解档的对象中实现下面的方法即可
 *  

//设置需要忽略的属性
- (NSArray *)ignoredNames {
    return @[@"bone"];
}

// 在系统方法内来调用我们的方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
    [self decode:aDecoder];
 }
    return self;
}
 
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self encode:aCoder];
}
 */
@interface NSObject (PHExtension)

/**
 *  不需要被实现的属性名称
 *
 *  @return 数组
 */
- (NSArray *)ignoredNames;


/**
 *  实现归档方法
 *
 *  @param aCoder
 */
- (void)encode:(NSCoder *)aCoder;



/**
 *  实现解档方法
 *
 *  @param aDecoder
 */
- (void)decode:(NSCoder *)aDecoder;

@end
