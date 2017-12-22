//
//  NCViewController.m
//  NodeHttpConnector
//
//  Created by Adriano Valente on 08/10/2015.
//  Copyright (c) 2015 Adriano Valente. All rights reserved.
//

#import "NCViewController.h"
#import "TQConnecting.h"
#import "TQConnectingError.h"
#import "TQRequestBuilder.h"
#import "TQRequest.h"
#import "TQAuthenticationStrategyJWT.h"
#import "TQAuthenticationStrategyVersion.h"


@interface NCViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation NCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLabel];

}
- (IBAction)requestButton:(id)sender {
    
    [self dispatchRequest];
    
}

- (void) setupLabel {
    [self.label setNumberOfLines:0];
    [self.label setLineBreakMode:NSLineBreakByWordWrapping];
}

- (void)dispatchRequest
{
    TQConnecting *connection = [[TQConnecting alloc] init];
    
    // Instantiating
    TQAuthenticationStrategyJWT *jwtAuth = [[TQAuthenticationStrategyJWT alloc] initWithJWTSecret:@"test"];
    TQAuthenticationStrategyVersion *versionAuth = [[TQAuthenticationStrategyVersion alloc] initWithVersion:@"IOS_VERSION-1.0.0"];
    
    TQRequestBuilder *builder = [[TQRequestBuilder alloc] initWithHostName:@"http://127.0.0.1:3050"];
    [builder use:jwtAuth];
    [builder use:versionAuth];
    
    NSDictionary *params = @{
                             @"cep": @"04675085",
                             @"lat": @"-23.5556274",
                             @"long": @"-46.6958154"
                             };
    
    
    
    TQRequest *request = [builder getWithPath:@"/v1/stores/stores-by-cep" headers:@{} params:params];
    
    [connection performRequest:request success:^(NSDictionary *response) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sucesso!"
                                                        message:@"O conteúdo da resposta foi logado"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        NSLog(@"%@", response);
        
    } failure:^(TQConnectingError *error) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error getErrorType]
                                                        message:[error.errorDescription objectAtIndex:0]
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
