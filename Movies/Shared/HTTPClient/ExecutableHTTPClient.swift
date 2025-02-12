import Foundation

public final class ExecutableHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func excute(_ request: URLRequest, callback: @escaping (HTTPResultClient) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                callback(.failure(error))
            } else if let data, let httpResponse = response as? HTTPURLResponse {
                callback(.success(data, httpResponse))
            } else {
                callback(.failure(error!))
            }
        }.resume()
    }
}
