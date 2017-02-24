

#import "NewStock.h"

@implementation NewStock

-(IBAction)addNewStock{
    
    if (self.txtStockName.text.length >0) {
        
        Webservice *webservice = [[Webservice alloc]init];
        webservice.delegate = self;
        [webservice sendServiceForStock:self.txtStockName.text];
        [self.delegate clickOnOk];
    }
    else{
        
        [self.delegate enterText];
        
    }

}
-(void)stockDownloaded:(Stock*)stock{

    [self.delegate stockDownloaded:stock];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}
-(void)networkNotReachable{
    
    [self.delegate networkNotReachable];
}
-(void)didFailWithError{
   
    [self.delegate didFailWithError];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
