import Foundation

protocol MoviewDetailViewModelProtocol {
    var img: String { get }
    var releaseDate: String { get }
    var voteAverage: String { get }
    var overview: String { get }
}

final class MoviewDetailViewModel {
    private let allMovies: Set<MovieResult>
    
    init(_ allMovies: Set<MovieResult>) {
        self.allMovies = allMovies
    }
}

extension MoviewDetailViewModel: MoviewDetailViewModelProtocol {
    var releaseDate: String {
        if let release = allMovies.first?.releaseDate {
            return formatterStr(apiDate: release)
        }
        return String()
    }
    
    var voteAverage: String {
        if let rate = allMovies.first?.voteAverage {
            return "Avaliação: \(Int(rate))"
        }
        return String()
    }
    
    var img: String {
        if let url = allMovies.first?.posterPath {
            return url
        }
        return String()
    }
    
    var overview: String {
        return allMovies.first?.overview ?? ""
    }
    
    func formatterStr(apiDate: String) -> String {
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

