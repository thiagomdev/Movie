import Foundation

protocol HomeViewModelProtocol {
    var movies: Set<[MovieResult]> { get set }
    var cell: Set<[HomeCellViewModel]> { get set }
    
    func fetchData(callback: @escaping (Result<Movie, Error>) -> Void)
}

final class HomeViewModel {
    private let service: NetworkingProtocol
    private var model = Set<[MovieResult]>()
    private var customCell = Set<[HomeCellViewModel]>()
        
    init(service: NetworkingProtocol) {
        self.service = service
    }
    
    private func display(dataSource:  Movie) {
        _ = dataSource.results.compactMap { movies in
            cell.insert([HomeCellViewModel(movies)])
        }
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    var movies: Set<[MovieResult]> {
        get { model }
        set { model = newValue }
    }
    
    var cell: Set<[HomeCellViewModel]> {
        get { customCell }
        set { customCell = newValue }
    }
    
    func fetchData(callback: @escaping (Result<Movie, any Error>) -> Void) {
        service.fetchDataMovies { [weak self] result in
            switch result {
            case let .success(movie):
                callback(.success(movie))
                self?.display(dataSource: movie)
            case let .failure(error):
                callback(.failure(error))
            }
        }
    }
}
