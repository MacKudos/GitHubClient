//
//  GitHubRepositoriesService.swift
//  GitHubClient
//
//  Created by Sergey on 26/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation

class RepositoriesService: NSObject {
    
    private var api:GitHubApiProtocol
    private weak var errorHandler:applicationerrorHandler?
    
    init(apiObject:GitHubApiProtocol!, errorHandler:applicationerrorHandler?) {
        
        self.api = apiObject
        self.errorHandler = errorHandler
        super.init()
    }
    
    func obtainRepositoriesForUser(user:String, callback:((repositories:Array<Repository>?) -> Void)) {
        
        api.obtainRepositoriesForUser(user).then { (repos:[ObtainRepositroiesResponse]) -> Void in
            
            callback(repositories: self.dataAdapter(repos))
            
        }.error { (error:ErrorType) -> Void in
            
            self.errorHandler?.applicationSholdProcessError(error as NSError)
        }
    }
    
    func dataAdapter(data:[ObtainRepositroiesResponse])->[Repository]? {
        
        var repos:[Repository] = []
        
        for rawRepo in data {
            let repo = Repository()
            repo.id = rawRepo.id?.stringValue
            repo.name = rawRepo.fullName as? String
            repos.append(repo)
        }
        
        return repos
    }
}
