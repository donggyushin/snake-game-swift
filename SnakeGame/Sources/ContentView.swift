import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false) { context, size in
                context.opacity = 0.3
            }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 700, height: 700)
    }
}
