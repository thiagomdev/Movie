import XCTest
@testable import Movies

final class MoviewDetailViewModelTests: XCTestCase {
    func test_releaseDate() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "17-10-24")]
        
        let viewModel = MoviewDetailViewModel(movie)
        let releaseDate = viewModel.releaseDate
    
        XCTAssertEqual(releaseDate, "24 de outubro de 0017", "Should returned the correct release date")
    }
     
    func test_voteAverage() {
        let movie: Set<MovieResult> = [.fixture(voteAverage: 8)]
        let viewModel = MoviewDetailViewModel(movie)
        let voteAverage = viewModel.voteAverage
        
        XCTAssertEqual(voteAverage, "Avaliação: 8")
    }
    
    func test_posterPath() {
        let movie: Set<MovieResult> = [.fixture(posterPath: "/path/to/poster.jpg")]
        let viewModel = MoviewDetailViewModel(movie)
        let posterPath = viewModel.img
        
        XCTAssertEqual(posterPath, "/path/to/poster.jpg", "Should returned the correct poster path")
    }
    
    func test_allResults() {
        let movie: Set<MovieResult> = [.fixture(
            releaseDate: "2024-10-17",
            voteAverage: 8.5,
            posterPath: "/path/to/poster.jpg"
        )]
        
        let viewModel = MoviewDetailViewModel(movie)
        let releaseDate = viewModel.releaseDate
        let voteAverage = viewModel.voteAverage
        let posterPath = viewModel.img 
        
        XCTAssertEqual(releaseDate, "17 de outubro de 2024", "Should be returned the correct release date")
        XCTAssertEqual(posterPath, "/path/to/poster.jpg", "Should be returned the correct poster path")
        XCTAssertEqual(voteAverage, "Avaliação: 8", "Should be returned the correct vote average")
    }
}

extension MovieResult {
    static func fixture(
        releaseDate: String = "",
        voteAverage: Double = 0.0,
        posterPath: String = "") -> Self {
        
        .init(
            adult: true,
            backdropPath: nil,
            genreIDS: nil,
            id: 0,
            originalLanguage: nil,
            originalTitle: nil,
            overview: "",
            popularity: 0.0,
            posterPath: posterPath,
            releaseDate: releaseDate,
            title: nil,
            video: true,
            voteAverage: voteAverage,
            voteCount: nil
        )
    }
}
