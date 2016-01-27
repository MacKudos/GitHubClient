//
//  RepositoriesPresenter.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

class RepositoriesPresenter <T where T: UIViewController, T: RepositoriesViewControllerProtocol> : ViewControllerPresenter<UIViewController>, UITableViewDataSource {

    private var vc: T
    private var repos:[Repository]
    let refreshControll:UIRefreshControl
    
    init(viewController:T) {
        
        self.vc = viewController
        self.repos = []
        self.refreshControll = UIRefreshControl()
        super.init()
        
        self.refreshControll.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
    }
    
    func setup() {
        
        self.vc.tableView.dataSource = self
        self.vc.presentButton.addTarget(self, action: Selector("presentData"), forControlEvents: UIControlEvents.TouchUpInside)
        self.vc.tableView.addSubview(self.refreshControll)
    }
    
    
    // так же можно ввести отдельную сущность как DataSource, но в нашем случае сервис repositoriesService играет эту роль
    func presentData() {
        
        let userName = self.vc.textField.text
        let service = ServiceHolder.sharedInstance.repositoriesService

        self.refreshControll.beginRefreshing()
        
        service?.obtainRepositoriesForUser(userName!, callback: { (repositories:[Repository]?) -> Void in
            
            self.refreshControll.endRefreshing()
            self.repos = repositories!
            self.vc.tableView.reloadData()
        })
    }
    
    func refresh(refreshControl: UIRefreshControl) {
        self.refreshControll.endRefreshing()
    }
    
    // optional objectic-c протокол нельзя вынести в extension =(, как следует по гайдлайну
    
    @objc func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    @objc func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = repos[indexPath.row].name
        
        return cell
    }
}

extension RepositoriesPresenter: UIViewControllerProtocol {
    
    func viewDidLoad() {
        self.setup()
    }
    
    func viewWillApear() {
        
    }
}