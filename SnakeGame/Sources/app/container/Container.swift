import Foundation

final class Container {
    static let shared = Container()

    private init() {}

    private var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    private var isTest: Bool = {
        var testing = false
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            testing = true
        }
        if ProcessInfo.processInfo.processName.contains("xctest") {
            testing = true
        }
        return testing
    }()

    private let scoreRepositoryUserDefaults = ScoreRepositoryUserDefaults()
    private let scoreRepositoryMock = ScoreRepositoryMock()

    var scoreRepository: ScoreRepository {
        if isPreview || isTest {
            return scoreRepositoryMock
        } else {
            return scoreRepositoryUserDefaults
        }
    }
}
