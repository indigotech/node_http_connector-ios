//
//  TQAuthenticationStrategyVersion.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import <Foundation/Foundation.h>
#import "TQAuthenticationStrategyProtocol.h"

@interface TQAuthenticationStrategyVersion : NSObject <TQAuthenticationStrategyProtocol>

- (instancetype) initWithVersion: (NSString *)version customHeader: (NSString *)headers;
- (instancetype) initWithVersion: (NSString *)version;

@end
