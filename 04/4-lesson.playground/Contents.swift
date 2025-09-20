
let maxCapacity: Int = 200
var arr: [Int] = []
arr.reserveCapacity(maxCapacity)

for i in 0..<maxCapacity {
  let randInt = Int.random(in: 0...1000)
  arr.append(randInt)
}

print("Array:", arr)


var indexDict = [Int: Int]()
var found = false

for (index, item) in arr.enumerated() {
  if let firstIndex = indexDict[item] {
          print("Found repeating element: \(item) at index \(firstIndex)")
          found = true
          break
      } else {
          indexDict[item] = index
      }
}

if !found {
  print("-1")
}
