//
//  XMLHelper.m
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/13.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import "XMLHelper.h"
#import "XMLDictionary.h"
@implementation XMLHelper
+(NSDictionary *)dicWithXMLString:(NSString *)xmlString
{
    return [NSDictionary dictionaryWithXMLString:xmlString];
}
+(NSDictionary *)dicWithXMLUrl:(NSURL *)xmlUrl
{
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:xmlUrl encoding:NSUTF8StringEncoding error:NULL];
    return [NSDictionary dictionaryWithXMLString:xmlString];
}
@end
