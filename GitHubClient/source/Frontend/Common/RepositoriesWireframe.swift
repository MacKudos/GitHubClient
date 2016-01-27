//
//  RepositoriesWireframe.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

class RepositoriesWireframe: NSObject, Wireframe {

    private(set) var viewController:UIViewController
    private(set) var viewPresenter:ViewControllerPresenter<UIViewController>
    
    override init() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RepositoriesViewController") as! RepositoriesViewController
        let vp = RepositoriesPresenter<RepositoriesViewController>(viewController: vc)
        vc.delegate = vp
        self.viewPresenter = vp
        self.viewController = vc
    }
}
