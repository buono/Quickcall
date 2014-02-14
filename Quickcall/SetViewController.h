//
//  SetViewController.h
//  Hasuitter
//
//  Created by 大野 篤史 on 2014/01/13.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UITableViewController {
    NSArray *keys;
    @private NSMutableArray *items;
    NSDictionary *dataSource;
    //NSMutableArray *contents;
    UITableView *tableView;
    NSArray *images;
    NSString *phone;
    NSString *name1, *name2, *name3, *name4;
}

@property (nonatomic, retain) NSString *phone;
@property (nonatomic, retain) NSString *name1, *name2, *name3, *name4;
- (id) initWithTextSelected:(NSString *)text;

@end
