import UIKit

class TodoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("omg we have filtered todos", viewModel.filteredTodos)
    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModel = TodoListViewModel
}

