//
//  AppDelegate.h
//  Quickcall
//
//  Created by 大野 篤史 on 2014/02/02.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    UIWindow *window;
    NSString *name1, *name2, *name3, *name4;
    NSString *title1, *title2, *title3;
    NSString *body1, *body2, *body3;
    NSString *address1, *address2, *address3;
    NSString *number;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *name1, *name2, *name3, *name4;
@property (nonatomic, retain) NSString *title1, *title2, *title3;
@property (nonatomic, retain) NSString *body1, *body2, *body3;
@property (nonatomic, retain) NSString *address1, *address2, *address3;
@property (nonatomic, retain) NSString *number;
@end
