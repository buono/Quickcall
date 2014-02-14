//
//  SubViewController.m
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "SubViewController.h"
#import "SetViewController.h"

@interface SubViewController ()

@end

@implementation SubViewController

@synthesize window;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        SetViewController *setViewController = [[SetViewController alloc]init];
        rootController = [[UINavigationController alloc]initWithRootViewController:setViewController];
        [self.view addSubview:rootController.view];
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

- (void)viewWillAppear:(BOOL)animated
{
    SetViewController *setViewController = [[SetViewController alloc]init];
    [setViewController.tableView setEditing:YES animated:YES];
}


@end
