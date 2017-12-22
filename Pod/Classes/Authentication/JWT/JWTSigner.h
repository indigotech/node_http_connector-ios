//
//  JWTSigner.h
//  TendaListaDeCompras
//
//  Created by Felipe Fill Cardoso on 2/1/15.
//  Copyright (c) 2015 Taqtile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWTSigner : NSObject

@property (strong, nonatomic, readonly) NSMutableDictionary *payload;

- (instancetype)initWithSecret:(NSString *)secret;
- (NSString *)signWithExpInMinutes:(double)minutes;
- (NSString *)signWithExpInSeconds:(double)seconds;

@end
