import Foundation

final class Observable<T> {
    var value: T? {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                listener?(value)
            }
        }
    }
    
    private var listener: ((T?) -> Void)?
    
    init(_ value: T? = nil) {
        self.value = value
    }
    
    func bind(_ listener: @escaping ((T?) -> Void)) {
        listener(value)
        self.listener = listener
    }
}
