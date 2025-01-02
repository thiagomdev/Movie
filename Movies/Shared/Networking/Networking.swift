import Foundation

protocol NetworkingProtocol {
    func fetchDataMovies(callback: @escaping (Result<Movie, Error>) -> Void)
}

final class Networking {
    private let session: URLSession
    private let strUrl: String = "https://api.themoviedb.org/3/discover/movie"
    
    init(session: URLSession) {
        self.session = session
    }
}

extension Networking: NetworkingProtocol {
    func fetchDataMovies(callback: @escaping (Result<Movie, any Error>) -> Void) {
        if let url = URL(string: strUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            session.dataTask(with: request) { data, response, error in
                if let error { callback(.failure(error)) }
                if let data = data,
                   let response = response as? HTTPURLResponse {
                    if (200..<300).contains(response.statusCode) {
                        do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            decoder.dateDecodingStrategy = .iso8601
                            let movies = try decoder.decode(Movie.self, from: data)
                            callback(.success(movies))
                        } catch {
                            callback(.failure(error))
                        }
                    }
                }
            }.resume()
        }
    }
}
