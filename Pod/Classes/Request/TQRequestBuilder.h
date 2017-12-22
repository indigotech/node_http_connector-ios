//
//  TQRequestBuilder.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import <Foundation/Foundation.h>
#import "TQRequest.h"
#import "TQAuthenticationStrategyProtocol.h"

@interface TQRequestBuilder : NSObject

- (instancetype) initWithHostName:(NSString *)hostName;

- (TQRequest *) getWithPath:(NSString *)path
                       headers:(NSDictionary *)headers
                        params:(NSDictionary *)params;

- (TQRequest *) postWithPath:(NSString *)path
                        headers:(NSDictionary *)headers
                           body:(NSDictionary *)body;

- (TQRequest *) putWithPath:(NSString *)path
                    headers:(NSDictionary *)headers
                       body:(NSDictionary *)body;

- (TQRequest *) deleteWithPath:(NSString *)path
                       headers:(NSDictionary *)headers
                          body:(NSDictionary *)body;

- (TQRequest *) patchWithPath:(NSString *)path
                      headers:(NSDictionary *)headers
                         body:(NSDictionary *)body;

- (void) use: (id<TQAuthenticationStrategyProtocol>)authStrategy;

@end
