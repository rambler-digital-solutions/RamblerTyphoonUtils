//
//  RamblerTyphoonAssemblyTests.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerTyphoonAssemblyTests.h"
#import "RamblerTyphoonAssemblyTestUtilities.h"

typedef NS_ENUM(NSInteger, RamblerPropertyType) {
    RamblerId,
    RamblerBlock,
    RamblerClass,
    RamblerProtocol,
    RamblerPrimitive
};

@implementation RamblerTyphoonAssemblyTests

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass {
    XCTAssertTrue([targetObject isKindOfClass:targetClass]);
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies {
    // Verifying the object class
    [self verifyTargetDependency:targetObject
                       withClass:targetClass];
    
    NSMutableDictionary *allProperties = [[RamblerTyphoonAssemblyTestUtilities propertiesForHierarchyOfClass:targetClass] mutableCopy];
    NSArray *propertyNames = [allProperties allKeys];
    
    // Verifying that target object has all needed dependencies
    for (NSString *propertyName in dependencies) {
        XCTAssertTrue([propertyNames containsObject:propertyName], @"For object %@ has not been found property %@", targetObject, propertyName);
    }
    
    // Filtering the properties of the class
    for (NSString *propertyName in propertyNames) {
        if (![dependencies containsObject:propertyName] ) {
            [allProperties removeObjectForKey:propertyName];
        }
    }
    
    [self verifyTargetObject:targetObject
                dependencies:allProperties];
}

- (void)verifyTargetObject:(id)targetObject
              dependencies:(NSDictionary *)dependencies {
    for (NSString *propertyName in dependencies) {
        NSString *dependencyExpectedType = dependencies[propertyName];
        RamblerPropertyType propertyType = [self propertyTypeByString:dependencyExpectedType];
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        id dependencyObject = [targetObject performSelector:NSSelectorFromString(propertyName)];
#pragma clang diagnostic pop
        
        switch (propertyType) {
            case RamblerId: {
                XCTAssertNotNil(dependencyObject, @"Свойство %@ объекта %@ не должно быть nil", propertyName, targetObject);
                break;
            }
                
            case RamblerClass: {
                Class expectedClass = NSClassFromString(dependencyExpectedType);
                XCTAssertTrue([dependencyObject isKindOfClass:expectedClass], @"Неверный класс свойства %@ объекта %@", propertyName, targetObject);
                break;
            }
                
            case RamblerProtocol: {
                NSString *protocolName = [self protocolNameByExpectedType:dependencyExpectedType];
                Protocol *expectedProtocol = NSProtocolFromString(protocolName);                XCTAssertTrue([dependencyObject conformsToProtocol:expectedProtocol], @"Свойство %@ объекта %@ не имплементирует протокол %@", propertyName, targetObject, protocolName);
                break;
            }
                
                // We don't verify blocks and primitive types
            default:
                break;
        }
    }
}

- (NSString *)protocolNameByExpectedType:(NSString *)type {
    NSRange   searchedRange = NSMakeRange(0, [type length]);
    NSString *pattern = @"<(.*?)>";
    NSError  *error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern
                                                                           options:0
                                                                             error:&error];
    NSTextCheckingResult *match = [regex firstMatchInString:type options:0 range:searchedRange];
    NSString *protocolName = [type substringWithRange:[match rangeAtIndex:1]];
    
    return protocolName;
}

- (RamblerPropertyType)propertyTypeByString:(NSString *)propertyTypeString {
    if ([propertyTypeString isEqualToString:@"?"]) {
        return RamblerBlock;
    }
    
    if ([propertyTypeString isEqualToString:@""]) {
        return RamblerPrimitive;
    }
    
    if ([propertyTypeString isEqualToString:@"id"]) {
        return RamblerId;
    }
    
    if ([propertyTypeString rangeOfString:@"<"].length != 0 ) {
        return RamblerProtocol;
    }
    
    return RamblerClass;
}


@end