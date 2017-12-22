//
//  TQNetworking.m
//  Pods
//
//  Created by Taqtile on 8/11/15.
//
//

#import "TQConnecting.h"
#import "AFHTTPRequestOperationManager.h"
#import "JWTSigner.h"
#import "TQConnectingError.h"

int const kNoContentStatusCode = 204;

@interface TQConnecting ()

@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;

@end


@implementation TQConnecting

#pragma mark - Public API

- (AFHTTPRequestOperation *) performRequest: (TQRequest *)request
                success:(void(^)(NSDictionary *response))successCallback
                failure:(void(^)(TQConnectingError *error))failureCallback {
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:[request getRequest]];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.isCancelled){
            return;
        }
        
        if (operation.response.statusCode == kNoContentStatusCode) {
            successCallback(@{});
        } else {
            [self handleResponse:(NSDictionary *)responseObject
                         headers:[[operation response] allHeaderFields]
                         success:successCallback
                         failure:failureCallback];
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (operation.isCancelled){
            return;
        }
        
        if ([[self noConnectionErrorCodes] containsObject:[NSNumber numberWithLongLong:error.code]]) {
            return failureCallback([TQConnectingError errorWithType:ErrorTypeNoConnection
                                                        description:@"Sem conexão."]);
        }
        [self handleErrorResponse:(NSDictionary *)operation.responseObject
                          headers:[[operation response] allHeaderFields]
                          success:successCallback
                          failure:failureCallback];
        
    }];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperation:operation];
    
    // TODO: Verify if it works
    // http://stackoverflow.com/questions/7969865/can-afnetworking-return-data-synchronously-inside-a-block
    if ([request getType] == TQRequestTypeSync)
        [operation waitUntilFinished];
    
    return operation;
}

#pragma mark - private methods
- (void) handleResponse: (NSDictionary *)response
                headers: (NSDictionary *)headers
                success:(void(^)(NSDictionary *response))successCallback
                failure:(void(^)(TQConnectingError *error))failureCallback {
    
    if ((!response) || ([response isEqual:[NSNull null]]) || ([response[@"data"] isEqual: [NSNull null]])) {
        return failureCallback([TQConnectingError errorWithType:ErrorTypeUnknown
                                                    description:@"A resposta não estava no formato esperado."]);
    }
    
    if([response objectForKey:@"data"]) {
        NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] init];
        [returnDict addEntriesFromDictionary:response];
        [returnDict setObject:headers forKey:@"headers"];
        return successCallback(returnDict);
    }
}

- (void) handleErrorResponse:(NSDictionary *)response
                     headers:(NSDictionary *)headers
                     success:(void(^)(NSDictionary *response))successCallback
                     failure:(void(^)(TQConnectingError *error))failureCallback {
    
    if (![response[@"data"][@"errorCode"] isEqual: [NSNull null]]) {
        return failureCallback([TQConnectingError errorWithData:response[@"data"]]);
    }
    
}



- (NSArray *) noConnectionErrorCodes
{
    
    // http://stackoverflow.com/questions/6778167/undocumented-nsurlerrordomain-error-codes-1001-1003-and-1004-using-storeki
    return @[
             @-998,
             @-999,
             @-1000,
             @-1001,
             @-1000,
             @-1001,
             @-1002,
             @-1003,
             @-1004,
             @-1005,
             @-1006,
             @-1007,
             @-1008,
             @-1009,
             @-1010
             ];
}

@end
