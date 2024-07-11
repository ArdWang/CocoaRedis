#### Supports ios and macosx

This code is RedisKit without cocoa version uploaded to the cocoa library.

 🎉  Congrats

 🚀  CocoaRedis (1.0.1) successfully published
 📅  July 10th, 19:48
 🌎  https://cocoapods.org/pods/CocoaRedis
 👍  Tell your friends!

use

```
target 'MyApp' do
  pod 'CocoaRedis', '~> 1.0.2'
end

```
More use please see:
https://github.com/dizzus/RedisKit

swift的使用如下：
```
import UIKit
import CocoaRedis
import HandyJSON
import SwiftEventBus

class RedisClient: NSObject {
    
    // 初始化Redis
    private var redis = CocoaRedis()
    // 外部访问的设备id, 用于所有数据的订阅功能
    var deviceId = "0000"
    //  监听数据
    var observer: NSObjectProtocol?
    
    /**
     配置Config文件
     */
    func config(){
        /// 判断代码必须不能为空，否则会造成代码错误
        if redis != nil {
            redis!.connect(withHost: REDIS_HOST, port: Int32(REDIS_PORT))
            // 连接的代码
                .then { [self] _ in
                    return redis!.auth(REDIS_USERNAME+":"+REDIS_PASSWORD)
                }
            // 在此订阅
                .then{ [self] _ in
                    RedisLogger.log("===Redis connected===")
                    let channels1 = deviceId+"-telemetry"
                    let channels2 = deviceId+"-status"
                    let channels3 = deviceId+"-version"
                    return redis!.subscribeChannels([channels1, channels2, channels3])
                }
            // 订阅接收到通知数据
                .then { [self] _ in
                    let center = NotificationCenter.default
                    observer = center.addObserver(forName: NSNotification.Name.CocoaRedisMessage,
                                                  object: nil,
                                                  queue: nil) { notification in
                        // Get published message from the notification object.
                        if let obj = notification.userInfo as? [String: Any] {
                            let channel = obj["channel"] as! String
                            let message = obj["message"] as! String
                            //print(obj["channel"] as Any)
                            //print(obj["message"] as Any)
                            
                            if channel == "\(self.deviceId)-telemetry" {
                                if let telemetry = JSONDeserializer<TelemetryModel>.deserializeFrom(json: (message)) {
                                    SwiftEventBus.post(REDIS_TELEMETRY, sender: telemetry)
                                }
                            }else if channel == "\(self.deviceId)-status" {
                                if let status = JSONDeserializer<StatusNModel>.deserializeFrom(json: (message)) {
                                    SwiftEventBus.post(REDIS_STATUS, sender: status)
                                }
                            }else if channel == "\(self.deviceId)-version" {
                                if let version = JSONDeserializer<VersionModel>.deserializeFrom(json: (message)) {
                                    SwiftEventBus.post(REDIS_VERSION, sender: version)
                                }
                                
                                
                            }
                        }
                    }
                    return nil
                }
        }
    }
    
    /**
     取消通知订阅 此代码作用与Redis的代码取消订阅
     @author ardawang
     date 2024/7/9
     */
    func unsub(){
        if redis?.isConnected != nil {
            let channels1 = deviceId+"-telemetry"
            let channels2 = deviceId+"-status"
            let channels3 = deviceId+"-version"
            redis!.unsubscribe([channels1, channels2, channels3])
                .then { [self] _ in
                    NotificationCenter.default.removeObserver(observer as Any)
                    return redis!.quit()
                }
        }
    }
}


```
