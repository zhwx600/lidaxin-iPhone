//
//  DiaoChaoCommitViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaoChaTableObj.h"
#import "DiaoChanDetailTableObj.h"

@interface DiaoChaoCommitViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIAlertViewDelegate>
{
    int m_selectIndex;
    
    NSMutableArray* m_typeDataArray;
    NSMutableArray* m_proDataArray;
    NSMutableArray* m_selectItemArray;
    
    
}

@property (assign)BOOL isOpen;
@property (nonatomic,retain)NSIndexPath *m_typeSelectIndex;


@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UITableView *m_tableView;
@property (retain, nonatomic) IBOutlet UITextView *m_textView;

@property (retain, nonatomic) IBOutlet UITableViewCell *m_sugestCell;
@property (nonatomic,retain)NSMutableArray* m_tableArray;

@property (nonatomic,retain)NSString* m_diaochaId;
@property (nonatomic,retain)DiaoChaTableObj* m_diaochaObj;

@property (nonatomic,retain)UIAlertView* m_alertCommitView;

-(void) initInputView;
- (IBAction)closeButton:(id)sender;
- (IBAction)commit:(id)sender;
- (IBAction)closeIme:(id)sender;

-(void) receiveDiaochaData:(NSData*) data;

@end
