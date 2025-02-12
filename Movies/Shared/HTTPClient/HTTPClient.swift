import Foundation

public enum HTTPResultClient {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func excute(_ request: URLRequest, callback: @escaping (HTTPResultClient) -> Void)
}
