//
//  APIDescriptor.swift
//  HueMe
//
//  Created by Jeff on 9/19/16.
//  Copyright © 2016 Jeff Small. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONBody = [String: Any]

enum HueResource: String {
    case Lights         = "lights"
    case Groups         = "groups"
    case Config         = "config"
    case Schedules      = "schedules"
    case Scenes         = "scenes"
    case Sensors        = "sensors"
    case Rules          = "rules"
}

struct HueAPIDescriptor {
    var ipAddress: String
    var userID: String
    var httpMethod: HTTPMethod
    var resource: HueResource?
    var queryParams: String?
    var jsonBody: JSONBody?
    
    init(ipAddress: String,
         userID: String,
         httpMethod: HTTPMethod,
         resource: HueResource? = nil,
         queryParams: String? = nil,
         jsonBody: JSONBody? = nil)
    {
        self.ipAddress = ipAddress
        self.userID = userID
        self.httpMethod = httpMethod
        self.resource = resource
        self.queryParams = queryParams
        self.jsonBody = jsonBody
    }
}

protocol HueAPIDescriptable {
    func endpoint() -> String
}

extension HueAPIDescriptor: HueAPIDescriptable {
    func endpoint() -> String {
        var endpoint = "http://\(ipAddress)/api/\(userID)/"
        
        if let resource = resource {
            endpoint += "\(resource.rawValue)/"
        }
        
        if let queryParams = queryParams {
            endpoint += "\(queryParams)/"
        }
        
        return endpoint
    }
}
