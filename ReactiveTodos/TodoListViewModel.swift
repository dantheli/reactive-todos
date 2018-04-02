import Foundation
import ReactiveSwift

class TodoListViewModel: ViewModel<TodoListViewModel.Dependencies, TodoListViewModel.UserAction> {
    struct Dependencies {
        var todos: [Todo]
    }

    enum UserAction {
        case presentAdd
        case clearAll
    }

    var todos: Property<[Todo]>!
    var filteredTodos: Property<[Todo]>!
    var query = MutableProperty<String>("")

    func configure(dependencies: TodoListViewModel.Dependencies) {
        todos = Property<[Todo]>(value: dependencies.todos)
        
        let filteredTodosSignal = Signal.combineLatest(todos.signal, query.signal)
            .map { todos, query in
                todos.filter {
                    $0.title.lowercased().contains(query.lowercased())
                }
            }
        filteredTodos = Property<[Todo]>(initial: [], then: filteredTodosSignal)
    }

    func handle(userAction: TodoListViewModel.UserAction) {
        switch userAction {
        case .presentAdd:
            let viewModel = AddTodoViewModel(dependencies: AddTodoViewModel.Dependencies(todos: todos.value))
            let addVC = viewModel.createViewController()
//            viewController.navigationController?.pushViewController(addVC, animated: true)
            print("Adding")
        case .clearAll:
            print("Clear all")
        }
    }

}

extension TodoListViewModel: HasViewController {
    typealias ViewController = TodoListViewController
}
