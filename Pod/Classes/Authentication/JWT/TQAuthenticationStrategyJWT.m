//
//  TQAuthenticationStrategyJWT.m
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import "TQAuthenticationStrategyJWT.h"
#import "JWTSigner.h"

@implementation TQAuthenticationStrategyJWT {

    int _expirationTime;
    JWTSigner *_signer;
    
}

- (instancetype) initWithJWTSecret:(NSString *)secret expirationTime:(int)expirationTime {
    self = [self init];
    _signer = [[JWTSigner alloc] initWithSecret:secret];
    _expirationTime = expirationTime;
    return self;
}

- (instancetype) initWithJWTSecret:(NSString *)secret {
    return [self initWithJWTSecret:secret
                    expirationTime:20 // Default value defined by Edmar
            ];
}

- (NSURLRequest *) authenticateRequest:(NSURLRequest *)request {
    NSString *token = ([_signer signWithExpInSeconds:_expirationTime]);
    NSMutableURLRequest *mutableRequest = (NSMutableURLRequest *)request;
    [mutableRequest setValue:[@"Bearer " stringByAppendingString:token] forHTTPHeaderField:@"Authorization"];
    return (NSURLRequest *)mutableRequest;
}

@end
