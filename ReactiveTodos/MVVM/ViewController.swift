import UIKit

protocol HasViewController {
    associatedtype ViewController: HasViewModel
}

extension HasViewController where ViewController.ViewModelType == Self, ViewController: UIViewController {
    func createViewController() -> ViewController {
        var viewController = ViewController()
        viewController.viewModel = self
        return viewController
    }
}

protocol HasViewModel {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }
}

private var ViewModelAssociatedKey: UInt8 = 0

extension HasViewModel where Self: UIViewController {
    var viewModel: ViewModelType {
        get {
            return objc_getAssociatedObject(self, &ViewModelAssociatedKey) as! ViewModelType
        }
        set {
            objc_setAssociatedObject(self, &ViewModelAssociatedKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
