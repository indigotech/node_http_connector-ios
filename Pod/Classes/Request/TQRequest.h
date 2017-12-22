//
//  TQRequest.h
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

typedef enum {
    TQRequestTypeSync,
    TQRequestTypeAsync
} TQRequestType;

#import <Foundation/Foundation.h>

@interface TQRequest : NSObject

- (instancetype) initWithRequest:(NSURLRequest *)request;
- (instancetype) sync;
- (instancetype) async;
- (NSURLRequest *) getRequest;
- (TQRequestType) getType;
@end
