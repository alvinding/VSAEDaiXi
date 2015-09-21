//
//  VSAAddressListController.m
//  VSAEDai
//
//  Created by alvin on 15/9/18.
//  Copyright © 2015年 alvin. All rights reserved.
//

#import "VSAAddressListController.h"
#import "VSAAddressListCell.h"
#import "VSALocationTool.h"
#import "VSAEditLocationController.h"

@interface VSAAddressListController ()
@property (nonatomic, weak) VSAAddressListCell *listCell;
@property (nonatomic, strong) NSMutableArray *locations;
@end

@implementation VSAAddressListController

#pragma mark - 懒加载
- (NSMutableArray *)locations {
    if (!_locations) {
        _locations = (NSMutableArray *)[VSALocationTool locations];
    }
    
    return _locations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addBtnClick)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    self.locations = nil;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 监听事件
- (void)addBtnClick {
    NSLog(@"add addr");
    //push一个view,编辑地址信息
    VSAEditLocationController *editVC = [[VSAEditLocationController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.locations.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.listCell) {
        return self.listCell.height;
    }
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VSALocation *location = self.locations[indexPath.row];
    
    static NSString *identifier = @"addressListCell";
    VSAAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [VSAAddressListCell addressListCell];
        cell.location = location;
        self.listCell = cell;
    }
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:  forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
