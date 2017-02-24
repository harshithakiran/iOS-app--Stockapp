
#import <Foundation/Foundation.h>

@interface Stock : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) float price;
@property(nonatomic,assign) float highPrice;
@property(nonatomic,assign) float lowPrice;

@end
