//
//  AddTodoViewModel.swift
//  ReactiveTodos
//
//  Created by Drew Dunne on 4/2/18.
//  Copyright © 2018 Daniel Li. All rights reserved.
//

import Foundation
import ReactiveSwift

class AddTodoViewModel: ViewModel<AddTodoViewModel.Dependencies, AddTodoViewModel.UserAction> {
    struct Dependencies {
        var todos: [Todo]
    }
    
    enum UserAction {
        case finishAdd(() -> Void)
    }
    
    var todos: MutableProperty<[Todo]>!
    var todo = MutableProperty<String>("")
    
    override func configure(dependencies: AddTodoViewModel.Dependencies) {
        todos = MutableProperty<[Todo]>(dependencies.todos)
    }
    
    override func handle(action: AddTodoViewModel.UserAction) {
        switch action {
        case .finishAdd(let completion):
            todos.value.append(Todo(title: todo.value, completed: false))
            completion()
            print("Finishing Add")
        }
    }
}

extension AddTodoViewModel: HasViewController {
    typealias ViewController = AddTodoViewController
}
