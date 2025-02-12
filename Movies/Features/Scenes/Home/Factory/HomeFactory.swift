import UIKit

<<<<<<< HEAD
public enum HomeFactory {
    public static func make(coordinator: HomeCoordinating) -> UIViewController {
        let service = Networking(session: .shared)
=======
internal enum HomeFactory {
    static func make(coordinator: HomeCoordinating) -> UIViewController {
        let service = MovieService(session: ExecutableHTTPClient())
>>>>>>> f8ec996 (- Reorganized networking)
        let viewModel = HomeViewModel(service: service)
        let view = HomeView()
        let viewController = HomeViewController(viewModel: viewModel, homeView: view)
        viewController.coodinator = coordinator
        return viewController
    }
}
