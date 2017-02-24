//
//  ViewController.h
//  StockApp
//  created by Harshitha

#import <UIKit/UIKit.h>
#import "Stock.h"
#import "NewStock.h"


@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NewStockDelegate>

@property (nonatomic, strong) NSMutableArray *arrStocks;


@end

