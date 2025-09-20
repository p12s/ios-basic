
class Calc {
  private var a: Double
  private var b: Double
  
  init(a: Double = 0, b: Double = 0) {
    self.a = a
    self.b = b
  }
  
  func sum() -> Double? {
    let res = a + b
    return res.isFinite ? res : nil
  }
  
  func subtract() -> Double? {
    let res = a - b
    return res.isFinite ? res : nil
  }
  
  func multiply() -> Double? {
    let res = a * b
    return res.isFinite ? res : nil
  }
  
  func divide() -> Double? {
    guard b != 0 else { return nil }
    let res = a / b
    return res.isFinite ? res : nil
  }
}

let calc = Calc(a: 10, b: 3)

print("sum: \(calc.sum() ?? 0)")
print("subtract: \(calc.subtract() ?? 0)")
print("multiply: \(calc.multiply() ?? 0)")
print("divide: \(calc.divide() ?? 0)")

/*
sum: 13.0
subtract: 7.0
multiply: 30.0
divide: 3.3333333333333335
*/
