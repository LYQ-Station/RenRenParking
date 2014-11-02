//
//  RPUserProfileTableViewController.m
//  RenRenParking
//
//  Created by LiYongQiang on 14/10/26.
//  Copyright (c) 2014年 CoderFly. All rights reserved.
//

#import "RPUserProfileTableViewController.h"

@interface RPUserProfileTableViewController () <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isEditingStatus;

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
        
        self.mobile = @"1801234567";
        self.carNumber = @"粤B12345";
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

- (void)didReceiveMemoryWarning
{
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"u-profile-cell"];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (0 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"uprofile-cell-icon0"];
        cell.textLabel.text = NSLocalizedString(@"电话:", nil);
        
        if (_isEditingStatus)
        {
            cell.detailTextLabel.text = nil;
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-130, 51)];
            tf.tag = 101;
            tf.delegate = self;
            tf.textAlignment = NSTextAlignmentRight;
            tf.text = _mobile;
            cell.accessoryView = tf;
            
            [tf becomeFirstResponder];
        }
        else
        {
            cell.accessoryView = nil;
            cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
            cell.detailTextLabel.text = _mobile;
        }
    }
    else if (1 == indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:@"uprofile-cell-icon1"];
        cell.textLabel.text = NSLocalizedString(@"车牌:", nil);
        
        if (_isEditingStatus)
        {
            cell.detailTextLabel.text = nil;
            
            UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-130, 51)];
            tf.tag = 102;
            tf.delegate = self;
            tf.textAlignment = NSTextAlignmentRight;
            tf.text = _carNumber;
            cell.accessoryView = tf;
        }
        else
        {
            cell.accessoryView = nil;
            cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
            cell.detailTextLabel.text = _carNumber;
        }
    }
    
    return cell;
}

#pragma mark -

- (void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnEditClick:(UIButton *)sender
{
    _isEditingStatus = YES;
    
    [self.tableView reloadData];
    
    [sender setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(btnSubmitClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnSubmitClick:(UIButton *)sender
{
    _isEditingStatus = NO;
    
    [self.tableView reloadData];
    
    [sender setTitle:NSLocalizedString(@"编辑", nil) forState:UIControlStateNormal];
    [sender addTarget:self action:@selector(btnEditClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (101 == textField.tag)
    {
        self.mobile = textField.text;
    }
    else if (102 == textField.tag)
    {
        self.carNumber = textField.text;
    }
}

@end
