//
//  DataSaveHelper.m
//  FRW_HelperTool
//
//  Created by panda誌 on 2017/6/12.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import "DataSaveHelper.h"

@implementation DataSaveHelper

+ (void)writeUserDataWithKey:(id)data forKey:(NSString*)key
{
    if (data == nil) {
        return;
    }else{
         [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
         [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (id)readUserDataWithKey:(NSString*)key
{
    id temp = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if(temp != nil)
    {
        return temp;
    }
    return nil;
}

//删除
+ (void)removeUserDataWithkey:(NSString*)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

+ (void)removeAllUserData{
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict)  {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

+ (void)getCachesWithFilePath:(NSString *)filePath completion:(getCachesBlock)getTotalCache {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        BOOL isFileExist = [manager fileExistsAtPath:filePath isDirectory:&isDirectory];
        float total = 0.0;
        if (isFileExist){
            if (isDirectory) {
                NSArray *subPaths = [manager subpathsAtPath:filePath];
                
                for (NSString *subPath in subPaths) {
                    NSString *subFilePath = [filePath stringByAppendingPathComponent:subPath];
                    
                    BOOL isDirectory;
                    BOOL isFileExist = [manager fileExistsAtPath:subFilePath isDirectory:&isDirectory];
                    
                    if (isFileExist && !isDirectory ) {
                        NSInteger fileSize = [[manager attributesOfItemAtPath:subFilePath error:nil] fileSize];
                        total += fileSize;
                    }
                }
            }else{
                total = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
            }
        }
        
        NSString *cacheStr = @"0.00B";
        NSString *unit = @"B";
        if (total > 0.0) {
            if (total > 1024.0 * 1024.0) {
                total = total / 1024.0 / 1024.0;
                unit = @"MB";
            }else if (total > 1024.0){
                total = total / 1024.0;
                unit = @"kB";
            }
        }
        cacheStr = [NSString stringWithFormat:@"%.2f%@",total,unit];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if (getTotalCache) {
                getTotalCache(cacheStr);
            }
        });
    });
    
}


+ (void)deleteCacheWithFilePath:(NSString *)filePath completion:(deleteCachesBlock)deleteTotalCache {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *path = filePath.length ? filePath : [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingString:@"/default"];
        
        BOOL isDirectory;
        BOOL isFileExist = [manager fileExistsAtPath:path isDirectory:&isDirectory];
        
        if (!isFileExist) return;
        if (isDirectory) {
            NSArray *subPaths = [manager subpathsAtPath:path];
            for (NSString *subPath in subPaths) {
                
                NSString *filePath = [path stringByAppendingPathComponent:subPath];
                [manager removeItemAtPath:filePath error:nil];
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (deleteTotalCache) {
                deleteTotalCache();
            }
        });
    });
}

@end
