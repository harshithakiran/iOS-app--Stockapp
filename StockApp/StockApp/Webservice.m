//
//  Webservice.m
//  StockApp
//  created by Harshitha

#import "Webservice.h"

@implementation Webservice

-(void)sendServiceForStock:(NSString*)name{
    
    if (![self checkReachability]) {
        
        NSLog(@"internet is not reachable");
        [self.delegate networkNotReachable];
        return;
    }
    NSString *yahoo_api_url = [YAHOO_API_URL stringByReplacingOccurrencesOfString:@"SYMBOL" withString:name];
    NSURL *url = [NSURL URLWithString:yahoo_api_url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *error) {
     
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        if (!error && [httpResponse statusCode] == 200) {
            if (data && [data length] >0) {
                
                NSError *err;
                NSDictionary *stockInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
                NSDictionary *stockList = [stockInfo objectForKey:@"list"];
                NSArray *stockInfo2 = [stockList objectForKey:@"resources"];
                if (stockInfo2 && stockInfo2.count>0) {
                    
                    NSDictionary *stockInfo3 = [stockInfo2 objectAtIndex:0];
                    NSDictionary *stockInfo4 = [stockInfo3 objectForKey:@"resource"];
                    NSDictionary *stockInfo5 = [stockInfo4 objectForKey:@"fields"];
                    Stock *stock = [[Stock alloc]init];
                    stock.name = name;
                    stock.price = [[stockInfo5 objectForKey:@"price"]floatValue];
                    stock.highPrice = [[stockInfo5 objectForKey:@"day_high"]floatValue];
                    stock.lowPrice = [[stockInfo5 objectForKey:@"day_low"]floatValue];
                    
                    [self.delegate stockDownloaded:stock];
                }

            }
        }
        else{
            
            [self.delegate didFailWithError];
        }


        
    }];
    
    [task resume];

}
-(BOOL)checkReachability{
    
    
    BOOL reachable = NO;
    //Reachability
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(handleNetworkChange:) name: kReachabilityChangedNotification object: nil];
    
    self.reachability = [Reachability reachabilityForInternetConnection];
    
    [self.reachability startNotifier];
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        

        NSLog(@"no");
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        NSLog(@"wifi");
        reachable = YES;

    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        NSLog(@"cell");
        reachable = YES;

    }
    return reachable;
    
}
- (void) handleNetworkChange:(NSNotification *)notice
{
    
    NetworkStatus remoteHostStatus = [self.reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable) {
        NSLog(@"no");
    }
    else if (remoteHostStatus == ReachableViaWiFi) {
        NSLog(@"wifi");

    }
    else if (remoteHostStatus == ReachableViaWWAN) {
        NSLog(@"cell");
    }
}
@end
