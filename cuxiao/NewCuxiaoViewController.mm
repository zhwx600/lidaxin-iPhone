//
//  NewCuxiaoViewController.m
//  lidaxin-iPhone
//
//  Created by zheng wanxiang on 13-3-9.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "NewCuxiaoViewController.h"
#import "xmlCommand.h"
#import "Cell1.h"
#import "Cell2.h"
#import "GGlobal.h"
#import "DataBase.h"
#import "CanZhanReleaseTableObj.h"


#import "GGlobal.h"
#import "DataBase.h"
#import "ZhanWeiProTableObj.h"
#import "ImageTableObj.h"
#import "CanZhanTableObj.h"

#import "ProductDetailViewController.h"
#include "ZhwxDefine.h"

@implementation NewCuxiaoViewController
@synthesize m_viewTitle;
@synthesize expansionTableView;
@synthesize m_type;
@synthesize m_titleStr;
@synthesize m_proObj;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

    //[self.expansionTableView setFrame:CGRectMake(0, 44, 320, DEV_FULLSCREEN_FRAME.size.height-44-20)];
    self.expansionTableView.backgroundColor = [UIColor clearColor];
    self.expansionTableView.separatorColor = [UIColor clearColor];
    self.expansionTableView.sectionFooterHeight = 0;
    self.expansionTableView.sectionHeaderHeight = 0;
    self.m_viewTitle.text = self.m_titleStr;
    
    [self initData];
    
}

- (void)viewDidUnload
{
    [self setM_viewTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void) dealloc
{
    self.expansionTableView = nil;

    [m_type release];
    [m_typeDataArray release];
    //[m_proDataArray release];
    [m_allProObj release];
    [m_titleStr release];
    [m_viewTitle release];
    [super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) initData
{
    
    if (0 != [self.m_type compare:@"展品"]) {
        
        NSArray* array = [DataBase getSomeCanZhanReleaseTableObjByType:self.m_type];
        
        m_allProObj = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSComparisonResult result = [@(((CanZhanReleaseTableObj*)obj1).m_order) compare:@(((CanZhanReleaseTableObj*)obj2).m_order)];
            return result == NSOrderedDescending; // 升序
            //return result == NSOrderedAscending;  // 降序
        }]];
        
        if (m_allProObj && m_allProObj.count<=0) {
            m_typeDataArray = nil;
            return;
        }
        

        
        if (m_typeDataArray) {
            [m_typeDataArray release];
            m_typeDataArray = nil;
        }
        m_typeDataArray = [[NSMutableArray alloc] init];
        //获取 类型shuzu
        for (int i=0; i<m_allProObj.count; i++) {
            CanZhanReleaseTableObj* proObj = [m_allProObj objectAtIndex:i];
            
            NSString* imageid = proObj.m_imageId;
            ImageTableObj* imageObj = [DataBase getOneImageTableInfoImageid:imageid];
            
            if (!imageObj) {
                continue;
            }
            
            if (m_typeDataArray.count>0) {
                BOOL haveSame = NO;
                for (int j=0; j<m_typeDataArray.count; j++) {
                    
                    if (0 == [imageObj.m_imageType compare:((ImageTableObj*)[m_typeDataArray objectAtIndex:j]).m_imageType]) {
                        haveSame = YES;
                        break;
                    }else{
                        haveSame = NO;
                        // [typeArr addObject:imageObj];
                    }
                }
                if (!haveSame) {
                    [m_typeDataArray addObject:imageObj];
                }
                
                
            }else{
                [m_typeDataArray addObject:imageObj];
            } 
        }

        
        //展品 
    }else{
    
        NSArray* array = [DataBase getSomeZhanWeiProTableInfoZWId:self.m_proObj.m_canzhanId];
        m_allProObj = [[NSMutableArray alloc] initWithArray:[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            NSComparisonResult result = [@(((CanZhanReleaseTableObj*)obj1).m_order) compare:@(((CanZhanReleaseTableObj*)obj2).m_order)];
            return result == NSOrderedDescending; // 升序
            //return result == NSOrderedAscending;  // 降序
        }]];
        //m_allProObj = [[NSMutableArray alloc] initWithArray:[DataBase getSomeZhanWeiProTableInfoZWId:self.m_proObj.m_canzhanId]];
        
        if (m_allProObj && m_allProObj.count<=0) {
            m_typeDataArray = nil;
            return;
        }
        
        if (m_typeDataArray) {
            [m_typeDataArray release];
            m_typeDataArray = nil;
        }
        m_typeDataArray = [[NSMutableArray alloc] init];
        //获取 类型shuzu
        for (int i=0; i<m_allProObj.count; i++) {
            ZhanWeiProTableObj* proObj = [m_allProObj objectAtIndex:i];
            
            NSString* imageid = proObj.m_showProImageId;
            ImageTableObj* imageObj = [DataBase getOneImageTableInfoImageid:imageid];
            if (!imageObj) {
                continue;
            }
            if (m_typeDataArray.count>0) {
                
                BOOL haveSame = NO;
                for (int j=0; j<m_typeDataArray.count; j++) {
                    
                    if (0 == [imageObj.m_imageType compare:((ImageTableObj*)[m_typeDataArray objectAtIndex:j]).m_imageType]) {
                        haveSame = YES;
                        break;
                    }else{
                        haveSame = NO;
                        // [typeArr addObject:imageObj];
                    }
                }
                if (!haveSame) {
                    [m_typeDataArray addObject:imageObj];
                }
                
            }else{
                [m_typeDataArray addObject:imageObj];
            }
        }

    }
    
      
    [self.expansionTableView reloadData];
    
}

- (IBAction)close:(id)sender 
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [m_typeDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ImageTableObj* tempro = [m_typeDataArray objectAtIndex:section];
    if (tempro.m_bIsOpen) {
        return tempro.m_typeProArray.count+1;
    }
    return 1;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 40;
    }else {
        return 75;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageTableObj* typeImage = [m_typeDataArray objectAtIndex:indexPath.section];
    if (typeImage.m_bIsOpen && indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
//             cell.selectedBackgroundView = [[UIImageView alloc] initWithFrame:cell.frame];
//             cell.selectedBackgroundView.backgroundColor = [UIColor redColor];
           // cell.selectedBackgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default.png"]] autorelease];
            CGRect rect = cell.titleLabel.frame;
            rect.origin.y += 10;
            
            [cell.titleLabel setFrame:rect];
            
            cell.backgroundView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"横条2.png"]] autorelease];
            
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            
        }

        if (0 != [self.m_type compare:@"展品"]) {
        
            
            
            CanZhanReleaseTableObj* tempro = (CanZhanReleaseTableObj*)[typeImage.m_typeProArray objectAtIndex:indexPath.row-1];
            ImageTableObj* selectimageobj = [DataBase getOneImageTableInfoImageid:tempro.m_imageId];
            NSString* path = [DataProcess getImageFilePathByUrl:selectimageobj.m_imageUrl];
            UIImage* temaa = [UIImage imageWithContentsOfFile:path];
            UIImage* image = [temaa imageByScalingProportionallyToSize:cell.m_cellImageView.frame.size];
            
            NSLog(@"framg1 = %f,%f , framg2 = %f,%f.",temaa.size.height,temaa.size.width,image.size.height,image.size.width);
            
            
            cell.m_cellImageView.image = image;
          //  cell.titleLabel.text = tempro.m_productCls;
            
            @try {
                NSArray* temarr = [selectimageobj.m_imageDescription componentsSeparatedByString:PARAM_SPARETESTR];
                cell.titleLabel.text = [temarr objectAtIndex:0];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }else{
            ImageTableObj* typeImage = [m_typeDataArray objectAtIndex:indexPath.section];
            ZhanWeiProTableObj* tempro = (ZhanWeiProTableObj*)[typeImage.m_typeProArray objectAtIndex:indexPath.row-1];
            ImageTableObj* selectimageobj = [DataBase getOneImageTableInfoImageid:tempro.m_showProImageId];
            NSString* path = [DataProcess getImageFilePathByUrl:selectimageobj.m_imageUrl];
            UIImage* image = [UIImage imageWithContentsOfFile:path];
            UIImage* teimage = [image imageByScalingProportionallyToSize:cell.m_cellImageView.frame.size];
            cell.m_cellImageView.image = teimage;
            //cell.titleLabel.text = tempro.m_changjingDescription;
            
            @try {
                NSArray* temarr = [selectimageobj.m_imageDescription componentsSeparatedByString:PARAM_SPARETESTR];
                cell.titleLabel.text = [temarr objectAtIndex:0];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }

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
        
        
        ImageTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
        //ImageTableObj* selectimageobj = [DataBase getOneImageTableInfoImageid:tempro.m_imageId];
        
        cell.titleLabel.text = tempro.m_imageType;
        
//        if (0 != [self.m_type compare:@"展品"]) {
//        
//            ImageTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
//            //ImageTableObj* selectimageobj = [DataBase getOneImageTableInfoImageid:tempro.m_imageId];
//
//            cell.titleLabel.text = tempro.m_imageType;
//            
//        }else{
//            ZhanWeiProTableObj* tempro = [m_typeDataArray objectAtIndex:indexPath.section];
//            ImageTableObj* selectimageobj = [DataBase getOneImageTableInfoImageid:tempro.m_showProImageId];
//            
//            cell.titleLabel.text = selectimageobj.m_imageType;
//        }
        [cell changeArrowWithUp:(typeImage.m_bIsOpen?YES:NO)];
        return cell;
    }
}


#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int intaw = indexPath.row;
    if (indexPath.row == 0) {
        
        ImageTableObj* typeImage = [m_typeDataArray objectAtIndex:indexPath.section];
        
        if (typeImage.m_bIsOpen) {
            typeImage.m_bIsOpen = NO;
            [self didSelectCellRowFirstDo:NO nextDo:NO Index:indexPath];
            
        }else
        {

            [self didSelectCellRowFirstDo:YES nextDo:NO Index:indexPath];

        }
        
    }else
    {
//        NSDictionary *dic = [_dataList objectAtIndex:indexPath.section];
//        NSArray *list = [dic objectForKey:@"list"];
//        NSString *item = [list objectAtIndex:indexPath.row-1];
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"sdfasdasdfsadaf" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil] autorelease];
//        [alert show];
        ImageTableObj* typeImage = [m_typeDataArray objectAtIndex:indexPath.section];
        if (0 != [self.m_type compare:@"展品"]) {
            
            CanZhanReleaseTableObj* tempro = [typeImage.m_typeProArray objectAtIndex:indexPath.row-1];
            ProductDetailViewController* temProView = [[ProductDetailViewController alloc] init];
            temProView.m_proObj = tempro;
            [self.navigationController pushViewController:temProView animated:YES];
            [temProView release];
        }else{
            ZhanWeiProTableObj* tempro = [typeImage.m_typeProArray objectAtIndex:indexPath.row-1];
            ProductDetailViewController* temProView = [[ProductDetailViewController alloc] init];
            temProView.m_zhanweiproObj = tempro;
            [self.navigationController pushViewController:temProView animated:YES];
            [temProView release];
        }
        
        
        
        
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didSelectCellRowFirstDo:(BOOL)firstDoInsert nextDo:(BOOL)nextDoInsert Index:(NSIndexPath*) sIndex
{

    ImageTableObj* typeImage = [m_typeDataArray objectAtIndex:sIndex.section];
    typeImage.m_bIsOpen = firstDoInsert;
    
    Cell1 *cell = (Cell1 *)[self.expansionTableView cellForRowAtIndexPath:sIndex];
    [cell changeArrowWithUp:firstDoInsert];
    
    [self.expansionTableView beginUpdates];
    
    
    
    if (typeImage.m_typeProArray) {
        typeImage.m_typeProArray = nil;
    }
    typeImage.m_typeProArray = [[NSMutableArray alloc] init];
    
    
    if (0 != [m_type compare:@"展品"]) {
    
        for (int i=0; i<m_allProObj.count; i++) {
            
            CanZhanReleaseTableObj* proobj = [m_allProObj objectAtIndex:i];
            ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:proobj.m_imageId];
            
            if (0 == [imageobj.m_imageType compare:typeImage.m_imageType]) {
                
                [typeImage.m_typeProArray addObject:proobj];                
                
                
            }
            
        }
    }else{
        for (int i=0; i<m_allProObj.count; i++) {
            
            ZhanWeiProTableObj* proobj = [m_allProObj objectAtIndex:i];
            ImageTableObj* imageobj = [DataBase getOneImageTableInfoImageid:proobj.m_showProImageId];
            
            if (0 == [imageobj.m_imageType compare:typeImage.m_imageType]) {
                
                [typeImage.m_typeProArray addObject:proobj];
                
                
            }
            
        }
    }
    
//    int contentCount = [[[_dataList objectAtIndex:section] objectForKey:@"list"] count];
    
    int contentCount = typeImage.m_typeProArray.count;
    
	NSMutableArray* rowToInsert = [[NSMutableArray alloc] init];
	for (NSUInteger i = 1; i < contentCount + 1; i++) {
		NSIndexPath* indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:sIndex.section];
		[rowToInsert addObject:indexPathToInsert];
	}
	
	if (firstDoInsert)
    {   [self.expansionTableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
	else
    {
        [self.expansionTableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
	[rowToInsert release];
	
	[self.expansionTableView endUpdates];
    if (nextDoInsert) {
        typeImage.m_bIsOpen = YES;
        [self didSelectCellRowFirstDo:YES nextDo:NO Index:sIndex];
    }
    if (typeImage.m_bIsOpen) [self.expansionTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
}



@end
