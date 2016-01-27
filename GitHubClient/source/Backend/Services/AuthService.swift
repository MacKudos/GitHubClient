//
//  AuthService.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import Foundation

protocol applicationAuthServiceProtocol: class {
    
    func authServiceObtainAccessCode(callback:((code:String!) -> Void))
}

class AuthService: NSObject   {
    
    var redirectURL = "://callback"
    var errorRedirectURL = "://callback?error=access_denied"
    
    private var accessTokenURL = "https:///oauth/access_token"
    private var clientId = ""
    private var clientSecret = ""
    
    private var userToken:AnyObject?
    private var accessCode:String?
    
    var api:GitHubApiProtocol
    private weak var errorHandler:applicationErrorHandler?
    weak var delegate:applicationAuthServiceProtocol?
    
    var authorizationURL:String {
        
        return "https:///oauth/authorize/?client_id=" + clientId + "&redirect_uri=" + redirectURL + "&response_type=" + "code"
    }
    
    init(delegate:applicationAuthServiceProtocol!, apiObject:GitHubApiProtocol!, errorHandler:applicationErrorHandler?) {
        
        self.delegate = delegate
        self.api = apiObject
        super.init()
        
        self.retrievePersistentApplicationToken()
    }
    
    
    func setupTransport (callback:(() -> Void)) {
        
    }
    
    private func retrievePersistentApplicationToken() {
        
    }
    
    private func persistApplicationToken() {
        
    }
    
    func obtainToken(callback:((token:String) -> Void)?) {
        
    }
    
    private func accessTokenRequest() -> NSURLRequest {
        
        let postBody = "grant_type=authorization_code" + "&"
            + "client_id=" + clientId + "&"
            + "client_secret=" + clientSecret + "&"
            + "redirect_uri=" + redirectURL + "&" + "code=" + accessCode!
        
        let authorizeRequest = NSMutableURLRequest(URL: NSURL(string:(accessTokenURL))!)
        authorizeRequest.HTTPBody = postBody.dataUsingEncoding(NSUTF8StringEncoding)
        authorizeRequest.HTTPMethod = "POST"
        
        return authorizeRequest
    }
}

extension AuthService {
    
    class func retreiveAccessCodeFromRedirectedURL(url:NSURL) -> String? {
        
        let query = url.query
        let codePair = (query! as NSString).stringByStandardizingPath
        return codePair.characters.split{$0 == "="}.map { String($0) }[1]
    }
    
    class func isApplicationTokenExpired(token:Any!) -> Bool {
        
        return true
    }
}