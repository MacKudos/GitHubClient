//
//  RepositoriesViewController.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController, RepositoriesViewControllerProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var presentButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    var delegate:UIViewControllerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        self.delegate?.viewWillApear()
    }
}
