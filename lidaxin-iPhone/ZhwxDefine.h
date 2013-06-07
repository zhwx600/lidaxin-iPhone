//
//  ZhwxDefine.h
//  lidaxin-iPhone
//
//  Created by zhwx on 13-6-7.
//
//

#ifndef lidaxin_iPhone_ZhwxDefine_h
#define lidaxin_iPhone_ZhwxDefine_h


//是否 iphone5
#define isRetina5inch (fabs(( double)[[ UIScreen mainScreen] bounds].size.height-( double )568) < DBL_EPSILON)

#define autoRetina5Frame(rect1,rect2) isRetina5inch ? rect1:rect2


//设备全屏
#define DEV_FULLSCREEN_FRAME [[ UIScreen mainScreen] bounds]
#pragma mark- 设备竖屏

//横屏竖屏
#define DEV_FULLSCREEN_Vertical_FOR_4_FRAME CGRectMake(0, 0, 320, 480)
#define DEV_FULLSCREEN_Vertical_FOR_5_FRAME CGRectMake(0, 0, 320, 568)

//无nav 和 无状态栏  frame
#define DEV_NO_NAV_VIEW_FRAME CGRectMake(0, 0, DEV_FULLSCREEN_FRAME.size.width, DEV_FULLSCREEN_FRAME.size.height-20)
//有nav 和 无状态栏  frame
#define DEV_HAVE_NAV_VIEW_FRAME CGRectMake(0, 0, 320, DEV_FULLSCREEN_FRAME.size.height-44-20)
//有nav 、有table、 无状态栏  frame
#define DEV_HAVE_TABLE_VIEW_FRAME CGRectMake(0, 0, 320, DEV_FULLSCREEN_FRAME.size.height-44-49-20)

#pragma mark- 设备横屏
//横屏全屏
#define DEV_FULLSCREEN_Horizontal_FOR_4_FRAME CGRectMake(0, 0, 480, 320)
#define DEV_FULLSCREEN_Horizontal_FOR_5_FRAME CGRectMake(0, 0, 568, 320)



//无nav 和 无状态栏  frame
#define DEV_NO_NAV_VIEW_Horizontal_FRAME CGRectMake(0, 0, DEV_FULLSCREEN_FRAME.size.width, DEV_FULLSCREEN_FRAME.size.height-20)
//有nav 和 无状态栏  frame
#define DEV_HAVE_NAV_VIEW_Horizontal_FRAME CGRectMake(0, 0, DEV_FULLSCREEN_FRAME.size.width, DEV_FULLSCREEN_FRAME.size.height-44-20)
//有nav 、有table、 无状态栏  frame
#define DEV_HAVE_TABLE_VIEW_Horizontal_FRAME CGRectMake(0, 0, DEV_FULLSCREEN_FRAME.size.width, DEV_FULLSCREEN_FRAME.size.height-44-49-20)

#pragma mark- 界面提示框
//播放界面 提示框
#define PLAY_VIEW_MES_VIEW_FRAM CGRectMake(35, 258, 251, 34)

//录像回放播放界面 提示框
#define REPLAY_VIEW_MES_VIEW_FRAM CGRectMake(35, 338, 251, 34)

//播客播放界面 提示框
#define BOKEPLAY_VIEW_MES_VIEW_FRAM CGRectMake(35, 338, 251, 34)

//报警播放界面 提示框
#define WARNPLAY_VIEW_MES_VIEW_FRAM CGRectMake(35, 238, 251, 34)

//播客采集界面 提示框
#define BOKECAP_VIEW_MES_VIEW_FRAM CGRectMake(35, 286, 251, 34)

//收藏节点界面 提示框
#define FAVNODE_VIEW_MES_VIEW_FRAM CGRectMake(35, 300, 251, 34)

//树节点界面 提示框
#define TREENODE_VIEW_MES_VIEW_FRAM CGRectMake(35, 300, 251, 34)

//抓图查询界面 提示框
#define WARNSEARCH_VIEW_MES_VIEW_FRAM CGRectMake(35, 308, 251, 34)

//地图界面 提示框
#define MAP_VIEW_MES_VIEW_FRAM CGRectMake(35, 308, 251, 34)

//收银查询界面 提示框
#define MONEYSEARCH_VIEW_MES_VIEW_FRAM CGRectMake(35, 308, 251, 34)



#pragma mark- IOS6.0 适配框 -视频播放界面
//IOS6.0 适配 框
#define PLAY_VIEW_Vertical_FOR_5_FRAM CGRectMake(0, 20, 320, 548)
#define PLAY_VIEW_Vertical_FOR_4_FRAM CGRectMake(0, 20, 320, 460)


#define PLAY_IMAGE_VIEW_Horizontal_FOR_5_FRAM CGRectMake(0, 0, 568, 320)
#define PLAY_IMAGE_VIEW_Horizontal_FOR_4_FRAM CGRectMake(0, 69, 320, 240)
#define PLAY_IMAGE_VIEW_Vertical_FOR_5_FRAM CGRectMake(0, 113, 320, 240)
#define PLAY_IMAGE_VIEW_Vertical_FOR_4_FRAM CGRectMake(0, 69, 320, 240)

//拉伸
#define PLAY_IMAGE_VIEW_Lashen_Vertical_FOR_5_FRAM CGRectMake(-160, 0, 640, 568)
#define PLAY_IMAGE_VIEW_Lashen_Vertical_FOR_4_FRAM CGRectMake(-160, 0, 640, 480)

//双击放大
#define PLAY_IMAGE_VIEW_Double_Left_Vertical_FOR_5_FRAM CGRectMake(0, 0, 640, 568)
#define PLAY_IMAGE_VIEW_Double_Left_Vertical_FOR_4_FRAM CGRectMake(0, 0, 640, 480)

//双击放大
#define PLAY_IMAGE_VIEW_Double_Right_Vertical_FOR_5_FRAM CGRectMake(-320, 0, 640, 568)
#define PLAY_IMAGE_VIEW_Double_Right_Vertical_FOR_4_FRAM CGRectMake(-320, 0, 640, 480)




#pragma mark - 录像回放页面
//日期
#define DATE_VIEW_FOR_5_FRAM CGRectMake(0, 548, 320, 345)
#define DATE_VIEW_FOR_4_FRAM CGRectMake(0, 460, 320, 345)

#define SEGMENT_VIEW_FOR_5_FRAM CGRectMake(80, 154, 161, 30)
#define SEGMENT_VIEW_FOR_4_FRAM CGRectMake(80, 134, 161, 30)

#pragma mark - 地图模式页面
//地图模式页面
#define MAP_VIEW_FOR_5_FRAM CGRectMake(0, 0, 320, 460+48)
#define MAP_VIEW_FOR_4_FRAM CGRectMake(0, 0, 320, 372+48)

#define SHOW_ME_BUTTON_FOR_5_FRAM CGRectMake(265, 404+48, 35, 35)
#define SHOW_ME_BUTTON_FOR_4_FRAM CGRectMake(265, 316+48, 35, 35)

#pragma mark - 轨迹地图显示页面
//图片的位置页面
#define ORBIT_IMAGE_VIEW_FOR_5_FRAM CGRectMake(0, 105, 320, 240)
#define ORBIT_IMAGE_VIEW_FOR_4_FRAM CGRectMake(0, 61, 320, 240)

#pragma mark - 播客采集页面
//图片的位置页面
#define BOKE_CAP_IMAGE_VIEW_FOR_5_FRAM CGRectMake(0, 0, 320, 460)
#define BOKE_CAP_IMAGE_VIEW_FOR_4_FRAM CGRectMake(0, 0, 320, 372)

#define SPEAK_BUTTON_IMAGE_VIEW_FOR_5_FRAM CGRectMake(14, 412, 60, 40)
#define SPEAK_BUTTON_IMAGE_VIEW_FOR_4_FRAM CGRectMake(14, 324, 60, 40)

#define SNAP_BUTTON_IMAGE_VIEW_FOR_5_FRAM CGRectMake(92, 412, 60, 40)
#define SNAP_BUTTON_IMAGE_VIEW_FOR_4_FRAM CGRectMake(92, 324, 60, 40)

#define ZHIBO_BUTTON_IMAGE_VIEW_FOR_5_FRAM CGRectMake(168, 412, 60, 40)
#define ZHIBO_BUTTON_IMAGE_VIEW_FOR_4_FRAM CGRectMake(168, 324, 60, 40)

#define SETTING_BUTTON_IMAGE_VIEW_FOR_5_FRAM CGRectMake(244, 412, 60, 40)
#define SETTING_BUTTON_IMAGE_VIEW_FOR_4_FRAM CGRectMake(244, 324, 60, 40)

#pragma mark - 帮助页面
#define HELP_SCROLL_VIEW_FOR_5_FRAM CGRectMake(0, 0, 320, 460+49)
#define HELP_SCROLL_VIEW_FOR_4_FRAM CGRectMake(0, 0, 320, 372+49)


#pragma mark - 帮助页面
#define TREE_LOGIN_VIEW_FOR_5_FRAM CGRectMake(12, 58, 146, 146)
#define TREE_LOGIN_VIEW_FOR_4_FRAM CGRectMake(12, 28, 146, 146)

#define TREE_DEMO_VIEW_FOR_5_FRAM CGRectMake(163, 58, 146, 146)
#define TREE_DEMO_VIEW_FOR_4_FRAM CGRectMake(163, 28, 146, 146)

#define TREE_CHE_VIEW_FOR_5_FRAM CGRectMake(12, 244, 146, 146)
#define TREE_CHE_VIEW_FOR_4_FRAM CGRectMake(12, 189, 146, 146)

#define TREE_BABY_VIEW_FOR_5_FRAM CGRectMake(163, 244, 146, 146)
#define TREE_BABY_VIEW_FOR_4_FRAM CGRectMake(163, 189, 146, 146)



#endif
