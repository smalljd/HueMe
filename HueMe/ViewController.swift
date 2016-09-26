//
//  ViewController.swift
//  HueMe
//
//  Created by Jeff on 9/19/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    var lightState = true
    @IBOutlet weak var centerButton: HueButton!
    @IBOutlet weak var connectionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: IBActions
extension ViewController {
    @IBAction func centerButtonTapped(_ sender: AnyObject) {
        guard Hue.instance.connected else {
            Hue.instance.findBridges { bridges in
                guard let bridges = bridges,
                    let bridgeID = bridges.keys.first as? String,
                    let ipAddress = bridges[bridgeID] as? String else
                {
                    self.centerButton.backgroundColor = UIColor.red
                    self.centerButton.titleLabel?.text = "Try Again"
                    self.connectionLabel.text = "Connection Failed"
                    self.connectionLabel.textColor = UIColor.red
                    return
                }
                
                self.connectionLabel.textColor = UIColor.green
                self.connectionLabel.text = "Connected to \(ipAddress)"
                
                Hue.instance.sdk.setBridgeToUseWithId(bridgeID, ipAddress: ipAddress)
                PushlinkManager.instance.authenticatePushlink()
            }
            return
        }
        
        centerButton.titleLabel?.text = "Party Time"
        centerButton.backgroundColor = UIColor.green
        LightStore.instance.startTheParty()
    }
    
    func sendOnOffCommand() {
        let onOrOff: String = lightState ? "on" : "off"
        print("turning light \(onOrOff)")
        
//        let descriptor = HueAPIDescriptor(userID: "vmZedDytTH8GRiv53KWkgpq0ExSIlmbEcexmTv70",
//                                          httpMethod: .put,
//                                          resource: .Lights,
//                                          queryParams: "1/state",
//                                          jsonBody: ["on": lightState])
        
//        print("descriptor endpoint: \(descriptor.endpoint())")
//        
//        Alamofire.request(descriptor.endpoint(),
//                          method: .put,
//                          parameters: descriptor.jsonBody,
//                          encoding: JSONEncoding.default,
//                          headers: nil)
//            .responseJSON { response in
//                print(response)
//        }
//        
//        lightState = !lightState
    }
}
