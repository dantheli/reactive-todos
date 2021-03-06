//
//  AddTodoViewController.swift
//  ReactiveTodos
//
//  Created by Drew Dunne on 4/2/18.
//  Copyright © 2018 Daniel Li. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class AddTodoViewController: UIViewController {
    
    var addButton: UIBarButtonItem!
    
    var textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        textField.reactive.text <~ viewModel.todo
        viewModel.todo <~ textField.reactive.continuousTextValues.skipNil()
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        textField.becomeFirstResponder()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        addButton.reactive.pressed = CocoaAction(viewModel.userAction, input: .finishAdd { [weak self] in
            self?.navigationController?.popViewController(animated: true)
            })
        navigationItem.rightBarButtonItem = addButton
        print("Adding")
    }

}

extension AddTodoViewController: HasViewModel {
    typealias ViewModelType = AddTodoViewModel
}
