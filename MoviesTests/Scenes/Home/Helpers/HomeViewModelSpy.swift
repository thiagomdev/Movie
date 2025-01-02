@testable import Movies

final class HomeViewModelSpy: NetworkingProtocol {
    var expected: (Result<Movies.Movie, any Error>)?

    private(set) var fetchDataMoviesCalled: Bool = false
    private(set) var fetchDataMoviesCount: Int = 0
    
    func fetchDataMovies(callback: @escaping (Result<Movies.Movie, any Error>) -> Void) {
        fetchDataMoviesCalled = true
        fetchDataMoviesCount += 1
        if let expected {
            callback(expected)
        }
    }
}
