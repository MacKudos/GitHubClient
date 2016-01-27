//
//  ApplicationCoordinator.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation

enum ApplicationState {
    case mainState
}

protocol applicationErrorHandler: class {
    
    func applicationSholdProcessError(err:NSError)
}

protocol applicationCoordinatorProtocol: class {
    
    func applicationShooldPresentAuthorizationView()
    func applicationShooldPresentError(er:NSError)
    func applicationSholdProcessUIState(state:ApplicationState)
}

class ApplicationCoordinator: NSObject {

    weak var delegate:applicationCoordinatorProtocol?
    var authServiceCallBack:((code: String!) -> Void)?
    var api:GitHubApiProtocol
    
    override init() {
        
        api = GitHubApi()
        super.init()
    }
    
    func setupApplication() {
        
        ServiceHolder.sharedInstance.applicationCoordinator = self
        ServiceHolder.sharedInstance.repositoriesService = RepositoriesService(apiObject: api, errorHandler:self)
        ServiceHolder.sharedInstance.authSevice = AuthService(delegate: self, apiObject:  api, errorHandler:self)
    }
    
    func applicationRetriveAuthAccessCode(code:String!) {
        
        self.authServiceCallBack!(code: code)
    }
}

extension ApplicationCoordinator : applicationErrorHandler {
    
    func applicationSholdProcessError(err:NSError) {
        
        self.delegate?.applicationShooldPresentError(err)
    }
}

extension ApplicationCoordinator : applicationAuthServiceProtocol {
    
    func authServiceObtainAccessCode(callback: ((code: String!) -> Void)) {
        
        authServiceCallBack = callback
        delegate?.applicationShooldPresentAuthorizationView()
    }
}
