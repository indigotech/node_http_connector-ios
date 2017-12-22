//
//  TQAuthenticationStrategyProtocol.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#ifndef Pods_TQAuthenticationStrategyProtocol_h
#define Pods_TQAuthenticationStrategyProtocol_h

@protocol TQAuthenticationStrategyProtocol

@required

- (NSURLRequest *)authenticateRequest:(NSURLRequest *)request;

@end

#endif
