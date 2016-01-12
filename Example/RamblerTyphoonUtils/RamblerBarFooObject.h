//
//  RamblerBarFooObject.h
//  RamblerTyphoonUtils
//
//  Created by Aleksandr Sychev on 11.01.16.
//  Copyright © 2016 Egor Tolstoy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RamblerBarProtocol.h"
#import "RamblerFooProtocol.h"

@interface RamblerBarFooObject : NSObject <RamblerBarProtocol, RamblerFooProtocol>
@end
