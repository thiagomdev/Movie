import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: HomeCoordinating?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return runApp()
    }
}

extension AppDelegate {
    private func runApp() -> Bool {
        window = UIWindow(frame: UIScreen.main.coordinateSpace.bounds)
        window?.makeKeyAndVisible()
        let navigation = UINavigationController()
        coordinator = HomeCoordinator(navigation: navigation)
        window?.rootViewController = navigation
        coordinator?.navigate(to: .start)
        return true
    }
}
