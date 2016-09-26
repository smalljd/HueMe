//
//  HueStore.swift
//  HueMe
//
//  Created by Jeff on 9/25/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import Foundation

final class Hue {
    static let instance = Hue()
    let sdk = PHHueSDK()
    let bridgeSearch = PHBridgeSearching(upnpSearch: true,
                                         andPortalSearch: true,
                                         andIpAdressSearch: true)
    var connected = false
    
    var userName: String = "" {
        didSet {
            // Store the username in core data
            connected = true
            print("USERNAME FOR MY FUCKING BRIDGE: \(userName)")
        }
    }
    
    private init() {
        sdk.enableLogging(true)
        sdk.startUp()
    }
    
    func findBridges(with completion: @escaping PHBridgeSearchCompletionHandler) {
        bridgeSearch?.startSearch(completionHandler: completion)
    }
}
