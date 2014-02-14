
//
//  Item1ViewController.m
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "Item1ViewController.h"
#import "LineView.h"
#import "SetViewController.h"

@interface Item1ViewController ()

@end

@implementation Item1ViewController {
    NSMutableArray *persons; //テーブルの表示に使用する
    NSDictionary *selectedPerson;
    NSString *firstName;
    NSString *lastName;
    BOOL isEditing; //編集モード中であるか
    BOOL isAddressMode;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //scrollview make
        scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:scrollView];
        self.automaticallyAdjustsScrollViewInsets = NO; //height of navigation bar
        
        self.navigationItem.title = @"メール";
        // Custom initialization
        scrollView.backgroundColor = [UIColor whiteColor];
        
        //insert in label
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 30)];
        nameLabel.textColor = [UIColor grayColor];
        nameLabel.text = @"名前:";
        [scrollView addSubview:nameLabel];
        nameText = [[UITextField alloc]initWithFrame:CGRectMake(60, 70, 250, 30)];
        nameText.borderStyle = UITextBorderStyleNone;
        nameText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [nameText addTarget:self action:@selector(returnPushed:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [scrollView addSubview:nameText];
        
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 150, 30)];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.text = @"宛先:";
        [scrollView addSubview:contentLabel];
        contentText = [[UITextField alloc]initWithFrame:CGRectMake(60, 110, 220, 30)];
        contentText.borderStyle = UITextBorderStyleNone;
        [contentText addTarget:self action:@selector(returnPushed:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [scrollView addSubview:contentText];
        
        UIButton *addressBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addressBtn setFrame:CGRectMake(280, 115, 20, 20)];
        [addressBtn setTitle:@"test" forState:UIControlStateNormal];
        [addressBtn addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchDown];
        [scrollView addSubview:addressBtn];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 150, 30)];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.text = @"件名:";
        [scrollView addSubview:titleLabel];
        titleText = [[UITextField alloc]initWithFrame:CGRectMake(60, 150, 250, 30)];
        titleText.borderStyle = UITextBorderStyleNone;
        titleText.clearButtonMode = UITextFieldViewModeWhileEditing;
        [titleText addTarget:self action:@selector(returnPushed:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [scrollView addSubview:titleText];
        
        bodyText = [[UITextView alloc]initWithFrame:CGRectMake(10, 190, 310, 120)];
        bodyText.font = [UIFont fontWithName:@"HiraKakuProN-W3"  size:16];
        [scrollView addSubview:bodyText];
        
        //線を描画する領域を用意
        LineView *lineView1 = [[LineView alloc]init];
        lineView1.frame = CGRectMake(10, 105, 1000, 1);
        [self.view addSubview:lineView1];
        LineView *lineView2 = [[LineView alloc]init];
        lineView2.frame = CGRectMake(10, 145, 1000, 1);
        [self.view addSubview:lineView2];
        LineView *lineView3 = [[LineView alloc]init];
        lineView3.frame = CGRectMake(10, 185, 1000, 1);
        [self.view addSubview:lineView3];
        //[self registerForKeyboardNotifications];
        
    }
    
    return self;
}

- (void)addAddress
{
    isAddressMode = YES;
    ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc]init];
    picker.peoplePickerDelegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    isAddressMode = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    ABMultiValueRef addrs = (ABMultiValueRef)ABRecordCopyValue(person,kABPersonEmailProperty);
    //選択した人物が持つメールアドレスの数
    int addrCount = ABMultiValueGetCount(addrs);
    firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));
    lastName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonLastNameProperty));
    
    //メールアドレスが1つもない
    if (addrCount==0){
        selectedPerson = @{@"email":@""};
        //[persons addObject:selectedPerson];
        //return NO;
    }
    //メールアドレスが複数ある
    else if(addrCount>1){
        //次の詳細画面にemailアドレスしか出ないようにセット。return YESで詳細画面に進む
        [peoplePicker setDisplayedProperties:[NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonEmailProperty]]];
        return YES;
    }
    //メールアドレスが1つしかない
    else{
        NSString *email = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(addrs, 0);
        selectedPerson = @{@"email":email};
        //NSDictionary *selectedPerson = @{@"first":firstName, @"last":lastName, @"email":email};
        //[persons addObject:selectedPerson];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMutableMultiValueRef *multi = ABRecordCopyValue(person, property);
    CFIndex index = ABMultiValueGetIndexForIdentifier(multi, identifier);
    
    //選択されたアドレスと人物を紐付けてpersonsに追加
    NSString *email = (__bridge NSString *)ABMultiValueCopyValueAtIndex(multi, index);
    selectedPerson = @{@"email":email};
    //NSDictionary *selectedPerson = @{@"first":firstName, @"last":lastName, @"email":email};
    //[persons addObject:selectedPerson];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    return NO;
}



- (void)returnPushed:(UITextField*)textfield {
    //keyboard close when return button pushed
    [textfield resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    //showing user data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    nameText.text = [userDefaults stringForKey:@"mail1Name"];
    contentText.text = [userDefaults stringForKey:@"mail1Address"];
    titleText.text = [userDefaults stringForKey:@"mail1Title"];
    bodyText.text = [userDefaults stringForKey:@"mail1Body"];
    
    if (isAddressMode == YES ){
        contentText.text = [NSString stringWithFormat:@"%@", [selectedPerson objectForKey:@"email"]];
        isAddressMode = NO;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    persons = [NSMutableArray array];
    isEditing = NO;
    isAddressMode = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 -(void)registerForKeyboardNotifications;
 {
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
 [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
 }
 */

/*
 - (void)keyboardWasShown:(NSNotification *)aNotification
 {
 CGPoint scrollPoint = CGPointMake(0.0, 50.0);
 [scrollView setContentOffset:scrollPoint animated:YES];
 }
 
 - (void)keyboardWillBeHidden:(NSNotification *)aNotification
 {
 [scrollView setContentOffset:CGPointZero animated:YES];
 }
 */

- (void)viewWillDisappear:(BOOL)animated
{
    //stocking user data
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nameText.text forKey:@"mail1Name"];
    [userDefaults setObject:contentText.text forKey:@"mail1Address"];
    [userDefaults setObject:titleText.text forKey:@"mail1Title"];
    [userDefaults setObject:bodyText.text forKey:@"mail1Body"];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    delegate.name1 = nameText.text;
    delegate.address1 = contentText.text;
    delegate.title1 = titleText.text;
    delegate.body1 = bodyText.text;
    
}


@end