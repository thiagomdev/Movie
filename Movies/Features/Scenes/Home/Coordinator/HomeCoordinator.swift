import UIKit

public enum HomeActions: Equatable {
    case start
    case detail(movie: Set<MovieResult>)
}

public protocol HomeCoordinating: AnyObject {
    func navigate(to view: HomeActions)
}

public final class HomeCoordinator {
    private let navigation: UINavigationController
    
    public init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension HomeCoordinator: HomeCoordinating {
    public func navigate(to view: HomeActions) {
        switch view {
        case .start:
            let home = HomeFactory.make(coordinator: self)
            navigation.pushViewController(home, animated: true)
        case let .detail(movies):
            let home = DetailFactory.make(for: movies)
            navigation.pushViewController(home, animated: true)
        }
    }
}
