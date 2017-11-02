//
//  KeyChainSaveTool.h
//  myCllectionViewExcise
//
//  Created by panda誌 on 2017/6/13.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyChainSaveTool : NSObject
/**
 * 存
 * data 支持类型, 数组, 字典, 字符串等基本类型, 即: 
 */
+ (void)saveDataToKeyChain:(id)data forKey:(NSString *)key;
/** 取 */
+ (id)getDataFromKeyChainForKey:(NSString *)key;
/** 删 */
+ (void)deleteDataFromKeyChainForKey:(NSString *)key;

@end
