import SwiftUI

public struct ContentView: View {

    let grid = 30.0

    @StateObject var model: ContentViewModel

    public init(
        model: ContentViewModel
    ) {
        self._model = .init(wrappedValue: model)
    }

    public var body: some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false
        ) { context, size in
            context.opacity = 0.3

            for i in (1..<Int(grid)) {
                let y = size.height / grid * Double(i)

                let horizontalLinePath = Path { path in
                    path.move(to: .init(x: 0, y: y))
                    path.addLine(to: .init(x: size.width, y: y))
                }
                context.stroke(horizontalLinePath, with: .color(.gray))

                let x = size.width / grid * Double(i)

                let verticalLinePath = Path { path in
                    path.move(to: .init(x: x, y: 0))
                    path.addLine(to: .init(x: x, y: size.height))
                }
                context.stroke(verticalLinePath, with: .color(.gray))
            }

            let rect = CGRect(x: 0, y: 0, width: size.width / grid, height: size.height / grid)
            context.fill(Rectangle().path(in: rect), with: .color(.red))

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: .init())
            .frame(width: 700, height: 700)
    }
}
