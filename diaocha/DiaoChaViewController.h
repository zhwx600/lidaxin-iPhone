//
//  DiaoChaViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-10-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFolderTableView.h"

@interface DiaoChaViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) UITableView *m_tableView;
@property (nonatomic) BOOL m_refreshing;
@property (assign,nonatomic) NSInteger m_page;
@property (nonatomic,retain) NSMutableArray* m_tableArray;

- (IBAction)colseButton:(id)sender;

@end
