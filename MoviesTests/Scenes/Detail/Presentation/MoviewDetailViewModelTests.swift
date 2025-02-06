import XCTest
@testable import Movies

final class MoviewDetailViewModelTests: XCTestCase {
    func test_empty_release_date() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "")]
        
        let releaseDate = movie.first?.releaseDate
    
        XCTAssertEqual(releaseDate, "")
    }
    
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
    
    func test_formatter_str_with_valid_date() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "2025-01-12")]
        let sut = MoviewDetailViewModel(movie)
        guard let date = movie.first?.releaseDate else { return }
        let result = sut.formatterStr(apiDate: "\(date) d 'de' MMMM 'de' yyyy")
        
        XCTAssertEqual(result, date)
    }
    
    func test_formatter_str_with_invalid_date() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "01-04-2025")]
        let sut = MoviewDetailViewModel(movie)
        
        let result = sut.formatterStr(apiDate: "01-04-2025")
        
        let currentDate = DateFormatter()
        currentDate.dateFormat = "yyyy-MM-dd"
        let expected = currentDate.string(from: Date())
        
        XCTAssertEqual(result, expected)
    }
    
    func test_formatter_str_with_empty_date() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "")]
        let sut = MoviewDetailViewModel(movie)
        
        let result = sut.formatterStr(apiDate: "")
        
        let currentDate = DateFormatter()
        currentDate.dateFormat = "yyyy-MM-dd"
        let expected = currentDate.string(from: Date())
        
        XCTAssertEqual(result, expected)
    }
    
    func test_formatter_str_with_boundary_date() {
        let movie: Set<MovieResult> = [.fixture(releaseDate: "0001-01-01")]
        let sut = MoviewDetailViewModel(movie)
        
        let result = sut.formatterStr(apiDate: "1 de janeiro de 1")
        
        let currentDate = DateFormatter()
        currentDate.dateFormat = "yyyy-MM-dd"
        let expected = currentDate.string(from: Date())
        
        XCTAssertEqual(result, expected)
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
