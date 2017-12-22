//
//  TQConnectorError.h
//  Pods
//
//  Created by Adriano on 8/11/15.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    ErrorTypeRequestTimeout,
    ErrorTypeInvalidRequestParams,
    ErrorTypeInvalidResponseData,
    ErrorTypeUserAlreadyExists,
    ErrorTypeDataBase,
    ErrorTypeForbidden,
    ErrorTypeVersion,
    ErrorTypeTooManyRequests,
    ErrorTypeUnauthorized,
    ErrorTypeNotFound,
    ErrorTypeUnknown,
    ErrorTypeNoConnection
} ErrorType;

@interface TQConnectingError : NSObject

@property (nonatomic) ErrorType errorType;
@property (nonatomic, strong) NSArray *errorDescription;
@property (nonatomic, strong) NSString *errorMessage;


+ (instancetype) errorWithType: (ErrorType)type description:(NSString *)errorDescription;
+ (instancetype) errorWithData: (NSDictionary *)data;
- (NSString *) getErrorType;

@end
