//
//  Item2ViewController.h
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface Item2ViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate> {
    NSManagedObjectContext *context;
    UITextField *nameText;
    UITextField *contentText;
    UITextField *titleText;
    UITextView *bodyText;
    UIScrollView *scrollView;
}

@end
