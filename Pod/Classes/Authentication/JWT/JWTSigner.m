//
//  JWTSigner.m
//  TendaListaDeCompras
//
//  Created by Felipe Fill Cardoso on 2/1/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import <CommonCrypto/CommonHMAC.h>
#import "JWTSigner.h"

@interface JWTSigner()

@property (strong, nonatomic) NSMutableDictionary *payload;

@end

@implementation JWTSigner {
    NSString *_secret;
    NSDictionary *_header;
}

#pragma mark - Public API

- (instancetype)initWithSecret:(NSString *)secret {
    self = [[JWTSigner alloc] init];
    
    _secret = secret;
    _header = @{@"typ": @"JWT", @"alg": @"HS256"};
    self.payload = [[NSMutableDictionary alloc] init];
    
    return self;
}

- (NSString *)signWithExpInSeconds:(double)seconds {

    double minutes = (double)(seconds / 60);
    
    return [self signWithExpInMinutes:minutes];
    
}

- (NSString *)signWithExpInMinutes:(double)minutes {
    double iat = [[NSDate date] timeIntervalSince1970];
    double exp = iat + (minutes * 60);
    
    [self.payload addEntriesFromDictionary:@{@"iat": [NSNumber numberWithLongLong:(long long)iat], @"exp": [NSNumber numberWithLongLong:(long long)exp]}];
    
    NSString *encodedHeader = [JWTSigner encodeUsingBase64:_header];
    NSString *encodedPayload = [JWTSigner encodeUsingBase64:self.payload];
    NSString *both = [NSString stringWithFormat:@"%@.%@", encodedHeader, encodedPayload];
    
    return [NSString stringWithFormat:@"%@.%@", both, [JWTSigner encode:both withSecret:_secret]];
}


#pragma mark - Methods

+ (NSString *)encode:(NSString *)data withSecret:(NSString *)secret;
{
    NSData *saltData = [secret dataUsingEncoding:NSASCIIStringEncoding];
    NSData *paramData = [data dataUsingEncoding:NSASCIIStringEncoding];
    NSMutableData* hash = [NSMutableData dataWithLength:CC_SHA256_DIGEST_LENGTH ];
    CCHmac(kCCHmacAlgSHA256, saltData.bytes, saltData.length, paramData.bytes, paramData.length, hash.mutableBytes);
    
    NSString *signature = [hash base64EncodedStringWithOptions:0];
    
    return [JWTSigner base64urlFromBase64Standard:signature];
}

+ (NSString *)encodeUsingBase64:(id)data {
    NSError *error;
    NSString *result = [[NSJSONSerialization dataWithJSONObject:data options:0 error:&error] base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    
    NSAssert(!error, @"Could not encode segment: %@", [error localizedDescription]);
    
    return [JWTSigner base64urlFromBase64Standard:result];
}

+ (NSString *)base64urlFromBase64Standard:(NSString *)base64Std {
    NSString *base64url = [base64Std stringByReplacingOccurrencesOfString:@"=" withString:@""];
    base64url = [base64url stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    base64url = [base64url stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    return base64url;
}

@end
