import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class TodoListViewController: UIViewController {
    
    var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        addButton.reactive.pressed = CocoaAction(viewModel.userAction, input: .presentAdd { [weak self] in
            let viewModel = AddTodoViewModel(dependencies: AddTodoViewModel.Dependencies(todos: (self?.viewModel.todos.value)!))
            let addVC = viewModel.createViewController()
            self?.navigationController?.pushViewController(addVC, animated: true)
            })
        navigationItem.rightBarButtonItem = addButton
        print("omg we have filtered todos", viewModel.filteredTodos)
        view.backgroundColor = .white

    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModelType = TodoListViewModel
}

