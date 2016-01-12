//
//  RamblerAppDelegate.h
//  RamblerTyphoonUtils
//
//  Created by Egor Tolstoy on 11/15/2015.
//  Copyright (c) 2015 Egor Tolstoy. All rights reserved.
//

@import UIKit;

#import "RamblerFooProtocol.h"

@protocol RamblerBarProtocol;

@interface RamblerAppDelegate : UIResponder <UIApplicationDelegate, RamblerFooProtocol>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSString *injectedString;
@property (nonatomic, strong) id<RamblerBarProtocol, RamblerFooProtocol> injectedPropertyWithProtocols;

@end
