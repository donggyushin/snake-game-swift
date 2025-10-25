import SwiftUI

struct LeftSideBar: View {
    @ObservedObject var parentModel: ContentViewModel
    @Environment(\.openWindow) var openWindow
    @StateObject var model: LeftSideBarModel
    @State var showSaveGameRecordAlert = false

    var body: some View {
        VStack(alignment: .leading) {
            Text("score: \(parentModel.currentScore)")
            Text("speed: tick per \(parentModel.tickInterval)")

            if parentModel.isGameOver {
                Button("Restart") {
                    parentModel.generateInitialSnake()
                    model.canSaveGame = true
                }

                if model.canSaveGame {
                    Button("Save Record") {
                        showSaveGameRecordAlert = true
                    }
                }
            }

            List(model.scores) { score in
                VStack(alignment: .leading) {
                    Text("nickname: \(score.nickname)")
                    Text("score: \(score.value)")
                }
                .contextMenu {
                    Button("Delete") {
                        model.deleteScore(score)
                    }
                }
            }
        }
        .onAppear {
            model.fetchScores()
        }
        .alert("Save game record?", isPresented: $showSaveGameRecordAlert) {
            Button("Cancel", role: .cancel) {
                showSaveGameRecordAlert = false
            }
            Button("OK") {
                Task {
                    // Action to perform when OK is tapped
                    showSaveGameRecordAlert = false // Dismiss the alert explicitly if needed, though often automatic
                    try await Task.sleep(for: .seconds(0.7))
                    openWindow.callAsFunction(id: "nickname-form")
                }
            }
        }
        .onReceive(EventBus.shared.nicknameEventForSavingRecord) { nickname in
            model.saveGame(
                value: parentModel.currentScore,
                createdAt: Date(),
                nickname: nickname
            )
        }
    }
}
