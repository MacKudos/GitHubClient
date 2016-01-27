//
//  ServiceHolder.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation

class ServiceHolder: NSObject {

    class var sharedInstance: ServiceHolder {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ServiceHolder? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ServiceHolder()
        }
        return Static.instance!
    }
    
    var apiService:GitHubApiProtocol?
    var repositoriesService:RepositoriesService?
    var applicationCoordinator:ApplicationCoordinator?
    var authSevice:AuthService?
}
