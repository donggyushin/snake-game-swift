import SwiftUI

@main
struct SnakeGameApp: App {
    @State var nickname = ""
    @Environment(\.dismissWindow) private var dismissWindow

    var body: some Scene {
        WindowGroup {
            ContentView(model: .init(grid: 32))
        }

        // Define a new window with an identifier and content
        Window("Nickname Form", id: "nickname-form") {
            VStack(alignment: .leading, spacing: 30) {
                TextField("Nickname", text: $nickname)

                Button("Save") {
                    guard !nickname.isEmpty else { return }
                    EventBus.shared.nicknameEventForSavingRecord.send(nickname)
                    nickname = ""
                    dismissWindow.callAsFunction(id: "nickname-form")
                }
            }
            .padding(20)
            .onAppear {
                nickname = ""
            }
        }
    }
}
