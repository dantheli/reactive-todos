//
//  ViewController.swift
//  ReactiveTodos
//
//  Created by Daniel Li on 4/1/18.
//  Copyright © 2018 Daniel Li. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModel = TodoListViewModel
}

