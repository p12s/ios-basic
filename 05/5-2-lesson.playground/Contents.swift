import Foundation

class Shape {
  public private(set) var name: String
  init(name: String) {
    self.name = name
  }
  
  public final func getName() -> String {
    return name
  }
  
  open func getArea() -> Double {
    fatalError("should be overridden")
  }
  
  open func getPerimeter() -> Double {
    fatalError("should be overridden")
  }
}

class Circle: Shape {
  private var radius: Double
  init(_ radius: Double) {
    self.radius = radius
    super.init(name: "Circle")
  }
  
  public final func getRadius() -> Double {
    return radius
  }
  
  public final func setRadius(_ radius: Double) {
    self.radius = radius
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
  init(_ side: Double) {
    self.side = side
    super.init(name: "Square")
  }
  
  public final func getSide() -> Double {
    return side
  }
  
  public final func setSide(_ side: Double) {
    self.side = side
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
  init(_ a: Double, _ b: Double, _ c: Double) {
    self.a = a
    self.b = b
    self.c = c
    super.init(name: "Triangle")
  }
  
  public final func getSides() -> (Double, Double, Double) {
    return (a, b, c)
  }
  
  public final func setSides(_ a: Double, _ b: Double, _ c: Double) {
    self.a = a
    self.b = b
    self.c = c
  }
  
  override func getArea() -> Double {
    let p = (a + b + c) / 2
    return sqrt(p * (p - a) * (p - b) * (p - c))
  }
  
  override func getPerimeter() -> Double {
    return a + b + c
  }
}

let shapes: [Shape] = [
  Triangle(2, 3, 4),
  Square(5),
  Circle(3)
]

for shape in shapes {
  print("\(shape.getName()): Area = \(shape.getArea()), Perimeter = \(shape.getPerimeter())")
}

/*
Triangle: Area = 2.9047375096555625, Perimeter = 9.0
Square: Area = 25.0, Perimeter = 20.0
Circle: Area = 28.274333882308138, Perimeter = 18.84955592153876
*/


