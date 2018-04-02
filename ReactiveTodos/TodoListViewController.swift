import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class TodoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModelType = TodoListViewModel
}

