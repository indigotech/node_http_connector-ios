//
//  TQAuthenticator.m
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import "TQAuthenticator.h"

@implementation TQAuthenticator  {
    NSArray *_authStrategies;
}


- (void) use:(id<TQAuthenticationStrategyProtocol>)authStrategy {
    NSMutableArray *strategies = [NSMutableArray arrayWithArray:[self authStrategies]];
    [strategies addObject:authStrategy];
    _authStrategies = (NSArray *)strategies;
}

- (NSURLRequest *) getAuthenticatedRequest:(NSURLRequest *)request {
    for (id<TQAuthenticationStrategyProtocol> authStrategy in [self authStrategies]) {
        request = [authStrategy authenticateRequest:request];
    }
    return request;
}

# pragma mark - Lazy instantiations
- (NSArray *)authStrategies {
    if (!_authStrategies) _authStrategies = @[];
    return _authStrategies;
}

@end
