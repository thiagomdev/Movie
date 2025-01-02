import UIKit

enum DetailFactory {
    static func make(for movies: MovieResult) -> UIViewController {
        let viewModel = MoviewDetailViewModel(movies)
        let viewController = MovieDetailViewController(viewModel: viewModel)
        return viewController
    }
}
