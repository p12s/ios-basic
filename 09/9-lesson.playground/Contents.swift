import UIKit

func sum(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func processTuple(_ tuple: (Int, String)) {
    let number = tuple.0
    let string = tuple.1
    let result = String(number) + string
    print(result)
}

func runIfPositive(_ closure: (() -> Void)?, number: Int) {
    if number > 0 {
        closure?()
    }
}

func isLeapYear(_ year: Int) -> Bool {
    if year % 4 != 0 {
        return false
    } else if year % 100 != 0 {
        return true
    } else if year % 400 != 0 {
        return false
    } else {
        return true
    }
}

let sumResult = sum(5, 3)
print("\nСумма: \(sumResult)")
// Сумма: 8

let tupleResult = (42, " лет")
processTuple(tupleResult)
// 42 лет

runIfPositive({
    print("\nЧисло положительное!")
}, number: 5)
// Число положительное!
runIfPositive({
    print("\nЭто не должно вывестись")
}, number: -3)
//

let year1 = 2024
let year2 = 2023
print("\n\(year1) високосный: \(isLeapYear(year1))")
print("\(year2) високосный: \(isLeapYear(year2))")
// 2024 високосный: true
// 2023 високосный: false

