//
//  UnitTransformTool.m
//  myCllectionViewExcise
//
//  Created by panda誌 on 2017/6/13.
//  Copyright © 2017年 杭州融讯科技有限公司. All rights reserved.
//

#import "UnitTransformTool.h"

@implementation UnitTransformTool
+(float)PXTransformPtMethodByPx:(float)px
{
    NSNumber *iosFontSize = [NSNumber numberWithFloat:px/96*72];
    return iosFontSize.floatValue;
}
@end
