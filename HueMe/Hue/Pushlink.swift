//
//  Pushlink.swift
//  HueMe
//
//  Created by Jeff on 9/25/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import Foundation

@objc
class PushlinkManager: NSObject {
    static let instance = PushlinkManager()
    let notificationManager = PHNotificationManager.default()
    
    private override init() {}
    
    func authenticatePushlink() {
        registerNotificationHandlers()
        Hue.instance.sdk.startPushlinkAuthentication()
    }
    
    private func registerNotificationHandlers() {
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.authenticationSuccess),
                                      forNotification: PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION)
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.authenticationFailed),
                                      forNotification: PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION)
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.noLocalConnection),
                                      forNotification: PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.noLocalBridge),
                                      forNotification: PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION)
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.buttonNotPressed(notification:)),
                                      forNotification: PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION)
        notificationManager?.register(self,
                                      with: #selector(PushlinkManager.localConnection),
                                      forNotification: LOCAL_CONNECTION_NOTIFICATION)
        Hue.instance.sdk.enableLocalConnection()
    }
}

// MARK: Notification Response Handlers
extension PushlinkManager {
    func authenticationSuccess() {
        Hue.instance.sdk.setLocalHeartbeatInterval(10.0, for: RESOURCES_LIGHTS)
        print("PUSH THE FUCKING BUTTON!")
    }
    
    func authenticationFailed() {
        
    }
    
    func noLocalConnection() {
        
    }
    
    func noLocalBridge() {
        
    }
    
    func buttonNotPressed(notification: NSNotification) {
        
    }
}

extension PushlinkManager {
    func localConnection() {
        // Connection was made
        print("Connection was made")
        LightStore.instance.cache = PHBridgeResourcesReader.readBridgeResourcesCache()
        
        guard let cache = LightStore.instance.cache,
            let cacheLights = cache.lights else
        {
            return
        }
        
        // Store the username for quick access later
        Hue.instance.userName = cache.bridgeConfiguration.username
        
        var lights = [PHLight]()
        for key in cacheLights.keys {
            guard let newLight = cache.lights[key] as? PHLight else {
                print("Object was not a PHLight type")
                continue
            }
            
            lights.append(newLight)
        }
        
        LightStore.instance.set(lights: lights)
    }
}
