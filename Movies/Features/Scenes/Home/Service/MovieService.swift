import Foundation

internal enum MovieServiceResult {
    case success(Movie)
    case failure(Error)
}

protocol MovieServiceProtocol {
    func fetchDataMovies(callback: @escaping (MovieServiceResult) -> Void)
}

final class MovieService {
    private let session: HTTPClient
    private let strUrl: String = "https://api.themoviedb.org/3/discover/movie"
    
    init(session: HTTPClient) {
        self.session = session
    }
}

extension MovieService: MovieServiceProtocol {
    func fetchDataMovies(callback: @escaping (MovieServiceResult) -> Void) {
        if let url = URL(string: strUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = [
              "accept": "application/json",
              "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyZjk0NDk4ZDA0ZGFjZDFjZjk2NjQ4YmIxN2NlYmM2NyIsIm5iZiI6MTY5MzQwMDczNS44NjA5OTk4LCJzdWIiOiI2NGVmM2U5Zjk3YTRlNjAwYzQ4NjJjZGIiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.AAAJG3OLN5csc3p4V0MJyNwmMpGbPJcIIU-SwYWDrv8"
            ]
            
            session.excute(request) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case let .success(data, hTTPURLResponse):
                    callback(MovieMapper.map(data, response: hTTPURLResponse))
                case let .failure(error):
                    callback(.failure(error))
                }
            }
        }
    }
    
    private enum UnnexpectedError: Error { case unowned }
    
    private enum MovieMapper {
        static let OK_200: Int = 200
        static func map(_ data: Data, response: HTTPURLResponse) -> MovieServiceResult {
            guard response.statusCode == OK_200,
                  let movie = try? JSONDecoder().decode(Movie.self, from: data) else {
                return .failure(UnnexpectedError.unowned)
            }
            return .success(movie)
        }
    }
}
