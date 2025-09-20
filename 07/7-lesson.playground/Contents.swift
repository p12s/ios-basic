
import Foundation

protocol Describable {
    var description: String { get }
}

struct User: Describable, Equatable {
    private(set) var name: String
    let email: String
    let isStudent: Bool
    
    init(_ name: String, _ email: String, _ isStudent: Bool) {
        self.name = name
        self.email = email
        self.isStudent = isStudent
    }
    
    var description: String {
        let status = isStudent ? "Студент" : "Не студент"
        return "Имя: \(name), Email: \(email), Статус: \(status)"
    }
    
    mutating func updateName(to newName: String) {
        name = newName
    }
}

var users: [User] = [
    User("Иван", "ivan@mail.ru", true),
    User("Ксения", "ksenia@mail.ru", false)
]

users.forEach { user in
    print(user.description)
}

print()
users[0].updateName(to: "Иван Иванов")

users.forEach { user in
    print(user.description)
}

print()
let students = users.filter { $0.isStudent }
print("Найдено студентов: \(students.count)")
students.forEach { print($0.description) }
