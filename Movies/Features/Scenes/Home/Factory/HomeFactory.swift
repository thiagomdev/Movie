import UIKit

enum HomeFactory {
    static func make(coordinator: HomeCoordinating) -> UIViewController {
        let service = Networking(session: .shared)
        let viewModel = HomeViewModel(service: service)
        let view = HomeView()
        let viewController = HomeViewController(viewModel: viewModel, homeView: view)
        viewController.coodinator = coordinator
        return viewController
    }
}
