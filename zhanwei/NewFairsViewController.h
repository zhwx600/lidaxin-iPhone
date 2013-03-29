//
//  NewFairsViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 13-3-13.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewFairsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray* m_typeDataArray;
    NSMutableArray* m_proDataArray;
    NSMutableArray* m_allProObj;
    
    
}

@property (retain, nonatomic) IBOutlet UILabel *m_viewTitle;
@property (nonatomic,retain)IBOutlet UITableView *expansionTableView;
@property (nonatomic,retain)NSString* m_type;
@property (retain, nonatomic)NSString *m_titleStr;

-(void) initData;
- (IBAction)close:(id)sender;

@end

