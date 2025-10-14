struct Square {
    var x: Double
    var y: Double
    var direction = Direction.allCases.randomElement() ?? .right
}
