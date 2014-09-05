//
//  NSObject+Swizzle.h
//  SohuStudu
//
//  Created by joywii on 14-9-5.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

/*
 * 描述 : 对实例方法进行method swizzling
 * 参数 : 
 *       originalSelector (想要替换的方法)
 *       swizzledSelector (实际替换为的方法)
 *       error            (替换过程中出现的错误，如果没有错误为nil)
 */
+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error;

/*
 * 描述 : 对类方法进行method swizzling
 * 参数 :
 *       originalSelector (想要替换的方法)
 *       swizzledSelector (实际替换为的方法)
 *       error            (替换过程中出现的错误，如果没有错误为nil)
 */
+ (BOOL)swizzleClassMethod:(SEL)originSelector withClassMethod:(SEL)swizzledSelector error:(NSError **)error;

@end

/*
 * 根据自己的需求进行method swizzling
 */
@interface NSArray (Swizzle)

@end
@interface NSMutableArray (Swizzle)

@end