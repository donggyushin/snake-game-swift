import Foundation

private let decoder = JSONDecoder()
private let encoder = JSONEncoder()

@propertyWrapper
class UserDefaultsWrapper<T: Codable> {
    let key: String
    let defaultValue: T

    var wrappedValue: T {
        get {
            if let data = UserDefaults.standard.object(forKey: key) as? Data,
               let decoded = try? decoder.decode(T.self, from: data) {
                return decoded
            } else {
                return defaultValue
            }
        }
        set {
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
            }
        }
    }

    init(_ key: String, _ defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}
