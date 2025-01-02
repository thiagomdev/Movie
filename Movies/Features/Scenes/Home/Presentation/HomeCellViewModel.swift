import Foundation

struct HomeCellViewModel: Equatable, Hashable {
    var title: String
    var overview: String
    var imgURL: String
    
    
    init(_ movie: MovieResult) {
        self.title = movie.title ?? ""
        self.overview = movie.overview
        self.imgURL = movie.posterPath ?? ""
    }
}
