//
//  ViewController.m
//  CocoaRedis
//
//  Created by RND on 2024/7/11.
//

#import "ViewController.h"
#import "CocoaRedis.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CocoaRedis *redis = [[CocoaRedis alloc] init];
    
    [[[[redis connectWithHost:@"host" port: 6379] then:^id(id value) {
        return [redis auth: @"root:123456" ];
        
    }] then:^id(id value) {
        NSLog(@"Connected");
        NSLog(@"result： %@",value);
        
        // 发送请求数据：这里的请求数据类型根据后台要求，方法是不一样的！！！
        return [redis rpush:@"connected" value:@"ok"];
        
    }] catch:^id(NSError *err) {
        NSLog(@"Error: %@", err);
        return nil;
    }];
    
}


@end
