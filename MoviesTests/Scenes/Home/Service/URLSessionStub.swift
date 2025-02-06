import Foundation

final class URLSessionStub: URLProtocol {
    private static var stub: Stub?
    private static var observerRequest: [((URLRequest) -> Void)]?
    
    private struct Stub {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    static func stub(data: Data?, response: URLResponse?, error: Error?) {
        stub = Stub(data: data, response: response, error: error)
    }
    
    static func observerRequests(_ observer: @escaping (URLRequest) -> Void) {
        observerRequest?.append(observer)
    }
    
    static func startInterceptionRequests() {
        URLProtocol.registerClass(URLSessionStub.self)
    }
    
    static func stopInterceptionRequests() {
        URLProtocol.unregisterClass(URLSessionStub.self)
        stub = nil
        observerRequest = nil
    }
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let observer = URLSessionStub.observerRequest?.first {
            client?.urlProtocolDidFinishLoading(self)
            return observer(request)
        }
        
        if let data = URLSessionStub.stub?.data {
            client?.urlProtocol(self, didLoad: data)
        }
        
        if let response = URLSessionStub.stub?.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        
        if let error = URLSessionStub.stub?.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
