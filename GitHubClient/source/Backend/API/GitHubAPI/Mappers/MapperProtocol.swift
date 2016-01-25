//
//  MapperProtocol.swift
//  GitHubClient
//
//  Created by Sergey on 25/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation
protocol MapperProtocol {
    
     func mappedEntity(entityParsedInfo: AnyObject!) -> AnyObject?;
}