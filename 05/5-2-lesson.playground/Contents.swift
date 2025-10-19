import Foundation

enum ShapeValidationError: Error {
  case invalidRadius
  case invalidSide
  case invalidTriangleSides
  case triangleInequalityViolation
}

class Shape {
  var name: String
  var corners: Int
  
  init(name: String, corners: Int) {
    self.name = name
    self.corners = corners
  }
  
  func getName() -> String {
    return name
  }
  
  func draw() -> String {
    fatalError("should be overridden")
  }
  
  func getArea() -> Double {
    fatalError("should be overridden")
  }
  
  func getPerimeter() -> Double {
    fatalError("should be overridden")
  }
}

class Circle: Shape {
  private var radius: Double
  init?(_ radius: Double) {
    self.radius = radius
    super.init(name: "Circle", corners: 0)
    if radius <= 0 {
      return nil
    }
  }
  
  func getRadius() -> Double {
    return radius
  }
  
  func setRadius(_ radius: Double) throws {
    guard radius > 0 else {
      throw ShapeValidationError.invalidRadius
    }
    self.radius = radius
  }
  
  override func draw() -> String {
    return "\(name) drawing, \(corners) corners, \(radius) radius"
  }
  
  override func getArea() -> Double {
    return .pi * radius * radius
  }
  
  override func getPerimeter() -> Double {
    return 2 * .pi * radius
  }
}

class Square: Shape {
  private var side: Double
  init?(_ side: Double) {
    self.side = side
    super.init(name: "Square", corners: 4)
    if side <= 0 {
      return nil
    }
  }
  
  func getSide() -> Double {
    return side
  }
  
  func setSide(_ side: Double) throws {
    guard side > 0 else {
      throw ShapeValidationError.invalidSide
    }
    self.side = side
  }
  
  override func draw() -> String {
    return "\(name) drawing, \(corners) corners, [\(side)] side"
  }
  
  override func getArea() -> Double {
    return side * side
  }
  
  override func getPerimeter() -> Double {
    return 4 * side
  }
}

class Triangle: Shape {
  private var a, b, c: Double
  init?(_ a: Double, _ b: Double, _ c: Double) {
    self.a = a
    self.b = b
    self.c = c
    super.init(name: "Triangle", corners: 3)
    if a <= 0 || b <= 0 || c <= 0 {
      return nil
    }
    if a + b < c && a + c < b && b + c < a {
      return nil
    }
  }
  
  func getSides() -> (Double, Double, Double) {
    return (a, b, c)
  }
  
  func setSides(_ a: Double, _ b: Double, _ c: Double) throws {
    guard a > 0 && b > 0 && c > 0 else {
      throw ShapeValidationError.invalidTriangleSides
    }
    guard a + b > c && a + c > b && b + c > a else {
      throw ShapeValidationError.triangleInequalityViolation
    }
    self.a = a
    self.b = b
    self.c = c
  }
  
  override func draw() -> String {
    return "\(name) drawing, \(corners) corners, [\(a), \(b), \(c)] sides"
  }
  
  override func getArea() -> Double {
    let p = (a + b + c) / 2
    return sqrt(p * (p - a) * (p - b) * (p - c))
  }
  
  override func getPerimeter() -> Double {
    return a + b + c
  }
}

let shapes: [Shape?] = [
  Triangle(2, 3, 4),
  Square(5),
  Circle(3)
]

for shape in shapes {
  if let shape = shape {
    print("\(shape.draw())")
    print("Area = \(shape.getArea()), Perimeter = \(shape.getPerimeter())")
    print()
  } else {
    print("Failed to create shape")
  }
}

/*
 Triangle drawing, 3 corners, [2.0, 3.0, 4.0] sides
 Area = 2.9047375096555625, Perimeter = 9.0

 Square drawing, 4 corners, [5.0] side
 Area = 25.0, Perimeter = 20.0

 Circle drawing, 0 corners, 3.0 radius
 Area = 28.274333882308138, Perimeter = 18.84955592153876
*/


