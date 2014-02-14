//
//  MainViewController.m
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "MainViewController.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "AppDelegate.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize title1;
@synthesize body1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //UIImage *mainImage = [UIImage imageNamed:@"mogura.jpg"];
        UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        
        //ツールバーの表示
        mainText = [[UILabel alloc]initWithFrame:CGRectMake(window.center.x - 130, window.center.y - 150, 300, 100)];
        mainText.text = @"緊急時専用ダイヤル";
        mainText.font = [UIFont systemFontOfSize:30];
        mainText.textColor = [UIColor grayColor];
        [self.view addSubview:mainText];
        
        UIImage *mainImage = [UIImage imageNamed:@"phone-main.gif"];
        callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        callBtn.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height * 0.5);
        callBtn.center = CGPointMake(window.center.x, window.center.y + 50);
        [callBtn setBackgroundImage:mainImage forState:UIControlStateNormal];
        //[callBtn setTitle:@"病院行くよ" forState:UIControlStateNormal];
        [callBtn addTarget:self action:@selector(sendEmailInBackground1) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:callBtn];
        [[callBtn layer] setCornerRadius:8.0f];
        [[callBtn layer] setMasksToBounds:YES];
        [[callBtn layer] setBorderWidth:0];
        //[[callBtn layer]setBackgroundColor:[[UIColor colorWithRed:1.0 green:0.8 blue:0.8 alpha:1.0] CGColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //default setup
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    delegate.name1 = [userDefaults stringForKey:@"mail1Name"];
    delegate.name2 = [userDefaults stringForKey:@"mail2Name"];
    delegate.name3 = [userDefaults stringForKey:@"mail3Name"];
    delegate.name4 = [userDefaults stringForKey:@"phoneName"];
    delegate.number = [userDefaults stringForKey:@"phoneNumber"];
    delegate.address1 = [userDefaults stringForKey:@"mail1Address"];
    delegate.address2 = [userDefaults stringForKey:@"mail2Address"];
    delegate.address3 = [userDefaults stringForKey:@"mail3Address"];
    delegate.title1 = [userDefaults stringForKey:@"mail1Title"];
    delegate.title2 = [userDefaults stringForKey:@"mail2Title"];
    delegate.title3 = [userDefaults stringForKey:@"mail3Title"];
    delegate.body1 = [userDefaults stringForKey:@"mail1Body"];
    delegate.body2 = [userDefaults stringForKey:@"mail2Body"];
    delegate.body3 = [userDefaults stringForKey:@"mail3Body"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//E-Mailを送信する際にCallする
-(void) sendEmailInBackground1
{
    //addition of sendCount
    /*
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
    picker.mailComposeDelegate = self;
    [picker setSubject:@"タイトルです"];
    NSArray *toRecipients = [NSArray arrayWithObject:@"yakko_tofu@yahoo.co.jp"];
    [picker setToRecipients:toRecipients];
    NSString *body = @"body here";
    [picker setMessageBody:body isHTML:NO];
    [self presentViewController:picker animated:YES completion:nil];
     */
    sendCount++;
    [self viewDidAppear:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (sendCount == 0){
        // do nothing
    }else if (sendCount == 1){
        [self phoneCall];
        
        //AppDelegateに通知
        //[self sendNotification];
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
        picker.mailComposeDelegate = self;
        [picker setSubject: delegate.title1];
        NSArray *toRecipients = [NSArray arrayWithObject: delegate.address1];
        [picker setToRecipients:toRecipients];
        NSString *body = delegate.body1;
        [picker setMessageBody:body isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
        sendCount++;
    }else if (sendCount == 2){
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
        picker.mailComposeDelegate = self;
        [picker setSubject:delegate.title2];
        NSArray *toRecipients = [NSArray arrayWithObject: delegate.address2];
        [picker setToRecipients:toRecipients];
        NSString *body = delegate.body2;
        [picker setMessageBody:body isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
        sendCount++;
    }else if (sendCount == 3){
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc]init];
        picker.mailComposeDelegate = self;
        [picker setSubject: delegate.title3];
        NSArray *toRecipients = [NSArray arrayWithObject: delegate.address3];
        [picker setToRecipients:toRecipients];
        NSString *body = delegate.body3;
        [picker setMessageBody:body isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
        sendCount++;
    }else if (sendCount == 4){
        [self phoneCall];
        sendCount = 0;
    }
}

- (void)sendNotification
{
    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
    localNotification.fireDate = [[NSDate date]addTimeInterval:5];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"ok",@"test", nil];
    localNotification.userInfo = infoDict;
    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
}

- (void)resetMode
{
    [mainText removeFromSuperview];
    [afterText removeFromSuperview];
    [callBtn removeFromSuperview];
    [backBtn removeFromSuperview];
    //display reset
    UIImage *mainImage = [UIImage imageNamed:@"mogura.jpg"];
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //ツールバーの表示
    mainText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    mainText.textColor = [UIColor blackColor];
    mainText.text = @"破水が始まったら僕を押してね！";
    [self.view addSubview:mainText];
    
    callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    callBtn.frame = CGRectMake(0, 0, window.frame.size.width, window.frame.size.height * 0.3);
    callBtn.center = CGPointMake(window.center.x, window.center.y + 30);
    [callBtn setBackgroundImage:mainImage forState:UIControlStateNormal];
    //[callBtn setTitle:@"病院行くよ" forState:UIControlStateNormal];
    [callBtn addTarget:self action:@selector(sendEmailInBackground) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:callBtn];
    [[callBtn layer] setCornerRadius:8.0f];
    [[callBtn layer] setMasksToBounds:YES];
    [[callBtn layer] setBorderWidth:0];
}

    - (void)phoneCall
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *phone = delegate.number;
        NSString *phrase = @"-";
        NSString *separatedPhone;
        if(phone.length == 11){
        //for cell phone
            NSString *phone1 = [phone substringToIndex:3];
            NSString *phone2 = [phone substringWithRange:NSMakeRange(3, 4)];
            NSString *phone3 = [phone substringFromIndex:7];
            separatedPhone = [[[[phone1 stringByAppendingString:phrase]stringByAppendingString:phone2]stringByAppendingString:phrase]stringByAppendingString:phone3];
        }else{
            /*
            NSString *phone1 = [phone substringToIndex:3];
            NSString *phone2 = [phone substringWithRange:NSMakeRange(3, 3)];
            NSString *phone3 = [phone substringFromIndex:6];
            separatedPhone = [[[[phone1 stringByAppendingString:phrase]stringByAppendingString:phone2]stringByAppendingString:phrase]stringByAppendingString:phone3];
             */
        }
        
        /*
        NSString *urlScheme = @"tel:090-5457-6452";
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlScheme]];
         */
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",separatedPhone]];
        [[UIApplication sharedApplication] openURL:url];
    }

// 送信エラー時にCallされる（エラー時の処理をコーディングする）
/*
-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error
{
    NSLog(@"Gmail送信失敗 - error(%d): %@", [error code], [error localizedDescription]);
    //アラート表示
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gmail送信失敗!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}
 */



@end
