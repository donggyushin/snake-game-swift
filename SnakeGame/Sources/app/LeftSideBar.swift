import SwiftUI

struct LeftSideBar: View {
    @ObservedObject var parentModel: ContentViewModel
    @StateObject var model: LeftSideBarModel
    @State var showSaveGameRecordAlert = false
    @Environment(\.openWindow) var openWindow

    var body: some View {
        VStack(alignment: .leading) {
            Text("score: \(parentModel.currentScore)")
            Text("speed: tick per \(parentModel.tickInterval)")

            if parentModel.isGameOver {
                Button("Restart") {
                    parentModel.generateInitialSnake()
                    model.canSaveGame = true
                }

                Button("Save Record") {
                    showSaveGameRecordAlert = true
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
    }
}
