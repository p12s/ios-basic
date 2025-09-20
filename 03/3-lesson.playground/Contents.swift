// Есть произвольный массив чисел, найти максимальное и минимальное число и поменять их местами

var items = [4, 0, 12, 6, 7, 1, 13]
items.append(894)
items.remove(at: 2)
print("Input: \(items)")

var minIndex = 0
var maxIndex = 0

for (index, item) in items.enumerated() {
    if item < items[minIndex] {
        minIndex = index
    }
    if item > items[maxIndex] {
        maxIndex = index
    }
}

items.swapAt(minIndex, maxIndex)

print("Result: \(items)")
print("")

// Есть две коллекции символов - собрать результирующее множество из символов, что повторяются в 2х коллекциях

var chars1: Set<Character> = ["p", "d", "a", "b", "f", "c", "д", "ж", "з"]
chars1.insert("x")
chars1.remove("t")
let chars2: Set<Character> = ["g", "a", "e", "b", "c", "r", "t"]
print("chars1: \(chars1)")
print("chars2: \(chars2)")

let intersection: Set<Character> = chars1.intersection(chars2)
print("Intersection: \(intersection)")
print("")

/* Создать словарь с соотношением имя (ключ) пользователя - пароль (значение),
 получить из словаря все имена, пароли которых длиннее 10 символов
*/

var userPasswords: [String: String] = [
  "ivan": "1234523r34r34r",
  "petr": "99012334rr332r",
  "boris": "::JDWOIjo",
  "maxim": "9023",
  "eva": "ksl",
  "paul": "sdfg23r34r32r",
  "magen": "wger",
]
userPasswords["ivan"] = "super-secure"
userPasswords.removeValue(forKey: "magen")
print("userPasswords: \(userPasswords)")

var strongUserPasswords: [String: String] = [:]
for (user, pass) in userPasswords {
  if pass.count < 10 {
    continue
  }
  strongUserPasswords[user] = pass
}
print("strongUserPasswords: \(strongUserPasswords)")
