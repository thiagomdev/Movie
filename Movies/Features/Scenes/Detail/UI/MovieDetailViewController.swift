import UIKit

final class MovieDetailViewController: UIViewController {
    private let viewModel: MoviewDetailViewModelProtocol
    
    private lazy var detailView: MovieDetailView = {
        let view = MovieDetailView()
        return view
    }()
    
    init(viewModel: MoviewDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
 
    override func loadView() {
        super.loadView()
        view = detailView
        displayDetail()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func displayDetail() {
        detailView.setup(
            imageURL: viewModel.img,
            overview: viewModel.overview,
            releaseDate: viewModel.releaseDate,
            voteAverage: viewModel.voteAverage
        )
    }
}
