import UIKit
import ReactiveSwift
import Result

protocol ViewModelType {
    associatedtype UserActionType
    associatedtype DependenciesType
    func handle(userAction: UserActionType)
    func configure(dependencies: DependenciesType)
}

extension ViewModelType {
    func handle(userAction: UserActionType) {}
    func configure(dependencies: DependenciesType) {}
}

class ViewModel<Dependencies, UserAction>: NSObject, ViewModelType {
    typealias DependenciesType = Dependencies
    typealias UserActionType = UserAction

    let (userAction, userActionObserver) = Signal<UserAction, NoError>.pipe()

    init(dependencies: Dependencies) {
        super.init()
        configure(dependencies: dependencies)
        userAction.observeValues { [weak self] action in
            self?.handle(userAction: action)
        }
    }
}

protocol HasViewController {
    associatedtype ViewController: HasViewModel
}

extension HasViewController where ViewController.ViewModel == Self, ViewController: UIViewController {
    func createViewController() -> ViewController  {
        var viewController = ViewController()
        viewController.viewModel = self
        return viewController
    }
}

protocol HasViewModel {
    associatedtype ViewModel
    var viewModel: ViewModel { get set }
}

private var ViewModelAssociatedKey: UInt8 = 0

extension HasViewModel where Self: UIViewController {
    var viewModel: ViewModel {
        get {
            return objc_getAssociatedObject(self, &ViewModelAssociatedKey) as! ViewModel
        }
        set {
            objc_setAssociatedObject(self, &ViewModelAssociatedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
