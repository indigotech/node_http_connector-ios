//
//  TQConnectorError.m
//  Pods
//
//  Created by Adriano on 8/11/15.
//
//

#import "TQConnectingError.h"

@implementation TQConnectingError

+ (instancetype) errorWithType: (ErrorType)type description:(NSString *)errorDescription {
    
    TQConnectingError *error = [[TQConnectingError alloc] init];
    error.errorDescription = [NSArray arrayWithObject:errorDescription];
    error.errorType = type;
    return error;
    
}

+ (instancetype) errorWithData: (NSDictionary *)data {
    
    TQConnectingError *error = [[TQConnectingError alloc] init];
    error.errorType = ErrorTypeUnknown;
    error.errorDescription = [NSArray arrayWithObject:@""];
    
    if (![data[@"errorCode"] isEqual: [NSNull null]]) {
        error.errorType = [TQConnectingError errorTypeFromString:data[@"errorCode"]];
    }
    
    if (![data[@"errors"] isEqual: [NSNull null]]) {
        error.errorDescription = data[@"errors"];
    }
    
    if (![data[@"errorMessage"] isEqual: [NSNull null]]) {
        error.errorMessage = data[@"errorMessage"];
    }

    return error;
    
}

+ (ErrorType) errorTypeFromString:(NSString *)str {
 
    NSDictionary *errorsDictionary = @{
                                       @"REQUEST_TIMEOUT": @0,
                                       @"INVALID_REQUEST_PARAMS": @1,
                                       @"INVALID_RESPONSE_DATA": @2,
                                       @"USER_ALREADY_EXISTS": @3,
                                       @"DATABASE_ERROR": @4,
                                       @"FORBIDDEN_ERROR": @5,
                                       @"VERSION_NOT_SUPPORTED": @6,
                                       @"TOO_MANY_REQUESTS": @7,
                                       @"UNAUTHORIZED_ERROR": @8,
                                       @"NOT_FOUND": @9
                                       };
    
    if (errorsDictionary[str] && ![errorsDictionary[str] isEqual:[NSNull null]]) {
        return [errorsDictionary[str] intValue];
    }
    
    return ErrorTypeUnknown;
}

- (NSString *) getErrorType {
    NSArray *errors = @[
                        @"Request Timeout",
                        @"Invalid Request Params",
                        @"Invalid Response Data",
                        @"User Already Exists",
                        @"Database Error",
                        @"Forbbiden",
                        @"Version error",
                        @"Too many requests",
                        @"Unauthorized",
                        @"Not Found",
                        @"Unknown error",
                        @"No connection"
                        ];
    
    return [errors objectAtIndex:self.errorType];
}


@end
