//
//  ObtainRepostitoriesResponseMapper.swift
//  GitHubClient
//
//  Created by Sergey on 25/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation
import EasyMapping

class ObtainRepositoriesResponseMapper: NSObject, MapperProtocol {

    func mappedEntity(entityParsedInfo: AnyObject!) -> AnyObject? {
        
        let entityParsed = entityParsedInfo as! NSArray
        
        let model:[ObtainRepositroiesResponse] = (EKMapper.arrayOfObjectsFromExternalRepresentation(entityParsed as [AnyObject], withMapping: ObtainRepositoriesResponseMapper.objectMapping()) as? [ObtainRepositroiesResponse])!
        return model
    }
    
    @objc class func objectMapping() -> EKObjectMapping! {
        
        let mapping = EKObjectMapping(objectClass: ObtainRepositroiesResponse.self)
        mapping.mapPropertiesFromDictionary(
            ["id" : "id",
            "name" : "name",
            "full_name" : "fullName"])
        return mapping
    }
}
