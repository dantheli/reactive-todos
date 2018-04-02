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
        case finishAdd
    }
    
    var todos: MutableProperty<[Todo]>!
    var todo = MutableProperty<String>("")
    
    func configure(dependencies: TodoListViewModel.Dependencies) {
        todos = MutableProperty<[Todo]>(dependencies.todos)
        
    }
    
    func handle(userAction: AddTodoViewModel.UserAction) {
        switch userAction {
        case .finishAdd:
            todos.value.append(Todo(title: todo.value, completed: false))
            print("Finishing Add")
        }
    }
}

extension AddTodoViewModel: HasViewController {
    typealias ViewController = AddTodoViewController
}
