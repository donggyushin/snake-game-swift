import Combine

final class EventBus {
    static let shared = EventBus()

    let nicknameEventForSavingRecord = PassthroughSubject<String, Never>()

    private init() {}
}
