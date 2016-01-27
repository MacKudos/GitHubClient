//
//  GitHubApiProtocol.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import PromiseKit
import Foundation
import Alamofire

protocol GitHubApiProtocol {
    
    func authorizeApiUser(user:GitHubApiUser, completionHandler: ((NSError) -> Void)) -> Promise<AnyObject>
    func makeRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject>
    func makeAuthorizedRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject>
    func makePublicRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject>
    func obtainRepositoriesForUser(user:NSString) -> Promise<[ObtainRepositroiesResponse]>
    
}