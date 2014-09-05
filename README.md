Swizzle
=======
####描述
实现了一个Objective-C语言`Method Swizzling`的框架，并使用该框架针对NSArray和NSMutableArray中的objectAtIndex:进行了下标安全检查的替换。
####使用
- 导入`NSObject+Swizzle.h`和`NSObject+Swizzle.m`到你的工程。
- 添加想要`Method Swizzling`方法的类的`Category`，例如：

```
@interface NSArray (Swizzle)
@end
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
```
####参考
- [JRSwizzle](https://github.com/rentzsch/jrswizzle)
- [AnimatedGIFImageSerialization](https://github.com/mattt/AnimatedGIFImageSerialization)

####License
Swizzle is distributed under the terms and conditions of the [MIT license](https://github.com/Joywii/Swizzle/blob/master/LICENSE).