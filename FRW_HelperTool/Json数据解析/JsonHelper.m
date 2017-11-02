//
//  JsonHelper.m
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import "JsonHelper.h"
#import "ToolHelperClass.h"
@implementation JsonHelper

+ (id)dataWithJsonString:(NSString *)jsonString
{
    if ([NSString removerBlankString:jsonString].length == 0) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    if (jsonData) {
        id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                  
                                                 options:NSJSONReadingMutableContainers
                  
                                                   error:&err];
        if(err) {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
    return  nil;
}




@end
