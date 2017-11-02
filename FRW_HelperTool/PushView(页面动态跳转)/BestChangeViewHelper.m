//
//  FRW_BannerHelper.m
//  FaRongWangWithRongYun
//
//  Created by panda誌 on 17/1/22.
//  Copyright © 2017年 RongXun. All rights reserved.
//

#import "BestChangeViewHelper.h"
#import <objc/message.h>

@interface BestChangeViewHelper()
@property (nonatomic, copy)changeViewActionBlock changeViewActionBlock;
@end

@implementation BestChangeViewHelper

- (void)inputDataWithArray:(NSArray *)paramsArray changeViewActionBlock:(changeViewActionBlock)changeViewActionBlock
{
    _changeViewActionBlock = changeViewActionBlock;
    [self MacthCorrectVersionArray:paramsArray];
}

//匹配正确的版本
- (void)MacthCorrectVersionArray:(NSArray *)listArray
{

    
    //获得当前版本
    NSString *currentVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    for (NSDictionary * listDic in listArray) {
        if ([listDic[@"version"] containsObject:currentVersion] && [listDic[@"deviceType"] integerValue] == 2) { //当前版本, 并且属于iOS
            [self pushViewActionDic:listDic];
            break;
        }
    }
}

//跳转界面
- (void)pushViewActionDic:(NSDictionary *)params
{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"pageName"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass) return;
    // 创建对象
    id instance;
    if ([params[@"creatType"] integerValue] == 1) { //xib
        instance = [[newClass alloc] initWithNibName:NSStringFromClass([newClass class]) bundle:nil];
    }else{ //直接alloc
        instance = [[newClass alloc] init];
    }
    // 对该对象赋值属性
    NSDictionary * propertys = params[@"params"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
    NSInteger changeType = [params[@"changeType"] integerValue];
    if (self.changeViewActionBlock) {
        self.changeViewActionBlock(changeType, instance);
    }
    
    
}

//检测对象是否存在该属性
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}











@end
