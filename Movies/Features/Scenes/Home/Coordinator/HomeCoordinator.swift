import UIKit

enum HomeActions: Equatable {
    case start
    case detail(movie: MovieResult)
}

protocol HomeCoordinating: AnyObject {
    func navigate(to view: HomeActions)
}

final class HomeCoordinator {
    private let navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}
extension HomeCoordinator: HomeCoordinating {
    func navigate(to view: HomeActions) {
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
