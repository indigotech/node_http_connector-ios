//
//  TQAuthenticationStrategyVersion.m
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import "TQAuthenticationStrategyVersion.h"

@implementation TQAuthenticationStrategyVersion {
    NSString *_version;
    NSString *_header;
}

- (instancetype) initWithVersion:(NSString *)version
                    customHeader:(NSString *)headers
{
    self = [self init];
    _version = version;
    _header = headers;
    return self;
}

- (instancetype) initWithVersion:(NSString *)version {
    return [self initWithVersion:version
                    customHeader:@"x-taqtile-com-app-version" // Default header defined by Edmar
            ];
}

- (NSURLRequest *) authenticateRequest:(NSURLRequest *)request {
    NSMutableURLRequest *mutableRequest = (NSMutableURLRequest *)request;
    [mutableRequest setValue:_version forHTTPHeaderField:_header];
    return (NSURLRequest *)mutableRequest;
}


@end
