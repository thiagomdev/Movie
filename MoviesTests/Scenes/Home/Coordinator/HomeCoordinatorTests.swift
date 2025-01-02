import XCTest
@testable import Movies

final class HomeCoordinatorTests: XCTestCase {
    func test_navigateAction_whenNavigationIsCalled_shouldReturned_HomeViewController() {
        let (sut, mock) = makeSut()
        
        sut.navigate(to: .start)
        
        XCTAssertNotNil(mock.pushedViewController, "The pushViewControllerCalled cannot be nil")
        XCTAssertTrue(mock.pushViewControllerCalled, "The pushViewControllerCalled needs to be true")
        XCTAssertEqual(mock.pushViewControllerCount, 1, "The pushViewControllerCalled needs to be called once")
        XCTAssertTrue(mock.pushedViewController is HomeViewController, "The pushViewControllerCalled needs to be HomeViewController")
    }
    
    func test_navigateAction_whenNavigationIsCalled_shouldReturnedDetailViewController() {
        let (sut, mock) = makeSut()
        
        sut.navigate(to: .detail(movie: [.fixture()]))
        
        XCTAssertNotNil(mock.pushedViewController, "The pushViewControllerCalled cannot be nil")
        XCTAssertTrue(mock.pushViewControllerCalled, "The pushViewControllerCalled needs to be true")
        XCTAssertEqual(mock.pushViewControllerCount, 1, "The pushViewControllerCalled needs to be called once")
        XCTAssertTrue(mock.pushedViewController is MovieDetailViewController, "The pushViewControllerCalled needs to be MovieDetailViewController")
    }
}

extension HomeCoordinatorTests {
    private func makeSut() -> (sut: HomeCoordinator, mock: MockNavigationViewController) {
        let mock = MockNavigationViewController()
        let sut = HomeCoordinator(navigation: mock)
        
        trackForMemoryLeaks(for: sut)
        trackForMemoryLeaks(for: mock)
        
        return (sut, mock)
    }
}

final class MockNavigationViewController: UINavigationController {
    private(set) var pushedViewController: UIViewController?
    private(set) var pushViewControllerCalled: Bool = false
    private(set) var pushViewControllerCount: Int = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushViewControllerCalled = true
        pushViewControllerCount += 1
        pushedViewController = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
