//
//  RamblerTyphoonAssemblyTestUtilities.m
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import "RamblerTyphoonAssemblyTestUtilities.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation RamblerTyphoonAssemblyTestUtilities

+ (NSDictionary *)propertiesForHierarchyOfClass:(Class)objectClass {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [self propertiesForHierarchyOfClass:objectClass
                           onDictionary:properties];
    return [NSDictionary dictionaryWithDictionary:properties];
}

+ (NSDictionary *)propertiesOfClass:(Class)objectClass {
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    return [self propertiesForSubclass:objectClass
                          onDictionary:properties];
}

+ (NSArray *)protocolsForHierarchyOfClass:(Class)objectClass {
    NSMutableArray *protocols = [NSMutableArray new];
    [self protocolsForHierarchyOfClass:objectClass
                               onArray:protocols];
    return [protocols copy];
}

+ (NSArray *)protocolsOfClass:(Class)objectClass {
    NSMutableArray *protocols = [NSMutableArray new];
    [self protocolsForClass:objectClass onArray:protocols];
    return [protocols copy];
}

+ (NSMutableDictionary *)propertiesForHierarchyOfClass:(Class)class
                                          onDictionary:(NSMutableDictionary *)properties {
    if (class == [NSObject class]) {
        return properties;
    }

    [self propertiesForSubclass:class
                   onDictionary:properties];

    return [self propertiesForHierarchyOfClass:[class superclass]
                                  onDictionary:properties];
}

+ (NSMutableDictionary *)propertiesForSubclass:(Class)class
                                  onDictionary:(NSMutableDictionary *)properties {
    unsigned int outCount, i;
    objc_property_t *objcProperties = class_copyPropertyList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = objcProperties[i];
        const char *propName = property_getName(property);
        if(propName) {
            const char *propType = getPropertyType(property);
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            [properties setObject:propertyType forKey:propertyName];
        }
    }
    free(objcProperties);
    
    return properties;
}

+ (NSMutableArray *)protocolsForHierarchyOfClass:(Class)class
                                         onArray:(NSMutableArray *)protocols {
    [self protocolsForClass:class
                    onArray:protocols];
    
    if (class == [NSObject class]) {
        return protocols;
    }
    
    return [self protocolsForHierarchyOfClass:[class superclass]
                                  onArray:protocols];
}

+ (NSMutableArray *)protocolsForClass:(Class)class
                              onArray:(NSMutableArray *)protocols {
    unsigned int outCount, i;
    Protocol * __unsafe_unretained *objcProtocols = class_copyProtocolList(class, &outCount);
    for (i = 0; i < outCount; i++) {
        Protocol *protocol = objcProtocols[i];
        const char *protocolName = protocol_getName(protocol);
        if (protocolName) {
            NSString *protocolStringName = [NSString stringWithUTF8String:protocolName];
            [protocols addObject:protocolStringName];
        }
    }
    free(objcProtocols);
    
    return protocols;
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // Primitive types
            return "";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // id type
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            NSString *name;
            if (attribute[2] == '?') {
                // Blocks
                name = [[NSString alloc] initWithBytes:attribute + 2 length:1 encoding:NSASCIIStringEncoding];
            } else {
                // Other classes
                name = [[NSString alloc] initWithBytes:attribute + 3 length:strlen(attribute) - 4 encoding:NSASCIIStringEncoding];
            }
            return (const char *)[name cStringUsingEncoding:NSASCIIStringEncoding];
        }
    }
    return "";
}

@end