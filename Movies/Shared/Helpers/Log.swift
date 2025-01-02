import Foundation

enum Log {
    static func queue(action: String) {
        DispatchQueue.log(action)
    }
    
    static func location(
        fileName: String,
        functionName: String = #function,
        lineNumber: Int = #line) {
            
            print("Called by => \(fileName.components(separatedBy: "/").last?.uppercased() ?? fileName): => \(functionName.uppercased()): at line => \(lineNumber)")
    }
}

extension DispatchQueue {
    static func log(_ action: String) {
        print("""
                \(action):
                🚀 \(String(validatingUTF8: __dispatch_queue_get_label(nil))!)
                🧵 \(Thread.current)

            """)
    }
}
