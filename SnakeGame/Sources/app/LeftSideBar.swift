import SwiftUI

struct LeftSideBar: View {
    @ObservedObject var parentModel: ContentViewModel
    @StateObject var model: LeftSideBarModel
    @State var showSaveGameRecordAlert = false
    @State var showNicknameForm = false
    @State var nickname = ""

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
                    print("save record")
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
                    nickname = ""
                    try await Task.sleep(for: .seconds(0.7))
                    withAnimation {
                        showNicknameForm = true
                    }
                }
            }
        }
        .overlay {
            if showNicknameForm {
                VStack(alignment: .leading, spacing: 30) {
                    TextField("Nickname", text: $nickname)

                    Button("Save") {
                        guard !nickname.isEmpty else { return }
                        model.saveGame(
                            value: parentModel.currentScore,
                            createdAt: Date(),
                            nickname: nickname
                        )
                        nickname = ""
                    }
                }
                .padding(20)
                .background {
                    RoundedRectangle(cornerRadius: 20)
                }
            }
        }
    }
}
