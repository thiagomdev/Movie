import XCTest
@testable import Movies

final class NetworkingTests: XCTestCase {

    override func setUp() {
        super.setUp()
        URLSessionStub.startInterceptionRequests()
    }
    
    override func tearDown() {
        super.tearDown()
        URLSessionStub.stopInterceptionRequests()
    }
    
    func test_get_fromURL_perfoms_GET_requests_with_URL() {
        let url = anyURL
        let exp = expectation(description: "Wait for a completion block")
        
        URLSessionStub.observerRequests { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        makeSut().fetchDataMovies { _ in }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_get_from_URL_fails_on_request_error() {
        let requestError = anyError
        
        let receivedError = resultErrorFor(data: nil, response: nil, error: requestError)
        
        XCTAssertNotNil(receivedError)
    }
    
    func test_get_from_URL_fails_on_all_invalid_representations_cases() {
        XCTAssertNotNil(resultErrorFor(data: anyData, response: nil, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: nonHTTPResponse, error: anyError))
        XCTAssertNotNil(resultErrorFor(data: nil, response: anyHTTPResponse, error: anyError))
    }
}

extension NetworkingTests {
    private func makeSut(file: StaticString = #file, line: UInt = #line) -> NetworkingProtocol {
        let sut = Networking(session: .shared)
        trackForMemoryLeaks(for: sut, file: file, line: line)
        return sut
    }
    
    private func resultErrorFor(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line) -> Error? {
            
            let result = resultFor(
                data: data,
                response: response,
                error: error,
                file: file,
                line: line
            )
            
            switch result {
            case let .failure(error):
                return error
            default:
                XCTFail("Expected failure, got \(String(describing: result)) instead.",
                        file: file,
                        line: line
                )
                return nil
            }
        }
    
    private func resultValuesFor(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line) -> (data: Data, response: HTTPURLResponse)? {
            
            let result = resultFor(
                data: data,
                response: response,
                error: error,
                file: file,
                line: line
            )
            
            switch result {
            case let .success(movie):
                XCTAssertNotNil(movie)
                XCTAssertEqual(movie.results, [.fixture()])
                
            default:
                XCTFail(
                    "Expected success, got \(String(describing: result)) instead.",
                    file: file,
                    line: line
                )
                return nil
            }
            return nil
        }
    
    private func resultFor(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        file: StaticString = #file,
        line: UInt = #line) -> (Result<Movie, any Error>)? {
            
            URLSessionStub.stub(data: data, response: response, error: error)
            
            let exp = expectation(description: "Wait for completion block")
            let sut = makeSut(file: file, line: line)
            
            var receivedResult: (Result<Movie, any Error>)?
            sut.fetchDataMovies { result in
                receivedResult = result
                exp.fulfill()
            }
            wait(for: [exp], timeout: 1.0)
            return receivedResult
        }
    
    private var anyURL: URL? {
        return URL(string: "https://api.themoviedb.org/3/discover/movie")
    }
    
    private var anyData: Data {
        return Data(_: "any data".utf8)
    }
    
    private var nonHTTPResponse: URLResponse {
        return URLResponse(
            url: anyURL ?? .applicationDirectory,
            mimeType: nil,
            expectedContentLength: 0,
            textEncodingName: nil
        )
    }
    
    private var anyHTTPResponse: HTTPURLResponse {
        return  HTTPURLResponse(
            url: anyURL ?? .applicationDirectory,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )!
    }
    
    private var anyError: NSError {
        return NSError(domain: "any error", code: 1)
    }
}

final class URLSessionStub: URLProtocol {
    private static var stub: Stub?
    private static var observerRequest: ((URLRequest) -> Void)?
    
    private struct Stub {
        let data: Data?
        let response: URLResponse?
        let error: Error?
    }
    
    static func stub(data: Data?, response: URLResponse?, error: Error?) {
        stub = Stub(data: data, response: response, error: error)
    }
    
    static func observerRequests(_ observer: @escaping (URLRequest) -> Void) {
        observerRequest = observer
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
        if let observer = URLSessionStub.observerRequest {
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
