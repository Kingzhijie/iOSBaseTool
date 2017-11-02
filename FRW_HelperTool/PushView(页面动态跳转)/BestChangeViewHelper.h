//
//  FRW_BannerHelper.h
//  FaRongWangWithRongYun
//
//  Created by panda誌 on 17/1/22.
//  Copyright © 2017年 RongXun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 ************
 ****参数****
 **配置说明**
 
     NSDictionary *configsDic =@{@"configs":
             @[{                                 -------对应 paramsArray 内容格式, 及参数
             @"deviceType": @2,                     //设备类型. 1安卓,2iOS
             @"pageName": @"FRW_JinRongQuanDetailViewController",  //目标类名
             @"createType": @1,                     //类的创建方式1.xib创建, 2.alloc创建
             @"changeType": @0,                    //页面,   1.模态, 2.push页面
             @"version": [ @"2.7.1",@"2.7.4"],     //版本控制, 比如: 只有2.7.1和2.7.4版本可以 跳转此页面, 其他版本则不跳转
             @"params": {@"financeID": @3408 }     //类对应的属性  (比如跳转---产品详情页, 需要产品id来请求数据)
             ]};

 */


/**
 *  viewType: 1.模态页面, 0.push页面
 *  targetViewController: 需要切换的目标控制器
 */
typedef void(^changeViewActionBlock)(NSInteger viewType, UIViewController *targetViewController);
@interface BestChangeViewHelper : NSObject
/**
 *   iOS 利用runtime 实现页面的万能跳转
 *   @parameter paramsArray  实现跳转, 参数配置
 *
 */
- (void)inputDataWithArray:(NSArray *)paramsArray changeViewActionBlock:(changeViewActionBlock)changeViewActionBlock;

@end
