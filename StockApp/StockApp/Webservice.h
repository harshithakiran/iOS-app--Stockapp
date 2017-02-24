//
//  Webservice.h
//  StockApp
//  created by Harshitha


#import <Foundation/Foundation.h>
#import "Stock.h"
#import "Constants.h"
#import "Reachability.h"

@protocol ServiceDelegate <NSObject>

-(void)stockDownloaded:(Stock*)stock;
-(void)networkNotReachable;
-(void)didFailWithError;
@end

@interface Webservice : NSObject

-(void)sendServiceForStock:(NSString*)name;
@property (nonatomic, assign) id<ServiceDelegate> delegate;
@property (strong, nonatomic) Reachability *reachability;

@end
