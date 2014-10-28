//
//  RPUserProfileTableViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/26.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPUserProfileTableViewController.h"

@interface RPUserProfileTableViewController ()

@end

@implementation RPUserProfileTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        self.title = NSLocalizedString(@"我的资料", nil);
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack target:self action:@selector(btnBackClick)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"编辑", nil) target:self action:@selector(btnEditClick:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 51.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 == indexPath.row)
    {
        return;
    }
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"table-cell-bg0"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)]];
    cell.backgroundView = iv;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"u-profile-cell"];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"u-profile-cell"];
        cell.textLabel.backgroundColor = [UIColor clearColor];
    }
    
    if (0 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"uprofile-cell-icon0"];
        cell.textLabel.text = NSLocalizedString(@"电话:", nil);
    }
    else if (1 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"uprofile-cell-icon1"];
        cell.textLabel.text = NSLocalizedString(@"车牌:", nil);
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnEditClick:(UIButton *)sender
{
    
}

@end
