//
//  TQRequest.m
//  Pods
//
//  Created by Taqtile on 8/13/15.
//
//

#import "TQRequest.h"

@implementation TQRequest {
    NSURLRequest *_request;
    TQRequestType _type;
}

- (instancetype) initWithRequest:(NSURLRequest *)request {
    self = [self init];
    _request = request;
    _type = TQRequestTypeAsync;
    return self;
}

- (instancetype) sync {
    _type = TQRequestTypeSync;
    return self;
}

- (instancetype) async {
    _type = TQRequestTypeAsync;
    return self;
}

- (NSURLRequest *) getRequest {
    return _request;
}

- (TQRequestType) getType {
    return _type;
}
@end
