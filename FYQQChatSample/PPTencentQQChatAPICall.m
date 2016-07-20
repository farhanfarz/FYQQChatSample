//
//  PPTencentQQChatAPICall.m
//  FYQQChatSample
//
//  Created by Farhan Yousuf on 01/07/16.
//  Copyright © 2016 July Systems Pvt. Ltd. All rights reserved.
//

#import "PPTencentQQChatAPICall.h"

static PPTencentQQChatAPICall *g_instance = nil;
@interface PPTencentQQChatAPICall()
@property (nonatomic, retain)NSArray* permissons;
@end

@implementation PPTencentQQChatAPICall

+ (PPTencentQQChatAPICall *)getinstance
{
    @synchronized(self)
    {
        if (nil == g_instance)
        {
            //g_instance = [[PPTencentQQChatAPICall alloc] init];
            g_instance = [[super allocWithZone:nil] init];
            
        }
    }
    
    return g_instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self getinstance];
}

+ (void)showInvalidTokenOrOpenIDMessage
{
    [PPTencentQQChatAPICall showAlertWithTitle:@"Api Call Failed" message:@"Possibly authorization has expired, please re-acquire"];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (rootViewController != nil) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [rootViewController dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alertVC addAction:cancelAction];
        
        [rootViewController presentViewController:alertVC animated:YES completion:nil];
    }
    
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

+ (void)resetSDK
{
    g_instance = nil;
}

- (id)init
{
//    if (self = [super init])
//    {
        NSString *appid = @"__APP_ID__";
        _oauth = [[TencentOAuth alloc] initWithAppId:appid
                                         andDelegate:self];
//    }
    return self;
}

- (void)tencentDidLogin
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginSuccessed object:self];
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginCancelled object:self];
}

- (void)tencentDidNotNetWork
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginFailed object:self];
}

- (NSArray *)getAuthorizedPermissions:(NSArray *)permissions withExtraParams:(NSDictionary *)extraParams
{
    return nil;
}

- (void)tencentDidLogout
{
    
}

- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions
{
    return YES;
}


- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth
{
    return YES;
}

- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth
{
}


- (void)tencentFailedUpdate:(UpdateFailType)reason
{
}


- (void)getUserInfoResponse:(APIResponse*) response
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kGetUserInfoResponse object:self  userInfo:[NSDictionary dictionaryWithObjectsAndKeys:response, kResponse, nil]];
}

@end
