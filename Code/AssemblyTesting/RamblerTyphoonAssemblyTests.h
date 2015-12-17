//
//  RamblerTyphoonAssemblyTests.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 12/09/15.
//  Copyright © 2015 Rambler&Co. All rights reserved.
//

#import <XCTest/XCTest.h>

#define RamblerSelector(x) NSStringFromSelector(@selector(x))
#define RamblerProtocol(x) NSStringFromProtocol(@protocol(x))

/**
 The base class for all of the TyphoonAssembly tests
 */
@interface RamblerTyphoonAssemblyTests : XCTestCase

/**
 Method for testing an object, created via TyphoonAssembly
 
 @param targetObject Created object
 @param targetClass  The target class
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass;

/**
 @author Aleksandr Sychev
 
 Method for testing an object, created via TyphoonAssembly, conforms to protocol
 
 @param targetObject   Created object
 @param targetProtocol The target protocol
 */
- (void)verifyTargetDependency:(id)targetObject
                  withProtocol:(Protocol *)targetProtocol;

/**
 Method for testing an object, created via TyphoonAssembly, and all of its dependencies
 
 @param targetDependency Created object
 @param targetClass      The target class
 @param dependencies     NSArray with dependencies names
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
                  dependencies:(NSArray *)dependencies;

/**
 @author Aleksandr Sychev
 
 Method for testing an object, created via TyphoonAssembly, and its protocol
 
 @param targetObject Created object
 @param targetClass  The target class
 @param protocols    NSArray with protocols names
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
         conformingToProtocols:(NSArray *)protocols;

/**
 @author Aleksandr Sychev
 
 Method for testing an object, created via TyphoonAssembly, its protocol and all of its dependencies
 
 @param targetObject Created object
 @param targetClass  The target class
 @param protocols    NSArray with protocols names
 @param dependencies NSArray with dependencies names
 */
- (void)verifyTargetDependency:(id)targetObject
                     withClass:(Class)targetClass
         conformingToProtocols:(NSArray *)protocols
                  dependencies:(NSArray *)dependencies;

@end
