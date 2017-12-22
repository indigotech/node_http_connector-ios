//
//  TQAuthenticator.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import <Foundation/Foundation.h>
#import "TQAuthenticationStrategyProtocol.h"

@interface TQAuthenticator : NSObject

- (void) use: (id<TQAuthenticationStrategyProtocol>)authStrategy;
- (NSURLRequest *) getAuthenticatedRequest: (NSURLRequest *)request;

@end
