//
//  AuthorizationMapper.swift
//  GitHubClient
//
//  Created by Sergey on 25/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit
import EasyMapping

class AuthorizationMapper: NSObject, MapperProtocol {
    
    func mappedEntity(entityParsedInfo: AnyObject!) -> AnyObject? {
        
        let entityParsed = entityParsedInfo as! NSDictionary
        
        let model:AuthorizationResponse = (EKMapper.objectFromExternalRepresentation(entityParsed as [NSObject : AnyObject], withMapping: AuthorizationMapper.objectMapping()) as? AuthorizationResponse)!
        return model
    }
    
    @objc class func objectMapping() -> EKObjectMapping! {
        
        let mapping = EKObjectMapping(objectClass: AuthorizationResponse.self)
        mapping.mapPropertiesFromDictionary(["access_token" : "token", "refresh_token" : "refreshToken"])
        mapping.mapKeyPath("expires_in", toProperty: "expiringDate") { (key, object) -> AnyObject! in
            
            let timestamp:NSTimeInterval = NSTimeInterval ((object as? Double)!)
            return NSDate(timeIntervalSinceNow: NSTimeInterval(timestamp))
        }
        return mapping
    }
}
