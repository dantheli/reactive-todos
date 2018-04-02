import Foundation
import ReactiveSwift
import PromiseKit

class TodoListViewModel: ViewModel<TodoListViewModel.Dependencies, TodoListViewModel.UserAction> {
    struct Dependencies {
        var todos: [Todo]
    }

    enum UserAction {
        case presentAdd(() -> Void)
        case clearAll
    }

    var todos: Property<[Todo]>!
    var filteredTodos: Property<[Todo]>!
    var query = MutableProperty<String>("")

    override func configure(dependencies: TodoListViewModel.Dependencies) {
        todos = Property<[Todo]>(value: dependencies.todos)
        
        let filteredTodosSignal = Signal.combineLatest(todos.signal, query.signal)
            .map { todos, query in
                todos.filter {
                    $0.title.lowercased().contains(query.lowercased())
                }
            }
        filteredTodos = Property<[Todo]>(initial: [], then: filteredTodosSignal)

        query.signal.observeValues { value in
            print(value)
        }
    }

    override func handle(action: TodoListViewModel.UserAction) {
        switch action {
        case .presentAdd(let completion):
            print("Adding")
            completion()
        case .clearAll:
            print("Clear all")
        }
    }

}

extension TodoListViewModel: HasViewController {
    typealias ViewController = TodoListViewController
}
