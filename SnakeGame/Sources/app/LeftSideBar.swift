import SwiftUI

struct LeftSideBar: View {
    @ObservedObject var model: ContentViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("score: \(model.currentScore)")
            Text("speed: tick per \(model.tickInterval)")

            if model.isGameOver {
                Button("Restart") {
                    print("Restart Game")
                }
            }
        }
    }
}
