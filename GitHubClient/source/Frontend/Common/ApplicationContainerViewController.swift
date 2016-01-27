//
//  ApplicationContainerViewController.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

class ApplicationContainerViewController: UIViewController {

    //Здесь могут быть делегаты на стейты или объект их содержащий, патерн Composit
    //var specificStateDelegate:applicationCoordinatorProtocol
    //var specificState2Delegate:applicationCoordinatorProtocol
    
    var wirframes:[Wireframe]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        
        ServiceHolder.sharedInstance.applicationCoordinator?.delegate = self
        self.processMainState()
    }
    
    func processMainState() {
        
        let wireFrame = RepositoriesWireframe()
        self.view.addSubview(wireFrame.viewController.view)
        self.addChildViewController(wireFrame.viewController)
        self.wirframes?.append(wireFrame)
    }
}

extension ApplicationContainerViewController: applicationCoordinatorProtocol {
    
    func applicationShooldPresentAuthorizationView() {
        
    }
    
    func applicationShooldPresentError(er:NSError) {
        
        UIAlertView(title: "Ошибка", message: er.localizedDescription, delegate: nil, cancelButtonTitle: "Закрыть").show()
    }
    
    func applicationSholdProcessUIState(state:ApplicationState) {
        self.processMainState()
    }
}
