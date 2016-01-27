//
//  GitHubApi.swift
//  GitHubClient
//
//  Created by Sergey on 25/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class GitHubApi: NSObject, GitHubApiProtocol {
    
    var apiUser:GitHubApiUser?

    func createApiUser(name name:NSString) -> GitHubApiUser {
        
        let user = GitHubApiUser()
        user.username = name
        user.clientId = ""
        user.clientSecret = ""
        user.status = GitHubApiUserState.unathorized
        
        return user;
    }
    
    func createApiUser(name name:NSString, password:NSString) -> GitHubApiUser {
        
        let user = GitHubApiUser()
        user.username = name
        user.clientId = ""
        user.clientSecret = ""
        user.password = password
        user.status = GitHubApiUserState.unathorized
        
        return user;
    }
    
    func authorizeApiUser(user:GitHubApiUser, completionHandler: ((NSError) -> Void)) -> Promise<AnyObject> {
        return Promise{ fulfill, reject in
            let params = ["scopes":"repo", "note": "dev", "client_id": user.clientId, "client_secret": user.clientSecret]
            Alamofire.request(.POST, "https://api.github.com/authorizations", parameters: params, encoding: ParameterEncoding.URL, headers: ["Authorization": "Basic \(user.basicAuthHash)"])
                .responseJSON { response in
                    debugPrint(response)
                    //if ok user.token = response.token
                    //fulfill(data)
                    //reject(error)
            }
        }
    }
    
    func makeRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject> {

        if self.apiUser?.status == GitHubApiUserState.authrized {
            return self.makeAuthorizedRequest(method, path: path, parameters: parameters, mapper: mapper)
        } else {
            return self.makePublicRequest(method, path: path, parameters: parameters, mapper: mapper)
        }
    }
    
    func makeAuthorizedRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject> {
        
        return Promise{ fulfill, reject in
            Alamofire.request(method, path, parameters: parameters, encoding: ParameterEncoding.URL, headers: ["Authorization": "token \(self.apiUser!.token)"]).responseJSON { response in
                switch response.result {
                case .Failure(let error):
                    reject(error)
                case .Success(let responseObject):
                    fulfill(responseObject)
                }
            }
        }
    }
    
    func makePublicRequest(method:Alamofire.Method, path:String, parameters:[String: AnyObject]?, mapper:MapperProtocol) -> Promise<AnyObject> {
        
        return Promise{ fulfill, reject in
            Alamofire.request(method, path, parameters: parameters, encoding: ParameterEncoding.URL).responseJSON { response in
                switch response.result {
                case .Failure(let error):
                    reject(error)
                case .Success(let responseObject):
                    fulfill(mapper.mappedEntity(responseObject)!)
                }
            }
        }
    }
    
    func obtainRepositoriesForUserWrong(user:NSString) -> Promise<[ObtainRepositroiesResponse]> {

        return self.makeRequest(.GET, path: "https://api.gsithub.com/users/\(user)/repos", parameters: nil, mapper:ObtainRepositoriesResponseMapper()).then { (obj:AnyObject) -> Promise<[ObtainRepositroiesResponse]> in
            
            return Promise{ fulfill, reject in fulfill(obj as! [ObtainRepositroiesResponse])}
        }
    }
    
    func obtainRepositoriesForUser(user:NSString) -> Promise<[ObtainRepositroiesResponse]> {
        
        return self.makeRequest(.GET, path: "https://api.github.com/users/\(user)/repos", parameters: nil, mapper:ObtainRepositoriesResponseMapper()).then { (obj:AnyObject) -> Promise<[ObtainRepositroiesResponse]> in
            
            return Promise{ fulfill, reject in fulfill(obj as! [ObtainRepositroiesResponse])}
        }
    }
        
        //return self.makeRequest(.GET, path: "https://api.github.com/users/\(user)/repos", parameters: nil, mapper:ObtainRepositoriesResponseMapper())
    //}
}
