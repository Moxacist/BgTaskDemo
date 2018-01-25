//
//  AppDelegate.m
//  TestBgTask
//
//  Created by 谢传纪 on 2018/1/25.
//  Copyright © 2018年 谢传纪. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()<CLLocationManagerDelegate>
@property (nonatomic) dispatch_source_t badgeTimer;
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AppDelegate{
    CLLocationManager *appleLocationManager;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //注册推送
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"request authorization succeeded!");
        }
    }];
    [self player];
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self stratBadgeNumberCount];
    [self startBgTask];
    /** 播放声音 */
    [self.player play];
}

- (AVAudioPlayer *)player{
    if (!_player){
        NSURL *url=[[NSBundle mainBundle]URLForResource:@"work5.mp3" withExtension:nil];
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
        [_player prepareToPlay];
        //一直循环播放
        _player.numberOfLoops = -1;
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        [session setActive:YES error:nil];
    }
    return _player;
}


- (void)startBgTask{
    UIApplication *application = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        //这里延迟的系统时间结束
        [application endBackgroundTask:bgTask];
        NSLog(@"%f",application.backgroundTimeRemaining);
    }];

}

- (void)stratBadgeNumberCount{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    _badgeTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(_badgeTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_badgeTimer, ^{

        [UIApplication sharedApplication].applicationIconBadgeNumber++;
//        appleLocationManager = [[CLLocationManager alloc] init];
//        appleLocationManager.allowsBackgroundLocationUpdates = YES;
//        appleLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        appleLocationManager.delegate = self;
//        [appleLocationManager requestAlwaysAuthorization];
//        [appleLocationManager startUpdatingLocation];

    });
    dispatch_resume(_badgeTimer);
}

/** 苹果_用户位置更新后，会调用此函数 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [appleLocationManager stopUpdatingLocation];
    appleLocationManager.delegate = nil;
    NSLog(@"success");
}

/** 苹果_定位失败后，会调用此函数 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [appleLocationManager stopUpdatingLocation];
    appleLocationManager.delegate = nil;
    NSLog(@"error");
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
