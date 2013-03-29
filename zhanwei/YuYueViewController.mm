//
//  YuYueViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "YuYueViewController.h"
#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"


#import "DataBase.h"
#import "ZhanWeiInfoTableObj.h"

#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"

#import "ZiXunYuYueRequestObj.h"


@interface YuYueViewController ()

@end

@implementation YuYueViewController
@synthesize m_titleLabel;
@synthesize m_gongsimingchengLabel;
@synthesize m_lianxirenField;
@synthesize m_emailField;
@synthesize m_timeField;
@synthesize m_telField;
@synthesize m_nameField;
@synthesize m_countryField;
@synthesize m_beizhuView;
@synthesize m_scrollView;
@synthesize m_dateView;
@synthesize m_dateTableView;
@synthesize m_datePickerTime;
@synthesize m_datePicker;
@synthesize m_zhanweiid;
@synthesize m_tableCellArr;
@synthesize m_alertCommitView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.m_scrollView setContentSize:CGSizeMake(320, 416)];
    [self initInputView];
    self.m_tableCellArr = [[NSMutableArray alloc] init];
    [self.m_datePicker setTimeZone:[NSTimeZone localTimeZone]];
    [self.m_datePickerTime setTimeZone:[NSTimeZone localTimeZone]];
    [self.m_datePicker setDate:[NSDate date]];
    [self.m_datePickerTime setDate:[NSDate date]];
    
    if (!self.m_alertCommitView) {
        self.m_alertCommitView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Data is being submitted, please do not exit the program.\r\n" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        
        UIActivityIndicatorView* actView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        CGRect rect = [actView frame];
        rect.origin = CGPointMake(130, 108);
        actView.frame = rect;
        [self.m_alertCommitView addSubview:actView];
        
        [actView startAnimating];
        
        
        
        [actView release];
    }
    
}

- (void)viewDidUnload
{
    [self setM_titleLabel:nil];
    [self setM_gongsimingchengLabel:nil];
    [self setM_lianxirenField:nil];
    [self setM_emailField:nil];
    [self setM_timeField:nil];
    [self setM_beizhuView:nil];
    [self setM_scrollView:nil];
    [self setM_dateView:nil];
    [self setM_dateTableView:nil];
    [self setM_datePickerTime:nil];
    [self setM_datePicker:nil];
    [self setM_telField:nil];
    [self setM_nameField:nil];
    [self setM_countryField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)textFieldDidBeginEditing:(UITextField *)textField       // return NO to disallow editing.
{
    [self closeDate:nil];
    if (textField == self.m_timeField) 
        [UIView animateWithDuration:0.3 animations:^{
            if (self.m_scrollView.frame.size.height >= 460-44) {
                self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44-246);
            }
            [self.m_scrollView setContentOffset:CGPointMake(0, 120) animated:YES];        
        } completion:^(BOOL finished) {
            
        }];

}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self closeDate:nil];
    [UIView animateWithDuration:0.3 animations:^{
        if (self.m_scrollView.frame.size.height >= 460-44) {
            self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44-246);
        }
        [self.m_scrollView setContentOffset:CGPointMake(0, 180) animated:YES];        
    } completion:^(BOOL finished) {
        
    }];
    
}


- (IBAction)closeDate:(id)sender 
{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:0.3f];
	float width = self.view.frame.size.width;
	float height = self.view.frame.size.height;
	CGRect rect = CGRectMake(0.0f, 460.0f, width, height);
	self.m_dateView.frame = rect;
    [UIView commitAnimations];
}

- (IBAction)makeTrue:(id)sender 
{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:0.3f];
	float width = self.view.frame.size.width;
	float height = self.view.frame.size.height;
	CGRect rect = CGRectMake(0.0f, 460.0f, width, height);
	self.m_dateView.frame = rect;
    [UIView commitAnimations];
    
    NSDateFormatter* dateForm = [[NSDateFormatter alloc] init];
    [dateForm setTimeZone:[NSTimeZone localTimeZone]];
    [dateForm setDateFormat:@"yyyy-MM-dd"];
    NSString* strDate = [dateForm stringFromDate:self.m_datePicker.date];
    
    [dateForm setDateFormat:@"HH:mm:00"];
    NSString* strTime = [dateForm stringFromDate:self.m_datePickerTime.date];
    
    NSString* str = [NSString stringWithFormat:@"%@ %@",strDate,strTime];

    self.m_timeField.text = str;

    [dateForm release];

}

- (IBAction)valueChanger:(id)sender 
{
    
    if (self.m_datePicker.datePickerMode == UIDatePickerModeDate) {
        
        UITableViewCell* temcell = [self.m_tableCellArr objectAtIndex:0];
        
        NSDateFormatter* dateForm = [[NSDateFormatter alloc] init];
        [dateForm setTimeZone:[NSTimeZone localTimeZone]];
        [dateForm setDateFormat:@"yyyy年MM月dd日"];
        NSString* str = [NSString stringWithFormat:@"%@",[dateForm stringFromDate:self.m_datePicker.date]];
        
        UILabel* label = [temcell viewWithTag:1];
        label.text = str;
        
        
    }else if(self.m_datePicker.datePickerMode == UIDatePickerModeTime){
        
        UITableViewCell* temcell = [self.m_tableCellArr objectAtIndex:1];
        
        NSDateFormatter* dateForm = [[NSDateFormatter alloc] init];
        [dateForm setTimeZone:[NSTimeZone localTimeZone]];
        [dateForm setDateFormat:@"HH:mm"];
        NSString* str = [NSString stringWithFormat:@"%@",[dateForm stringFromDate:self.m_datePicker.date]];
        
        
        UILabel* label = [temcell viewWithTag:1];
        label.text = str;
        
    }
    
}

- (IBAction)dateButton:(id)sender 
{
    [self closeIme:nil];
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
	[UIView setAnimationDuration:0.3f];
	float width = self.m_dateView.frame.size.width;
	float height = self.m_dateView.frame.size.height;
	CGRect rect = CGRectMake(0.0f, 115.0, width, height);
	self.m_dateView.frame = rect;
	[UIView commitAnimations];
}

- (IBAction)valueChangerTime:(id)sender 
{
    
    UITableViewCell* temcell = [self.m_tableCellArr objectAtIndex:1];
    
    NSDateFormatter* dateForm = [[NSDateFormatter alloc] init];
    [dateForm setTimeZone:[NSTimeZone localTimeZone]];
    [dateForm setDateFormat:@"HH:mm"];
    NSString* str = [NSString stringWithFormat:@"%@",[dateForm stringFromDate:self.m_datePickerTime.date]];
    
    
    UILabel* label = [temcell viewWithTag:1];
    label.text = str;
    
    
}

- (IBAction)commitAct:(id)sender 
{
    if (self.m_gongsimingchengLabel.text.length <= 0 || self.m_countryField.text.length<=0  || self.m_nameField.text.length<=0 || self.m_telField.text.length<=0 
        || self.m_emailField.text.length <= 0 || self.m_timeField.text.length <= 0) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Some information input is empty!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        return;
    }
    
    
    [self.m_alertCommitView show];
    
    ZiXunYuYueRequestObj* temzixun = [[ZiXunYuYueRequestObj alloc] init];
    temzixun.m_proId = self.m_zhanweiid;
    temzixun.m_company = self.m_gongsimingchengLabel.text;
    
    temzixun.m_country = self.m_countryField.text;
    temzixun.m_name = self.m_nameField.text;
    temzixun.m_tel = self.m_telField.text;
    temzixun.m_email = self.m_emailField.text;
    temzixun.m_todate = self.m_timeField.text;
    temzixun.m_description = self.m_beizhuView.text;
    
    NSString* str = [MyXMLParser EncodeToStr:temzixun Type:@"zwinquiry"];
    [temzixun release];
    
    NSLog(@"zwinquiry str = %@",str);
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveYuYueData:)];
    http.m_recResult = NO;
    [http threadFunStart];
    
    [http release];

}



-(void) receiveYuYueData:(NSData*) data;
{
    [self.m_alertCommitView dismissWithClickedButtonIndex:0 animated:YES];
    if (data) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Appointment successful!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
        [alert release];
        
        NSLog(@"receiveYuYueData  success!");
        
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Appointment failed, please try again!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        NSLog(@"receiveYuYueData  faile!");
    }

    
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self closeIme:nil];
        [self close:nil];
    }else{
        
    }
}

- (IBAction)closeIme:(id)sender 
{
    if (self.m_scrollView.frame.size.height <= 460-44-246) {
        
    [UIView animateWithDuration:0.3 animations:^{

        self.m_scrollView.frame = CGRectMake(0, 44, 320, 460-44);
        [self.m_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        } completion:^(BOOL finished) {
       
    }];
    }
    
    [self.m_gongsimingchengLabel resignFirstResponder]; 
    [self.m_lianxirenField resignFirstResponder];  
    [self.m_emailField resignFirstResponder];  
    [self.m_timeField resignFirstResponder];  
    [self.m_beizhuView resignFirstResponder];  
    [self.m_countryField resignFirstResponder];
    [self.m_telField resignFirstResponder];
    [self.m_nameField resignFirstResponder];
}

-(void) initInputView
{
    
    UIView* topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    topview.backgroundColor = [UIColor clearColor];
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(285, 0, 30, 30)];
    [button setBackgroundImage:[UIImage imageNamed:@"closeime.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(closeIme:) forControlEvents:UIControlEventTouchUpInside];
    [topview addSubview:button]; 
    [button release];
    [self.m_gongsimingchengLabel setInputAccessoryView:topview];

    [self.m_lianxirenField setInputAccessoryView:topview];

    [self.m_emailField setInputAccessoryView:topview];

    [self.m_timeField setInputAccessoryView:topview];

    [self.m_beizhuView setInputAccessoryView:topview];
    
    [self.m_countryField setInputAccessoryView:topview];
    
    [self.m_nameField setInputAccessoryView:topview];
    
    [self.m_telField setInputAccessoryView:topview];
    [topview release];
}

- (IBAction)close:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    [m_titleLabel release];
    [m_gongsimingchengLabel release];
    [m_lianxirenField release];
    [m_emailField release];
    [m_timeField release];
    [m_beizhuView release];
    [m_scrollView release];
    [m_dateView release];
    [m_dateTableView release];
    [m_datePickerTime release];
    [m_datePicker release];
    [m_tableCellArr release];
    
    [m_telField release];
    [m_nameField release];
    [m_countryField release];
    
    [m_alertCommitView release];
    
    [super dealloc];
}


#pragma mark ===table view datasource methods====

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return 2;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 	static NSString *kCellIdentifier = @"cellID";
	
    int row = [indexPath row];
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier] autorelease];
        
        
		cell.accessoryType = UITableViewCellAccessoryNone;
        
        
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 300, 24)];
        label.backgroundColor = [UIColor clearColor];
		label.opaque = NO;
		label.textColor = [UIColor blackColor];
		label.highlightedTextColor = [UIColor whiteColor];
		label.font = [UIFont boldSystemFontOfSize:20];
		label.textAlignment = UITextAlignmentCenter;
        label.tag = 1;
        
        NSDateFormatter* dateForm = [[NSDateFormatter alloc] init];
        [dateForm setTimeZone:[NSTimeZone localTimeZone]];
        
        if(0 == row){
            [dateForm setDateFormat:@"yyyy年MM月dd日"];
            NSString* str = [NSString stringWithFormat:@"%@",[dateForm stringFromDate:[NSDate date]]];
            
            label.text = str;
        }else{
            [dateForm setDateFormat:@"HH:mm"];
            NSString* str = [NSString stringWithFormat:@"%@",[dateForm stringFromDate:[NSDate date]]];
            
            label.text = str;
        }
        [cell addSubview:label];
        
        [self.m_tableCellArr addObject:cell];
        
    }
    
	return cell;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{

	int row = indexPath.row;
    //日期
    if(0 == row){
        
        [self.m_datePickerTime setHidden:YES];
        [self.m_datePicker setHidden:NO];
        
    }//时间
    else{
        [self.m_datePickerTime setHidden:NO];
        [self.m_datePicker setHidden:YES];

    }

}



@end
