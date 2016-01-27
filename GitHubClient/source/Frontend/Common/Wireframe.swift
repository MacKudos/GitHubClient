//
//  Wireframe.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

protocol Wireframe {
    
    var viewController:UIViewController {get}
    var viewPresenter:ViewControllerPresenter<UIViewController> {get}
}
