//
//  TQNetworking.h
//  Pods
//
//  Created by Taqtile on 8/11/15.
//
//

#import <Foundation/Foundation.h>
#import "TQConnectingError.h"
#import "TQRequest.h"
#import "AFHTTPRequestOperationManager.h"

@interface TQConnecting : NSObject

- (AFHTTPRequestOperation *) performRequest: (TQRequest *)request
                success:(void(^)(NSDictionary *response))successCallback
                failure:(void(^)(TQConnectingError *error))failureCallback;

@end
