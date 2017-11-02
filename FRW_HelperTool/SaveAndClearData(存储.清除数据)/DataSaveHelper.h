//
//  DataSaveHelper.h
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^getCachesBlock)(NSString *caches);
typedef void(^deleteCachesBlock)();
@interface DataSaveHelper : NSObject
/*
 **  保存数据, NSUserDefaults 的二次封装(存储类型)
 */
+ (void)writeUserDataWithKey:(id)data forKey:(NSString*)key;
/*
 **  读取用户保存的数据
 */
+ (id)readUserDataWithKey:(NSString*)key;
/*
 **  删除key对应用户保存的数据
 */
+ (void)removeUserDataWithkey:(NSString*)key;
/*
 **  删除NSUserDefaults中用户保存的所有数据
 */
+ (void)removeAllUserData;

/**
 *   获取总缓存大小
 *
 *   @parameter filePath      缓存路径
 *   @parameter getTotalCache 当前路径缓存的大小
 *
 */
+ (void)getCachesWithFilePath:(NSString *)filePath completion:(getCachesBlock)getTotalCache;

/**
 *   清除缓存
 *
 *   @parameter filePath为nil  默认只清空SDWebImage缓存文件夹
 *   @parameter deleteTotalCache  删除缓存之后的completion操作
 *
 */
+ (void)deleteCacheWithFilePath:(NSString *)filePath completion:(deleteCachesBlock)deleteTotalCache;



@end
