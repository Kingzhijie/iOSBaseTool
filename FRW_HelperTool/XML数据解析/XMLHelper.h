//
//  XMLHelper.h
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/13.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLHelper : NSObject
/*
 **  XML数据解析, xmlString: XML数据
 */
+(NSDictionary *)dicWithXMLString:(NSString *)xmlString;
/*
 **  XML数据解析, xmlUrl: XML数据URL链接
 */
+(NSDictionary *)dicWithXMLUrl:(NSURL *)xmlUrl;

@end
