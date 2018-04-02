import UIKit
import SnapKit
import ReactiveCocoa
import ReactiveSwift

class TodoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("omg we have filtered todos", viewModel.filteredTodos)
        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.setTitle("hi", for: .normal)
        button.reactive.pressed = CocoaAction(viewModel.userAction, input: .presentAdd { [weak self] in
            self?.present(UINavigationController(rootViewController: UIViewController()), animated: true, completion: nil)
        })
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension TodoListViewController: HasViewModel {
    typealias ViewModelType = TodoListViewModel
}

