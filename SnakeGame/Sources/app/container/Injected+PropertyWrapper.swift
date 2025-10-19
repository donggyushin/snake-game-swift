import Foundation

@propertyWrapper
class Injected<T> {
    let keyPath: KeyPath<Container, T>

    var wrappedValue: T {
        Container.shared[keyPath: keyPath]
    }

    init(_ keyPath: KeyPath<Container, T>) {
        self.keyPath = keyPath
    }
}
