import XCTest
@testable import Movies

final class HomeViewModelTests: XCTestCase {
    private typealias MovieResponse = (Result<Movies.Movie, any Error>)
    
    func test_fetch_data_success() {
        let (sut, spy) = makeSut()
        
        spy.expected = .success(.fixture())
        
        expect(sut, when: .success(.fixture()), then: {
            XCTAssertTrue(spy.fetchDataMoviesCalled, "Should be called")
            XCTAssertEqual(spy.fetchDataMoviesCount, 1, "Should be called once")
        })
    }
    
    func test_fetch_data_failure() {
        let (sut, spy) = makeSut()
        
        let error: NSError = .init(domain: "error", code: -999)
        spy.expected = .failure(error)
        
        expect(sut, when: .failure(error), then: {
            XCTAssertTrue(spy.fetchDataMoviesCalled, "Should be called")
            XCTAssertEqual(spy.fetchDataMoviesCount, 1, "Should be called once")
        })
    }
    
    private func makeSut(
        file: StaticString = #file,
        line: UInt = #line) -> (sut: HomeViewModel, spy: HomeViewModelSpy) {
        let spy = HomeViewModelSpy()
        let sut = HomeViewModel(service: spy)
        
        trackForMemoryLeaks(for: sut, file: file, line: line)
        trackForMemoryLeaks(for: spy, file: file, line: line)
        
        return (sut, spy)
    }
    
    private func expect(
        _ sut: HomeViewModel,
        when expectedResult: MovieResponse,
        then action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for a completion block!")
            
        sut.fetchData { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receved), .success(expected)):
                XCTAssertEqual(receved, expected, file: file, line: line)
            case let (.failure(receivedError as NSError), .failure(expectedError as NSError)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
            default:
                XCTFail(
                    "Expected result \(receivedResult) got \(expectedResult) instead",
                    file: file,
                    line: line
                )
            }
            exp.fulfill()
        }
        
        action()
            
        wait(for: [exp], timeout: 3.0)
    }
}

extension XCTestCase {
     func trackForMemoryLeaks(for
        instance: AnyObject,
        file: StaticString = #file,
        line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(
                instance,
                "Instance should have been deallocated. Potential memory leak.",
                file: file,
                line: line
            )
        }
    }
}
