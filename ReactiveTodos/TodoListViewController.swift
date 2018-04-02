import UIKit

class TodoListViewController: UIViewController {
    
    var addButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        navigationItem.rightBarButtonItem = addButton
        print("omg we have filtered todos", viewModel.filteredTodos)
    }
    
    @objc func addPressed() {
        print("pressed")
        viewModel.handle(userAction: .presentAdd)
    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModel = TodoListViewModel
}

