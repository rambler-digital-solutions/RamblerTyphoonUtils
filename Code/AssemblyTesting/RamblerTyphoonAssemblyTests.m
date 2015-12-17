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
                  withProtocol:(Protocol *)targetProtocol {
    XCTAssertTrue([targetObject conformsToProtocol:targetProtocol]);
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies {
    [self verifyTargetDependency:targetObject
                       withClass:targetClass
           conformingToProtocols:nil
                    dependencies:dependencies];
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
         conformingToProtocols:(NSArray *)protocols {
    [self verifyTargetDependency:targetObject
                       withClass:targetClass
           conformingToProtocols:protocols
                    dependencies:nil];
}

- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
         conformingToProtocols:(NSArray *)protocols
                  dependencies:(NSArray *)dependencies {
    // Verifying the object class
    [self verifyTargetDependency:targetObject
                       withClass:targetClass];
    
    // Verifying object's conformance to protocols
    NSMutableArray *allProtocols = [[RamblerTyphoonAssemblyTestUtilities protocolsForHierarchyOfClass:targetClass] mutableCopy];
    for (NSString *protocolName in [allProtocols copy]) {
        if ([protocols containsObject:protocolName]) {
            Protocol *protocol = NSProtocolFromString(protocolName);
            [self verifyTargetDependency:targetObject withProtocol:protocol];
        }
    }

    // Filtering the properties of the class
    NSMutableDictionary *allProperties = [[RamblerTyphoonAssemblyTestUtilities propertiesForHierarchyOfClass:targetClass] mutableCopy];
    for (NSString *propertyName in [allProperties allKeys]) {
        if (![dependencies containsObject:propertyName] ) {
            [allProperties removeObjectForKey:propertyName];
        }
    }
    
    // Verifying dependencies
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
                NSString *protocolName = [dependencyExpectedType substringWithRange:NSMakeRange(1, dependencyExpectedType.length - 2)];
                Protocol *expectedProtocol = NSProtocolFromString(protocolName);
                XCTAssertTrue([dependencyObject conformsToProtocol:expectedProtocol], @"Свойство %@ объекта %@ не имплементирует протокол %@", propertyName, targetObject, protocolName);
                break;
            }
                
                // We don't verify blocks and primitive types
            default:
                break;
        }
    }
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