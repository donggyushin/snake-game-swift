import SwiftUI

public struct ContentView: View {
    @StateObject var model: ContentViewModel

    public init(
        model: ContentViewModel
    ) {
        _model = .init(wrappedValue: model)
    }

    public var body: some View {
        TimelineView(.animation) { _ in
            Canvas(
                opaque: true,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                drawCanvas(context: context, size: size)
            }
        }
        .task {
            model.generateInitialSnake()
            while !Task.isCancelled {
                let interval = model.tickInterval
                let nanoseconds = UInt64(interval * 1_000_000_000)
                do {
                    try await Task.sleep(nanoseconds: nanoseconds)
                } catch {
                    break
                }
                model.tick()
            }
        }
        .focusable()
        .onKeyPress { keyPress in
            switch keyPress.key {
            case .upArrow:
                return changeDirection(.up)
            case .downArrow:
                return changeDirection(.down)
            case .leftArrow:
                return changeDirection(.left)
            case .rightArrow:
                return changeDirection(.right)
            default:
                return .ignored
            }
        }
        .frame(width: 700, height: 700)
    }

    private func drawCanvas(context: GraphicsContext, size: CGSize) {
        var context = context
        context.opacity = 0.3

        for i in 1 ..< Int(model.grid) {
            let y = size.height / model.grid * Double(i)

            let horizontalLinePath = Path { path in
                path.move(to: .init(x: 0, y: y))
                path.addLine(to: .init(x: size.width, y: y))
            }
            context.stroke(horizontalLinePath, with: .color(.gray))

            let x = size.width / model.grid * Double(i)

            let verticalLinePath = Path { path in
                path.move(to: .init(x: x, y: 0))
                path.addLine(to: .init(x: x, y: size.height))
            }
            context.stroke(verticalLinePath, with: .color(.gray))
        }

        for square in model.snake {
            let rect = CGRect(
                x: size.width / model.grid * square.x,
                y: size.height / model.grid * square.y,
                width: size.width / model.grid,
                height: size.height / model.grid
            )
            context.fill(Rectangle().path(in: rect), with: .color(.red))
        }

        for food in model.foods {
            let rect = CGRect(
                x: size.width / model.grid * food.x,
                y: size.height / model.grid * food.y,
                width: size.width / model.grid,
                height: size.height / model.grid
            )
            context.fill(Circle().path(in: rect), with: .color(.yellow))
        }
    }

    private func changeDirection(_ direction: Direction) -> KeyPress.Result {
        Task { @MainActor in
            model.set(direction)
        }
        return .handled
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: .init())
    }
}
