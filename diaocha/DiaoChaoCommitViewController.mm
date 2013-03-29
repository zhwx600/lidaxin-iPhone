//
//  DiaoChaoCommitViewController.m
//  lidaxin-iPhone
//
//  Created by apple on 12-11-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiaoChaoCommitViewController.h"

#import "IDispatcher.h"
#import "HttpProcessor.h"
#import "xmlparser.h"
#import "xmlCommand.h"
#import "Cell1.h"
#import "Cell2.h"
#import "GGlobal.h"
#import "DataBase.h"

#import "ZiXunYuYueRequestObj.h"

#import "DiaoChaTableObj.h"
#import "DiaoChaItemTableObj.h"
#import "DiaoChanDetailTableObj.h"


@interface DiaoChaoCommitViewController ()

@end

@implementation DiaoChaoCommitViewController
@synthesize m_titleLabel;
@synthesize m_tableView;
@synthesize m_textView;
@synthesize m_sugestCell;
@synthesize m_tableArray;
@synthesize m_diaochaId;
@synthesize m_diaochaObj;
@synthesize m_typeSelectIndex,isOpen,m_alertCommitView;

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

    self.m_tableView.backgroundColor = [UIColor clearColor];
    self.m_tableView.separatorColor = [UIColor clearColor];
    
    m_typeDataArray = [[NSMutableArray alloc] initWithArray:[DataBase getOneDiaochaItemInfoByDiaochaId:self.m_diaochaId]];
    
    
    for (int i=0; i<m_typeDataArray.count; i++) {
        
        DiaoChaItemTableObj* tem = [m_typeDataArray objectAtIndex:i];
        
         tem.m_itemArray = [[NSMutableArray alloc] initWithArray:[DataBase getSomeDiaoChaDetailTableObjById:tem.m_diaochaItemId]];
    }
    
    
   // m_selectItemArray = [[NSMutableArray alloc] initWithArray:m_typeDataArray];
    
    
    DiaoChaItemTableObj* temSuggest = [[DiaoChaItemTableObj alloc] init];
    temSuggest.m_diaochaQuestion = @"Suggestion";
    [m_typeDataArray addObject:temSuggest];
    [temSuggest release];
    
//    UIImageView* imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"room_left.png"]];
//    UITableView * tableTemp=self.m_tableView;
//    [tableTemp setSeparatorColor:[UIColor colorWithWhite:0.5 alpha:0.6]];
//    [tableTemp setBackgroundView:imageview];
//    [imageview release];
    
    
//    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];  
//    [topView setBarStyle:UIBarStyleBlackTranslucent];  
//
//    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];  
//    
//    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完 成" style:UIBarButtonItemStyleDone target:self action:@selector(closeIme:)];  
//    
//    
//    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];  
//    [doneButton release];  
//    [btnSpace release];  
//    
//    [topView setItems:buttonsArray];  
//    [self.m_textView setInputAccessoryView:topView];
//    [topView release];
    
    [self initInputView];
    
    
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
    [self setM_tableView:nil];
    [self setM_sugestCell:nil];
    [self setM_textView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [m_titleLabel release];
    [m_tableView release];
    [m_sugestCell release];
    [m_textView release];
    
    

    self.isOpen = NO;
    [m_selectItemArray release];
    [m_typeDataArray release];
    [m_proDataArray release];
    [m_alertCommitView release];
    
    [super dealloc];
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
    [self.m_textView setInputAccessoryView:topview];
    [topview release];
}



- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.m_tableView.frame.size.height >= 460-44) {
            self.m_tableView.frame = CGRectMake(0, 44, 320, 460-44-246);
        }
        NSIndexPath* index = [NSIndexPath indexPathForRow:1 inSection:[m_typeDataArray count]-1];
        
        @try {
            [self.m_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        @catch (NSException *exception) {
            NSLog(@"UITableViewScrollPositionBottom  异常");
        }
        @finally {
            
        }
        
        
        
        
    } completion:^(BOOL finished) {
        
    }];
   
   }

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}


//
//#pragma mark - TableView*
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (0 == indexPath.section) {
//        return 44;
//    }
//    return 107;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if (0 == section) {
//        if (self.m_tableArray && self.m_tableArray.count >0) {
//            return self.m_tableArray.count;
//        }
//        return 0;
//    }else {
//        return 1;
//    }
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell* cell = nil;
//    if (0 == indexPath.section) {
//       
//        static NSString* cellid=@"celldiaocha";
//        
//        cell  =(UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellid];
//        
//        if (cell==nil) {
//            cell=[[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid]autorelease];
//
//        }
//        DiaoChanDetailTableObj* temobj = [self.m_tableArray objectAtIndex:indexPath.row];
//        
//        
//        cell.textLabel.text = temobj.m_diaochaContent;
//        
//        
//        return cell;
//   }else {
//       
//       cell= self.m_sugestCell;
//       
//   }
//    
//    return cell;
//}
//
//
//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{ 
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    if (indexPath.section == 0) {
//        UITableViewCell* cell = nil;
//        for (int i=0; i<self.m_tableArray.count; i++) {
//            NSIndexPath* temindex = [NSIndexPath indexPathForRow:i inSection:0];
//            cell = [tableView cellForRowAtIndexPath:temindex];
//            cell.accessoryType = UITableViewCellAccessoryNone;
//        }
//        
//        m_selectIndex = indexPath.row;
//        cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//        
//    }
//
//}
//
//
//






#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_typeDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section+1 < [m_typeDataArray count]) {
        
        DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex:section];
        if (tempro.m_bIsOpen) {
            return tempro.m_itemArray.count+1;;
//            if (self.m_typeSelectIndex.section == section) {
//
//                return tempro.m_itemArray.count+1;;
//            }
        }
        return 1;
    }else {
        return 1+1;
    }
    
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section+1 == [m_typeDataArray count]) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 107;
        }
    }else {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 50;
        }
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section+1 < [m_typeDataArray count]) {
        
        DiaoChaItemTableObj* temproTT = [m_typeDataArray objectAtIndex:indexPath.section];
        
        if (temproTT.m_bIsOpen && indexPath.row!=0) {
            static NSString *CellIdentifier = @"Cell2";
            Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
                //             cell.selectedBackgroundView = [[UIImageView alloc] initWithFrame:cell.frame];
                //             cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
                // cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] autorelease];
                cell.accessoryType = UITableViewCellAccessoryNone;
                CGRect rect = cell.titleLabel.frame;
                rect.origin.x -= 50;
                
                [cell.titleLabel setFrame:rect];
                
                UIImageView* selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(250, 10, 32, 32)];
                selectImage.image = [UIImage imageNamed:@"选中图标.png"];
                [cell addSubview:selectImage];
                selectImage.tag = 10;
                [selectImage release];
                
                
                cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条2.png"]] autorelease];
                cell.titleLabel.textColor = [UIColor whiteColor];

                
                cell.selectionStyle = UITableViewCellSelectionStyleGray;

                
                
            }
            DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
            DiaoChanDetailTableObj* temDaoDetail = (DiaoChanDetailTableObj*)[tempro.m_itemArray objectAtIndex:indexPath.row-1];

            
            NSString* temdetailId = tempro.m_selectDidaoDetailId;
            
            cell.titleLabel.text = temDaoDetail.m_diaochaContent;
            
            UIImageView* temview = (UIImageView*)[cell viewWithTag:10];
            if (temdetailId && temdetailId.length > 0) {
                 
                if (0 == [temDaoDetail.m_detailId compare:temdetailId]) {
                    [temview setHidden:NO];
                }else {
                    [temview setHidden:YES];
                }
                
            }else {
                [temview setHidden:YES];
            }
            
            
            return cell;
        }else
        {
            static NSString *CellIdentifier = @"Cell1";
            Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
                cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条1.png"]] autorelease];
                cell.titleLabel.textColor = [UIColor whiteColor];
                
            }

            [cell.arrowImageView setHidden:NO];
            DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];

            cell.titleLabel.text = tempro.m_diaochaQuestion;
            [cell changeArrowWithUp:(tempro.m_bIsOpen?YES:NO)];
            return cell;
        }
    }else {
        
        UITableViewCell* cell = nil;
        if (0 == indexPath.row) {

            
            static NSString *CellIdentifier = @"CellSuggest";
            Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"Cell1" owner:self options:nil] objectAtIndex:0];
                [cell.arrowImageView setHidden:YES];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条1.png"]] autorelease];
                cell.titleLabel.textColor = [UIColor whiteColor];
                
            }

            DiaoChaItemTableObj* temobj = [m_typeDataArray objectAtIndex:indexPath.section];
            
            
            cell.titleLabel.text = temobj.m_diaochaQuestion;
            
            
            return cell;
       }else {
           
           cell= self.m_sugestCell;
           cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条2.png"]] autorelease];
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
           
       }
        
        return cell;
        
        
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section+1 < [m_typeDataArray count]) {
    
        int intaw = indexPath.row;
        if (indexPath.row == 0) {
            DiaoChaItemTableObj* temproTT = [m_typeDataArray objectAtIndex:indexPath.section];
            if (temproTT.m_bIsOpen) {
                temproTT.m_bIsOpen = NO;
                [self didSelectCellRowFirstDo:NO nextDo:NO Index:indexPath];
                self.m_typeSelectIndex = nil;
                
            }else
            {
                if (YES) {
                    self.m_typeSelectIndex = indexPath;
                    [self didSelectCellRowFirstDo:YES nextDo:NO Index:indexPath];
                    
                }else
                {
                    
                    [self didSelectCellRowFirstDo:NO nextDo:YES Index:indexPath];
                }
            }
            
        }else
        {
            //        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
            //        NSArray *list = [dic objectForKey:@"list"];
            //        NSString *item = [list objectAtIndex:indexPath.row-1];
            //        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"sdfasdasdfsadaf" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil] autorelease];
            //        [alert show];
            
            DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
            DiaoChanDetailTableObj* temDaoDetail = (DiaoChanDetailTableObj*)[tempro.m_itemArray objectAtIndex:indexPath.row-1];
            
            
            
            tempro.m_selectDidaoDetailId = temDaoDetail.m_detailId;
            
            [tableView reloadData];
            self.m_tableView.frame = CGRectMake(0, 44, 320, 460-44);
        }
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }else {
        
        
        
    }
}

- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert Index:(NSIndexPath*) sIndex
{
    int section = sIndex.section;

    DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex: section];
    tempro.m_bIsOpen = firstDoInsert;
    
    Cell1 *cell = (Cell1 *)[self.m_tableView cellForRowAtIndexPath:sIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.m_tableView beginUpdates];
    

    
    if (tempro.m_itemArray) {
        [tempro.m_itemArray release];
        tempro.m_itemArray = nil;
    }
    tempro.m_itemArray = [[NSMutableArray alloc] initWithArray:[DataBase getSomeDiaoChaDetailTableObjById:tempro.m_diaochaItemId]];
    
       
    //    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
    
    int contentCount = tempro.m_itemArray.count;
    
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.m_tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.m_tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	[rowToInsert release];
	
	[self.m_tableView endUpdates];
    if (nextDoInsert) {
        tempro.m_bIsOpen = YES;
        self.m_typeSelectIndex = [self.m_tableView indexPathForSelectedRow];
        [self didSelectCellRowFirstDo:YES nextDo:NO Index:sIndex];
    }
    if (tempro.m_bIsOpen) [self.m_tableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}








- (IBAction)closeButton:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) callCommitDataOnMainThread
{
    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Upgrade tips" message:@"Network connection fails, make sure the network is functioning properly." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
}

- (IBAction)commit:(id)sender
{
    if (m_typeDataArray.count <= 0) {
        return;
    }
    bool bTestAll = true;
    //少了 最后 一个建议的 选项
    for (int i=0; i<m_typeDataArray.count-1; i++) {
        
        DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex: i];
        if (!tempro.m_selectDidaoDetailId || tempro.m_selectDidaoDetailId.length<=0) {
            bTestAll = false;
            break;
        }
    }
    
    if (!bTestAll) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select all evaluation!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        
        return;
    }
    
    if (!self.m_textView.text || self.m_textView.text.length <= 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Some information input is empty!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
        return;
    }
    
    
    [self.m_alertCommitView show];

    
    
    ZiXunYuYueRequestObj* temzixun = [[ZiXunYuYueRequestObj alloc] init];
    

    NSMutableString* tem1 = [[NSMutableString alloc] init];
    NSMutableString* tem2 = [[NSMutableString alloc] init];
    NSMutableString* tem3 = [[NSMutableString alloc] init];
    
    for (int i=0; i<m_typeDataArray.count-1; i++) {
        
        DiaoChaItemTableObj* tempro = [m_typeDataArray objectAtIndex: i];

        [tem1 appendString:tempro.m_diaochaId];
        [tem2 appendString:tempro.m_diaochaItemId];
        [tem3 appendString:tempro.m_selectDidaoDetailId];
        if (i < m_typeDataArray.count-2) {
            [tem1 appendString:@","];
            [tem2 appendString:@","];
            [tem3 appendString:@","];
        }
        
        
    }
        
    temzixun.m_fromid = tem1;
    temzixun.m_dcId = tem2;
    temzixun.m_selId = tem3;
    temzixun.m_description = self.m_textView.text;
    
    [tem1 release];
    [tem2 release];
    [tem3 release];
    
    NSString* str = [MyXMLParser EncodeToStr:temzixun Type:@"looksubmit"];
    [temzixun release];
    
    NSLog(@"looksubmit str = %@",str);
    
    NSData* data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    HttpProcessor* http = [[HttpProcessor alloc] initWithBody:data main:self Sel:@selector(receiveDiaochaData:)];
    http.m_recResult = NO;
    [http threadFunStart];
    
    [http release];
    
}


-(void) receiveDiaochaData:(NSData*) data
{
    [self.m_alertCommitView dismissWithClickedButtonIndex:0 animated:YES];
    if (data) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Submit the survey successfully." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1;
        [alert show];
        [alert release];
        
        NSLog(@"commit:(id)sender  success!");
       
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Failed to submit survey,please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 0;
        [alert show];
        [alert release];
         NSLog(@"commit:(id)sender  faile!");
    }
   
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        [self closeIme:nil];
        [self closeButton:nil];
    }else{
        
    }
}

- (IBAction)closeIme:(id)sender 
{
    [UIView animateWithDuration:0.3 animations:^{
        if (self.m_tableView.frame.size.height <= 460-44-246) {
            self.m_tableView.frame = CGRectMake(0, 44, 320, 460-44);
        }
        NSIndexPath* index = [NSIndexPath indexPathForRow:0 inSection:1];
        @try {
            [self.m_tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
        @catch (NSException *exception) {
            NSLog(@"scrollToRowAtIndexPath:index atScrollPos  异常");
        }
        @finally {
            
        }

        
        
        
        
    } completion:^(BOOL finished) {
        
    }];

    [self.m_textView resignFirstResponder];    
}
@end
