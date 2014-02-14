//
//  MainViewController.h
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController {
    UIButton *callBtn;
    UIButton *backBtn;
    UILabel *mainText;
    UILabel *afterText;
    NSInteger sendCount;
    
    NSString *title1;
    NSString *body1;
}

@property (nonatomic, retain) NSString *title1;
@property (nonatomic, retain) NSString *body1;





//- (void)dataInput:(NSString *)name:(NSString *)address:(NSInteger *)number;

@end
