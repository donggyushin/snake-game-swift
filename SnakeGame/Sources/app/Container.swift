import Foundation

final class Container {
    static let shared = Container()

    private init() {}

    var isPreview: Bool = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    var isTest: Bool = {
        var testing = false
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            testing = true
        }
        if ProcessInfo.processInfo.processName.contains("xctest") {
            testing = true
        }
        return testing
    }()

    let scoreRepositoryUserDefaults = ScoreRepositoryUserDefaults()
    let scoreRepositoryMock = ScoreRepositoryMock()

    var scoreRepository: ScoreRepository {
        if isPreview || isTest {
            return scoreRepositoryMock
        } else {
            return scoreRepositoryUserDefaults
        }
    }
}
