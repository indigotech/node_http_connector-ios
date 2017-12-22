//
//  TQAuthenticationStrategyJWT.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import <Foundation/Foundation.h>
#import "TQAuthenticationStrategyProtocol.h"

@interface TQAuthenticationStrategyJWT : NSObject <TQAuthenticationStrategyProtocol>

- (instancetype) initWithJWTSecret:(NSString *)secret expirationTime:(int)expirationTime;
- (instancetype) initWithJWTSecret:(NSString *)secret;

@end
