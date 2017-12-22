//
//  TQRequestBuilder.m
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import "TQRequestBuilder.h"
#import "TQAuthenticator.h"
#import "AFHTTPRequestOperation.h"

@implementation TQRequestBuilder {
    NSString *_hostName;
    TQAuthenticator *_authenticator;
    
}

#pragma mark - public api
- (instancetype) initWithHostName:(NSString *)hostName {
    self = [self init];
    _authenticator = [[TQAuthenticator alloc] init];
    _hostName = hostName;
    return self;
}

- (TQRequest *) getWithPath:(NSString *)path
                       headers:(NSDictionary *)headers
                        params:(NSDictionary *)params
{
    return [self buildRequestWithPath:path
                              headers:headers
                                 data:params
                               method:@"GET"];
}

- (TQRequest *) postWithPath:(NSString *)path
                        headers:(NSDictionary *)headers
                           body:(NSDictionary *)body
{
    return [self buildRequestWithPath:path
                              headers:headers
                                 data:body
                               method:@"POST"];
}

- (TQRequest *) putWithPath:(NSString *)path
                     headers:(NSDictionary *)headers
                        body:(NSDictionary *)body
{
    return [self buildRequestWithPath:path
                              headers:headers
                                 data:body
                               method:@"PUT"];
}

- (TQRequest *) deleteWithPath:(NSString *)path
                    headers:(NSDictionary *)headers
                       body:(NSDictionary *)body
{
    return [self buildRequestWithPath:path
                              headers:headers
                                 data:body
                               method:@"DELETE"];
}

- (TQRequest *) patchWithPath:(NSString *)path
                      headers:(NSDictionary *)headers
                         body:(NSDictionary *)body {
    
    return [self buildRequestWithPath:path
                              headers:headers
                                 data:body
                               method:@"PATCH"];
}

- (void) use:(id<TQAuthenticationStrategyProtocol>)authStrategy {
    [_authenticator use:authStrategy];
}

#pragma mark - private methods
- (TQRequest *) buildRequestWithPath:(NSString *)path
                                headers:(NSDictionary *)headers
                                 data:(NSDictionary *)data
                                 method:(NSString *)method
{

    NSString *fullPath = [_hostName stringByAppendingString:path];
    AFJSONRequestSerializer *serializer = [[AFJSONRequestSerializer alloc] init];

    NSMutableURLRequest *request = [serializer requestWithMethod:method URLString:fullPath parameters:data error:nil];
    
    
    for (id key in headers) {
        [request addValue:(NSString *)headers[key] forHTTPHeaderField:(NSString *)key];
    }
    
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    return [[TQRequest alloc] initWithRequest:[_authenticator getAuthenticatedRequest:(NSURLRequest *)request]];
    
}


@end
