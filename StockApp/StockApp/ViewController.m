//
//  ViewController.m
//  StockApp
//  created by Harshitha

//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableStocks;
@property (nonatomic, strong)IBOutlet NewStock *stockUI;
-(IBAction)addNewStock:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.arrStocks = [[NSMutableArray alloc]init];
}

-(void)stockDownloaded:(Stock*)stock{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.arrStocks addObject:stock];
        [self.tableStocks reloadData];
    });

}
-(void)clickOnOk{
    
    [self.stockUI removeFromSuperview];
}
-(void)networkNotReachable{
    
    [self showAlert:@"Oops" message:@"Some error occured, please try again"];
}
-(void)didFailWithError{
 
    [self showAlert:@"Error" message:@"Check your internet"];
}
-(void)enterText{
    
    [self showAlert:@"Missing" message:@"enter stock name"];
}
-(void)showAlert:(NSString*)title message:(NSString*)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    UIAlertAction *destroyAction = [UIAlertAction actionWithTitle:@"dismiss" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:destroyAction];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewStock:(id)sender{
   
  NSArray *arrNibs = [[NSBundle mainBundle]loadNibNamed:@"NewStock" owner:self options:nil];
    if (arrNibs && arrNibs.count >0) {
        
        self.stockUI = [arrNibs objectAtIndex:0];
        float x= (self.view.frame.size.width - self.stockUI.frame.size.width)/2;
        float y= (self.view.frame.size.height - self.stockUI.frame.size.height)/2;
        self.stockUI.frame = CGRectMake(x, y, self.stockUI.frame.size.width, self.stockUI.frame.size.height);
        self.stockUI.delegate = self;
        [self.view addSubview:self.stockUI];
    }
    
}

#pragma UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.arrStocks.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    Stock *stock = [self.arrStocks objectAtIndex:indexPath.row];
    UILabel *lblname = (UILabel*)[cell.contentView viewWithTag:10];
    lblname.text = stock.name;
    
    UILabel *lblPrice = (UILabel*)[cell.contentView viewWithTag:20];
    lblPrice.text = [NSString stringWithFormat:@"%0.2f", stock.price];
    
    UILabel *lblHighPrice = (UILabel*)[cell.contentView viewWithTag:30];
    lblHighPrice.text = [NSString stringWithFormat:@"%0.2f", stock.highPrice];
    
    UILabel *lblLowPrice = (UILabel*)[cell.contentView viewWithTag:40];
    lblLowPrice.text = [NSString stringWithFormat:@"%0.2f", stock.lowPrice];
    
    return cell;
}


@end
