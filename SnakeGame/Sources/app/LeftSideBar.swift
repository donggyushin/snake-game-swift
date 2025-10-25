import SwiftUI

struct LeftSideBar: View {
    @ObservedObject var parentModel: ContentViewModel
    @StateObject var model: LeftSideBarModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("score: \(parentModel.currentScore)")
            Text("speed: tick per \(parentModel.tickInterval)")

            if parentModel.isGameOver {
                Button("Restart") {
                    parentModel.generateInitialSnake()
                }

                Button("Save Record") {
                    print("save record")
                }
            }
        }
    }
}
