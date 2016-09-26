//
//  LightStore.swift
//  HueMe
//
//  Created by Jeff on 9/25/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import Foundation

struct LightStore {
    static var instance = LightStore()
    var lights = [PHLight]()
    var cache: PHBridgeResourcesCache?
    var bridgeAPI = PHBridgeSendAPI()
    
    private init() {}
    
    mutating func set(lights: [PHLight]) {
        self.lights = lights
    }
    
    func startTheParty() {
        for light in lights {
            guard let state = light.lightState else { return }
            state.on = true
            state.brightness = 254
            
            let randomHue = Int(arc4random_uniform(65535))
            let randomSaturation = Int(arc4random_uniform(255))
            let randomXColor = Double(arc4random_uniform(2))
            let randomYColor = Double(arc4random_uniform(2))
            
            state.effect = EFFECT_COLORLOOP
            state.hue = NSNumber(integerLiteral: randomHue)
            state.saturation = NSNumber(integerLiteral: randomSaturation)
            state.x = NSNumber(floatLiteral: randomXColor)
            state.y = NSNumber(floatLiteral: randomYColor)
            
            bridgeAPI.updateLightState(forId: light.identifier, with: state, completionHandler: nil)
        }
    }
}
