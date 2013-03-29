//
//  YuYueViewController.h
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YuYueViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *m_titleLabel;
@property (retain, nonatomic) IBOutlet UITextField *m_gongsimingchengLabel;
@property (retain, nonatomic) IBOutlet UITextField *m_lianxirenField;
@property (retain, nonatomic) IBOutlet UITextField *m_emailField;
@property (retain, nonatomic) IBOutlet UITextField *m_timeField;
@property (retain, nonatomic) IBOutlet UITextField *m_telField;
@property (retain, nonatomic) IBOutlet UITextField *m_nameField;
@property (retain, nonatomic) IBOutlet UITextField *m_countryField;
@property (retain, nonatomic) IBOutlet UITextView *m_beizhuView;

@property (retain, nonatomic) IBOutlet UIScrollView *m_scrollView;
@property (retain, nonatomic) IBOutlet UIView *m_dateView;
@property (retain, nonatomic) IBOutlet UITableView *m_dateTableView;
@property (retain, nonatomic) IBOutlet UIDatePicker *m_datePickerTime;
@property (retain, nonatomic) IBOutlet UIDatePicker *m_datePicker;

@property (nonatomic,retain)UIAlertView* m_alertCommitView;


@property (nonatomic,retain)NSMutableArray* m_tableCellArr;
@property (nonatomic,retain)NSString* m_zhanweiid;

- (IBAction)closeDate:(id)sender;
- (IBAction)makeTrue:(id)sender;
- (IBAction)valueChangerTime:(id)sender;
- (IBAction)valueChanger:(id)sender;
- (IBAction)dateButton:(id)sender;

- (IBAction)commitAct:(id)sender;

- (IBAction)closeIme:(id)sender ;
- (IBAction)close:(id)sender;
-(void) initInputView;

-(void) receiveYuYueData:(NSData*) data;

@end
