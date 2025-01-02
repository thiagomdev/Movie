import Foundation

protocol MoviewDetailViewModelProtocol {
    var img: String { get }
    var releaseDate: String { get }
    var voteAverage: String { get }
    var overview: String { get }
}

final class MoviewDetailViewModel {
    private let allMovies: MovieResult
    
    init(_ allMovies: MovieResult) {
        self.allMovies = allMovies
    }
}

extension MoviewDetailViewModel: MoviewDetailViewModelProtocol {
    var releaseDate: String {
        return formatterStr(apiDate: "\(allMovies.releaseDate ?? "")")
    }
    
    var voteAverage: String {
        if let rate = allMovies.voteAverage {
            return "Avaliação: \(Int(rate))"
        }
        return String()
    }
    
    var img: String {
        if let url = allMovies.posterPath {
            return url
        }
        return String()
    }
    
    var overview: String {
        return allMovies.overview
    }
    
    private func formatterStr(apiDate: String) -> String {
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dataFormatter.date(from: apiDate) {
            let output = DateFormatter()
            output.locale = Locale(identifier: "pt_BR")
            output.dateFormat = "d 'de' MMMM 'de' yyyy"
            let formatted = output.string(from: date)
            return formatted
        }
        return dataFormatter.string(from: Date())
    }
}

