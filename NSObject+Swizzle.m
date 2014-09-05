//
//  NSObject+Swizzle.m
//  SohuStudu
//
//  Created by joywii on 14-9-5.
//  Copyright (c) 2014年 sohu. All rights reserved.
//

#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
#import <objc/message.h>

static inline void StaticSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)))
    {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSObject (Swizzle)

+ (BOOL)swizzleMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector error:(NSError **)error
{
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    if (!originalMethod)
    {
        NSString *errStr = [NSString stringWithFormat:@"Swizzle : Original method %@ not found for class %@",NSStringFromSelector(originalSelector),NSStringFromClass([self class])];
		*error = [NSError errorWithDomain:@"NSCocoaErrorDomain"
                                     code:-1
                                 userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (!swizzledMethod)
    {
        NSString *errStr = [NSString stringWithFormat:@"Swizzle : Swizzled method %@ not found for class %@",NSStringFromSelector(swizzledSelector),NSStringFromClass([self class])];
		*error = [NSError errorWithDomain:@"NSCocoaErrorDomain"
                                     code:-1
                                 userInfo:[NSDictionary dictionaryWithObject:errStr forKey:NSLocalizedDescriptionKey]];
        return NO;
    }
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod)))
    {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    return YES;
}
+ (BOOL)swizzleClassMethod:(SEL)originSelector withClassMethod:(SEL)swizzledSelector error:(NSError **)error
{
    Class classInstance = object_getClass(self);
    return [classInstance swizzleMethod:originSelector withMethod:swizzledSelector error:error];
}

@end

/*
 * 描述 : 实现了NSArray和NSMutableArray的objectAtIndex:的安全检查的替换
 */
@implementation NSArray (Swizzle)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        @autoreleasepool
        {
            NSError *swizzleError;
            [objc_getClass("__NSArrayI") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:) error:&swizzleError];
            if (swizzleError)
            {
                NSLog(@"%@",swizzleError);
            }
        };
    });
}
- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}
@end

@implementation NSMutableArray (Swizzle)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        @autoreleasepool
        {
            NSError *swizzleError;
            [objc_getClass("__NSArrayM") swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safe_objectAtIndex:) error:&swizzleError];
            if (swizzleError)
            {
                NSLog(@"%@",swizzleError);
            }
        };
    });
}
- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

@end
