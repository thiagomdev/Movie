@testable import Movies

extension Movie {
    static func fixture(results: [MovieResult] = [.fixture()]) -> Self {
        .init(
            page: 0,
            results: [],
            totalPages: 0,
            totalResults: 0
        )
    }
}

extension MovieResult {
    static func fixture(title: String = String()) -> Self {
        .init(
            adult: false,
            backdropPath: nil,
            genreIDS: nil,
            id: 0,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "",
            popularity: 0.0,
            posterPath: nil,
            title: title,
            video: false,
            voteAverage: 0.0,
            voteCount: nil
        )
    }
}

final class MovieResultAbstractFactory {
    // MARK: - Apenas um exemplo do que é um Abstract Factory
    func makeMovieFactory() -> Movie {
        .init(
            page: 0,
            results: [],
            totalPages: 0,
            totalResults: 0
        )
    }
    
    func makeMovieResultFactory() -> MovieResult {
        .init(
            adult: false,
            backdropPath: nil,
            genreIDS: nil,
            id: 0,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "",
            popularity: 0.0,
            posterPath: nil,
            title: nil,
            video: false,
            voteAverage: 0.0,
            voteCount: nil
        )
    }
}
