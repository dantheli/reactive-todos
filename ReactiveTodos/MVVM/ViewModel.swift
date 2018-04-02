import UIKit
import ReactiveSwift
import Result

class ViewModel<Dependencies, UserAction>: NSObject {

    lazy var userAction: Action<UserAction, Void, NoError> = {
        return Action<UserAction, Void, NoError> { [weak self] value in
            self?.handle(action: value)
            return .empty
        }
    }()

    init(dependencies: Dependencies) {
        super.init()
        configure(dependencies: dependencies)
    }

    func configure(dependencies: Dependencies) {}
    func handle(action: UserAction) {}
}
