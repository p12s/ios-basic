protocol Describable {
    var description: String { get }
}

struct User {
    var name: String
    let email: String
    let isStudent: Bool
    
    var description: String {
        let status = isStudent ? "Студент" : "Не студент"
        return "Имя: \(name), Email: \(email), Статус: \(status)"
    }
}

var users: [User] = [
    User(name: "Иван", email: "ivan@mail.ru", isStudent: false),
    User(name: "Ксения", email: "ksenia@mail.ru", isStudent: true),
    User(name: "Петр", email: "petr@mail.ru", isStudent: false),
    User(name: "Семен", email: "semen@mail.ru", isStudent: true)
]

users.forEach { user in
    print(user.description)
}

print()
users[1].name = "Ксения Петрова"

users.forEach { user in
    print(user.description)
}

let students = users.filter { $0.isStudent }
print("\nНайдено студентов: \(students.count)")
students.forEach { print($0.description) }

/*
 Имя: Иван, Email: ivan@mail.ru, Статус: Не студент
 Имя: Ксения Петрова, Email: ksenia@mail.ru, Статус: Студент
 Имя: Петр, Email: petr@mail.ru, Статус: Не студент
 Имя: Семен, Email: semen@mail.ru, Статус: Студент

 Найдено студентов: 2
 Имя: Ксения Петрова, Email: ksenia@mail.ru, Статус: Студент
 Имя: Семен, Email: semen@mail.ru, Статус: Студент
*/
