

#import <UIKit/UIKit.h>
#import "Webservice.h"
#import "Stock.h"

@protocol NewStockDelegate <NSObject>

-(void)clickOnOk;
-(void)stockDownloaded:(Stock*)stock;
-(void)enterText;
-(void)networkNotReachable;
-(void)didFailWithError;

@end

@interface NewStock : UIView<ServiceDelegate,UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *txtStockName;
@property (nonatomic, assign) id<NewStockDelegate> delegate;
-(IBAction)addNewStock;

@end
