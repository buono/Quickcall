//
//  SetViewController.m
//  RingetsuAlarm
//
//  Created by 大野 篤史 on 2014/01/10.
//  Copyright (c) 2014年 Atsushi Ohno. All rights reserved.
//

#import "SetViewController.h"
#import "AppDelegate.h"
#import "IconCell.h"
#import "Item1ViewController.h"


@interface SetViewController ()

@end


@implementation SetViewController {
    AppDelegate *delegate;
}
@synthesize phone;
@synthesize name1, name2, name3, name4;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // Custom initialization
        self.title = @"設定画面";
        //keys = [[NSArray alloc]initWithObjects:@"電話", @"メール", nil];
        
        //items = [NSArray arrayWithObjects:@"マタニティタクシー",@"母親",@"夫",@"友達", nil];
        //items = [NSMutableArray arrayWithObjects:@"Item1ViewController",@"Item2ViewController", nil];
        //items = [NSMutableArray arrayWithObjects:item2, nil];
        
        //dataSource = [[NSDictionary alloc]initWithObjects:items forKeys:keys];
        
        /*
        keys = [[NSArray alloc]initWithObjects:@"電話", @"メール", nil];
        NSArray *item1 = [NSArray arrayWithObjects:@"マタニティタクシー", nil];
        NSArray *item2 = [NSArray arrayWithObjects:@"母親",@"夫",@"友達", nil];
        //items = [NSMutableArray arrayWithObjects:@"Item1ViewController",@"Item2ViewController", nil];
        items = [NSMutableArray arrayWithObjects:item1, item2, nil];
        
        dataSource = [[NSDictionary alloc]initWithObjects:items forKeys:keys];
         */
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
    }
    return self;
}

- (id)initWithTextSelected:(NSString *)text {
    self.phone = text;
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    //下層から戻ってきた時に、そのデータを反映させるためにこの欄に入れておく必要あり
    name1 = delegate.name1;
    name2 = delegate.name2;
    name3 = delegate.name3;
    name4 = delegate.name4;
    items = [NSMutableArray arrayWithObjects:name1, name2, name3, name4,  nil];
    
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    UIImage *image1 = [UIImage imageNamed:@"phone.png"];
    [image1 size];
    UIImage *image2 = [UIImage imageNamed:@"mail.png"];
    images = [[NSArray alloc]initWithObjects:image2, image2, image2, image1, nil];
    
    
        /*
        //電話追加ボタン
        UIButton *addTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addTelBtn.frame = CGRectMake(280, 0, 30, 30);
        addTelBtn.titleLabel.font = [UIFont fontWithName:nil size:40];
        [addTelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addTelBtn setTitle:@"+" forState:UIControlStateNormal];
        [addTelBtn addTarget:self action:@selector(addTelMode) forControlEvents:UIControlStateNormal];
        [self.view addSubview:addTelBtn];
        [self.view bringSubviewToFront:addTelBtn];
        //メール追加ボタン
        UIButton *addMailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        addMailBtn.frame = CGRectMake(280, 70, 30, 30);
        addMailBtn.titleLabel.font = [UIFont fontWithName:nil size:40];
        [addMailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addMailBtn setTitle:@"+" forState:UIControlStateNormal];
        [addMailBtn addTarget:self action:@selector(addMailMode) forControlEvents:UIControlStateNormal];
        [self.view addSubview:addMailBtn];
         */
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    //return [keys count];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    id key = [keys objectAtIndex:section];
    NSLog(@"%@", key);
    //return [[dataSource objectForKey:key] count];
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    //indexPathつけるとなぜか動かない
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    IconCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(nil==cell){
        cell = [[IconCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    //id key = [keys objectAtIndex:indexPath.section];
    //NSString *titleText= [[dataSource objectForKey:key] objectAtIndex:indexPath.row];
    NSString *titleText= [items objectAtIndex:indexPath.row];
    cell.textLabel.text = titleText;
    cell.imageView.image = [images objectAtIndex:indexPath.row];
    //cell.imageView.backgroundColor = [UIColor colorWithRed:0.8 green:0 blue:0.1 alpha:0.3];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [keys objectAtIndex:section];
}


/*
    Item1ViewController *item1ViewController = [[Item1ViewController alloc]initWithNibName:nil bundle:nil];
    NSString *detailText = item1ViewController.phone;
    cell.detailTextLabel.text = detailText;
*/



/*
- (void)backToMain
{
    MainViewController *mainViewController = [[MainViewController alloc]init];
    //[self dismissModalViewControllerAnimated:mainViewController];
    [self dismissViewControllerAnimated:mainViewController completion:nil];
    //[self removeFromParentViewController];
    //[self presentViewController:mainViewController animated:YES completion:nil];
}
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //うまく作れず
    //Class class = NSClassFromString([items objectAtIndex:indexPath.row]);
    if (indexPath.row == 0){
        Class class = NSClassFromString(@"Item1ViewController");
        id viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 1){
        Class class = NSClassFromString(@"Item2ViewController");
        id viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 2){
        Class class = NSClassFromString(@"Item3ViewController");
        id viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    } else if (indexPath.row == 3){
        Class class = NSClassFromString(@"Item4ViewController");
        id viewController = [[class alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */


@end
