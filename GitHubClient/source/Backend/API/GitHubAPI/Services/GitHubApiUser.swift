//
//  GitHubApiUser.swift
//  GitHubClient
//
//  Created by Sergey on 25/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

enum GitHubApiUserState {
    case unathorized
    case authrized
}

class GitHubApiUser: NSObject {
    
    var username:NSString!
    var password:NSString?
    var status:GitHubApiUserState!
    var token:NSString?
    var clientId:NSString!
    var clientSecret:NSString!
    
    var basicAuthHash:NSString? {
        if let pass = self.password {
            let optData = "\(self.username):\(pass)".dataUsingEncoding(NSUTF8StringEncoding)
            if let data = optData {
                return data.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
