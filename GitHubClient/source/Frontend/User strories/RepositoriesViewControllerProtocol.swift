//
//  RepositoriesViewControllerProtocol.swift
//  GitHubClient
//
//  Created by Sergey on 27/01/16.
//  Copyright © 2016 epam. All rights reserved.
//

import UIKit

protocol RepositoriesViewControllerProtocol {

    var tableView : UITableView! {get}
    var textField : UITextField! {get}
    var presentButton : UIButton! {get}
}