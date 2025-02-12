import Foundation

protocol HomeViewModelProtocol {
    var movies: Set<[MovieResult]> { get set }
    var cell: Set<[HomeCellViewModel]> { get set }
    
    func fetchData(callback: @escaping (Result<Movie, Error>) -> Void)
    func display(dataSource:  Movie)
}

final class HomeViewModel {
    private let service: MovieServiceProtocol
    private var model = Set<[MovieResult]>()
    private var customCell = Set<[HomeCellViewModel]>()
<<<<<<< HEAD
    
    init(service: NetworkingProtocol) {
=======
        
    init(service: MovieServiceProtocol) {
>>>>>>> f8ec996 (- Reorganized networking)
        self.service = service
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
            DispatchQueue.main.async {
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
    
    func display(dataSource:  Movie) {
        _ = dataSource.results.compactMap { movies in
            cell.insert([HomeCellViewModel(movies)])
        }
    }
}
