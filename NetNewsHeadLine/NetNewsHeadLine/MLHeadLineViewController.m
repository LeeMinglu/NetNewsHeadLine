//
//  MLHeadLineViewController.m
//  NetNewsHeadLine
//
//  Created by 李明禄 on 15/11/22.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLineViewController.h"

@interface MLHeadLineViewController ()

@end

@implementation MLHeadLineViewController

static NSString * const ID = @"headline";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
   
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@...%td",self.title, indexPath.row];
    
    return cell;
}


@end
