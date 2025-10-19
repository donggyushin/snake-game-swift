struct Square {
    var x: Double
    var y: Double
    var direction = Direction.allCases.randomElement() ?? .right

    var key: String {
        "\(x),\(y)"
    }
}

extension Collection where Element == Square {
    func score() -> Int {
        count * 10
    }
}
