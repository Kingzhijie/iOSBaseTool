# iOSBaseTool
	**iOS开发基础工具总结**
	*介绍*
	1. 3DES加密工具
	2. 一些常用类的方法扩展
	3. 时间 date 处理工具
	4. 钥匙串的加密存储
	5. 利用Runtime 实现页面的万能跳转
	6. 数据存储. 以及缓存清除
	7. Json数据解析
	8. XML数据解析
	*内容*
	1. 3DES加密
	使用 类 DESEncrypt 直接调用加密解密方法
			/*
	** 3DES+Base64加密
	 */
	// 加密方法 (gkey: 加密key, gIv:和后端统一的常量)
	+ (NSString*)encrypt:(NSString*)plainText gkey:(NSString *)gkey gIv:(NSString *)gIv;
	// 解密方法
	+ (NSString*)decrypt:(NSString*)encryptText gkey:(NSString *)gkey gIv:(NSString *)gIv;
	2 . 方法扩展
	 提供NSString, UIView, UIColor, UIButton等
	3. 时间处理工具
		建议:   DateFormatterHelper 创建为单例, 不用每次创建, 浪费资源
	/*
	 ** 获取当前时间戳(1970年到现在流失的秒数)
	 */
	+(NSTimeInterval)getCurrentTimeStr;
	/*
	 ** 传入一个时间戳(seconds),返回一个时间
	 **  dateStyle 需要返回日期的格式(yyyy-MM-dd a HH:mm:ss)
	 */
	+(NSString *)getTimeDateBySeconds:(NSTimeInterval)seconds dateStyle:(NSString *)dateStyle;
	4. 钥匙串数据存储---提供存,取,删数据功能
	/**
	 * 存
	 * data 支持类型, 数组, 字典, 字符串等基本类型, 即: 
	 * key 数据存储 定义的 key
	 */
	+ (void)saveDataToKeyChain:(id)data forKey:(NSString *)key;
	/** 取 */
	+ (id)getDataFromKeyChainForKey:(NSString *)key;
	/** 删 */
	+ (void)deleteDataFromKeyChainForKey:(NSString *)key;
	5. Runtime 实现页面的万能跳转
	/**
	 *   iOS 利用runtime 实现页面的万能跳转
	 *   @parameter paramsArray  实现跳转, 参数配置
	 *
	 */
	- (void)inputDataWithArray:(NSArray *)paramsArray changeViewActionBlock:(changeViewActionBlock)changeViewActionBlock;
 	备注: 其中 
 	changeViewActionBlock : (NSInteger viewType, UIViewController *targetViewController) 
	 	/**
	 *  viewType: 1.模态页面, 0.push页面
	 *  targetViewController: 需要切换的目标控制器
	 */
 	paramsArray参数配置:   
	 	/*
	 ************
	 ****参数****
	 **配置说明**
	 
	     NSDictionary *configsDic =@{@"configs":
	             @[{                                 -------对应 paramsArray 内容格式, 及参数
	             @"deviceType": @2,                     //设备类型. 1安卓,2iOS
	             @"pageName": @"FRW_JinRongQuanDetailViewController",  //目标类名 (注:swift类名维护 如: (工程名字)Project.FRW_JinRongQuanDetailViewController)
	             @"createType": @1,                     //类的创建方式1.xib创建, 2.alloc创建
	             @"changeType": @0,                    //页面,   1.模态, 2.push页面
	             @"version": [ @"2.7.1",@"2.7.4"],     //版本控制, 比如: 只有2.7.1和2.7.4版本可以 跳转此页面, 其他版本则不跳转
	             @"params": {@"financeID": @3408 }     //类对应的属性  (比如跳转---产品详情页, 需要产品id来请求数据)
	             ]};

	 */























