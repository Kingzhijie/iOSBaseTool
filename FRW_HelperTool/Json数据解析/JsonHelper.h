//
//  JsonHelper.h
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonHelper : NSObject
/*
 ** 字符串转对象类型(字典, 数组等)  JSON解析
 */
+ (id)dataWithJsonString:(NSString *)jsonString;


@end
