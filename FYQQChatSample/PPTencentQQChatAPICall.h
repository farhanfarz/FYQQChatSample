//
//  PPTencentQQChatAPICall.h
//  FYQQChatSample
//
//  Created by Farhan Yousuf on 01/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import "PPTencentQQChatAPICallConstants.h"

@interface PPTencentQQChatAPICall : NSObject<TencentSessionDelegate, TCAPIRequestDelegate>
+ (PPTencentQQChatAPICall *)getinstance;
+ (void)resetSDK;

+ (void)showInvalidTokenOrOpenIDMessage;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
@property (nonatomic, retain)TencentOAuth *oauth;
@end
