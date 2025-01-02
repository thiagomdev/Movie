import Foundation

protocol ViewConfiguration: AnyObject {
    func buildViews()
    func pin()
    func extraSetup()
    func setup()
}

extension ViewConfiguration {
    func setup() {
        buildViews()
        pin()
        extraSetup()
    }
}
