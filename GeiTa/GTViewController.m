//
//  GTViewController.m
//  GeiTa
//
//  Created by LiXiangYu on 13-12-16.
//
//

#import "GTViewController.h"

@interface GTViewController ()

@end

@implementation GTViewController

#pragma mark- 生命周期
- (void)dealloc
{
    GTLOG(@"控制器销毁%@",[self class]);
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
