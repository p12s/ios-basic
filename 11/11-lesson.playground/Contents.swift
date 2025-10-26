import UIKit

class Vehicle {
    private var engineHours: Double = 0.0
    private var maintenanceCount: Int = 0
    
    fileprivate var lastServiceDate: Date?
    
    internal var mileage: Double = 0.0
    internal var isRunning: Bool = false
  
    public let brand: String
    public let model: String
    public var year: Int
  
    public init(brand: String, model: String, year: Int) {
        self.brand = brand
        self.model = model
        self.year = year
    }
    
    internal init(brand: String, model: String, year: Int, mileage: Double) {
        self.brand = brand
        self.model = model
        self.year = year
        self.mileage = mileage
    }
    
    public func start() {
        isRunning = true
        print("\(brand) \(model) заведен")
    }
    
    public func stop() {
        isRunning = false
        print("\(brand) \(model) заглушен")
    }
    
    public func drive(distance: Double) {
        if isRunning {
            mileage += distance
            engineHours += distance / 60.0
            print("\(brand) \(model) проехал \(distance) км")
        } else {
            print("Сначала заведите \(brand) \(model)")
        }
    }
    
    internal func getInfo() -> String {
        return "\(brand) \(model) (\(year)) - пробег: \(mileage) км"
    }
    
    internal func performMaintenance() {
        maintenanceCount += 1
        lastServiceDate = Date()
        print("\(brand) \(model) прошел ТО №\(maintenanceCount)")
    }
    
    private func calculateWear() -> Double {
        return Double(maintenanceCount) * 0.1 + engineHours * 0.05
    }
    
    fileprivate func getMaintenanceInfo() -> String {
        return "ТО: \(maintenanceCount), последнее: \(lastServiceDate?.description ?? "никогда")"
    }
}

class Car: Vehicle {
    private var fuelLevel: Double = 100.0
    
    public var numberOfDoors: Int
    public var fuelType: String
    
    public init(brand: String, model: String, year: Int, numberOfDoors: Int, fuelType: String) {
        self.numberOfDoors = numberOfDoors
        self.fuelType = fuelType
        super.init(brand: brand, model: model, year: year)
    }
    
    public override func start() {
        if fuelLevel > 0 {
            super.start()
            print("Двигатель автомобиля запущен")
        } else {
            print("Нет топлива для запуска \(brand) \(model)")
        }
    }
    
    internal override func getInfo() -> String {
        let baseInfo = super.getInfo()
        return "\(baseInfo), дверей: \(numberOfDoors), топливо: \(fuelType)"
    }
    
    public func refuel(amount: Double) {
        fuelLevel = min(100.0, fuelLevel + amount)
        print("\(brand) \(model) заправлен. Уровень топлива: \(fuelLevel)%")
    }
    
    public func openTrunk() {
        print("Багажник \(brand) \(model) открыт")
    }
    
    private func checkFuelLevel() -> Bool {
        return fuelLevel > 10.0
    }
}

class Motorcycle: Vehicle {
    private var helmetStored: Bool = false

    public var engineSize: Double
    public var hasWindshield: Bool
  
    public init(brand: String, model: String, year: Int, engineSize: Double, hasWindshield: Bool) {
        self.engineSize = engineSize
        self.hasWindshield = hasWindshield
        super.init(brand: brand, model: model, year: year)
    }
    
    public override func start() {
        super.start()
        print("Мотоцикл \(brand) \(model) готов к поездке")
    }
    
    internal override func getInfo() -> String {
        let baseInfo = super.getInfo()
        return "\(baseInfo), объем двигателя: \(engineSize)л, ветровое стекло: \(hasWindshield ? "есть" : "нет")"
    }
    
    public func storeHelmet() {
        helmetStored = true
        print("Шлем убран в \(brand) \(model)")
    }
    
    public func takeHelmet() {
        helmetStored = false
        print("Шлем взят из \(brand) \(model)")
    }
    
    public func wheelie() {
        if isRunning {
            print("\(brand) \(model) делает вилли!")
        } else {
            print("Сначала заведите мотоцикл для вилли")
        }
    }
    
    private func checkSafety() -> Bool {
        return helmetStored && isRunning
    }
}

func demonstratePolymorphism() {
    print("=== Демонстрация полиморфизма ===\n")
    
    let vehicles: [Vehicle] = [
        Car(brand: "Toyota", model: "Camry", year: 2020, numberOfDoors: 4, fuelType: "Бензин"),
        Car(brand: "Tesla", model: "Model 3", year: 2022, numberOfDoors: 4, fuelType: "Электричество"),
        Motorcycle(brand: "Honda", model: "CBR600", year: 2021, engineSize: 0.6, hasWindshield: true),
        Motorcycle(brand: "Yamaha", model: "YZF-R1", year: 2023, engineSize: 1.0, hasWindshield: false)
    ]
    
    for vehicle in vehicles {
        print("--- \(type(of: vehicle)) ---")
        
        vehicle.start()
        vehicle.drive(distance: 50.0)
        print(vehicle.getInfo())
        
        if let car = vehicle as? Car {
            car.refuel(amount: 20.0)
            car.openTrunk()
        } else if let motorcycle = vehicle as? Motorcycle {
            motorcycle.storeHelmet()
            motorcycle.wheelie()
        }
        
        vehicle.stop()
        print()
    }
    
    print("=== Демонстрация уровней доступа ===")
    let car = Car(brand: "BMW", model: "X5", year: 2023, numberOfDoors: 5, fuelType: "Бензин")
    
    print("Публичные: \(car.brand) \(car.model)")
    car.start()
    
    print("Внутренние: \(car.getInfo())")
    car.performMaintenance()
    
    print("Файловые приватные: \(car.getMaintenanceInfo())")
}

demonstratePolymorphism()
/*
 === Демонстрация полиморфизма ===

 --- Car ---
 Toyota Camry заведен
 Двигатель автомобиля запущен
 Toyota Camry проехал 50.0 км
 Toyota Camry (2020) - пробег: 50.0 км, дверей: 4, топливо: Бензин
 Toyota Camry заправлен. Уровень топлива: 100.0%
 Багажник Toyota Camry открыт
 Toyota Camry заглушен

 --- Car ---
 Tesla Model 3 заведен
 Двигатель автомобиля запущен
 Tesla Model 3 проехал 50.0 км
 Tesla Model 3 (2022) - пробег: 50.0 км, дверей: 4, топливо: Электричество
 Tesla Model 3 заправлен. Уровень топлива: 100.0%
 Багажник Tesla Model 3 открыт
 Tesla Model 3 заглушен

 --- Motorcycle ---
 Honda CBR600 заведен
 Мотоцикл Honda CBR600 готов к поездке
 Honda CBR600 проехал 50.0 км
 Honda CBR600 (2021) - пробег: 50.0 км, объем двигателя: 0.6л, ветровое стекло: есть
 Шлем убран в Honda CBR600
 Honda CBR600 делает вилли!
 Honda CBR600 заглушен

 --- Motorcycle ---
 Yamaha YZF-R1 заведен
 Мотоцикл Yamaha YZF-R1 готов к поездке
 Yamaha YZF-R1 проехал 50.0 км
 Yamaha YZF-R1 (2023) - пробег: 50.0 км, объем двигателя: 1.0л, ветровое стекло: нет
 Шлем убран в Yamaha YZF-R1
 Yamaha YZF-R1 делает вилли!
 Yamaha YZF-R1 заглушен

 === Демонстрация уровней доступа ===
 Публичные: BMW X5
 BMW X5 заведен
 Двигатель автомобиля запущен
 Внутренние: BMW X5 (2023) - пробег: 0.0 км, дверей: 5, топливо: Бензин
 BMW X5 прошел ТО №1
 Файловые приватные: ТО: 1, последнее: 2025-10-26 10:11:32 +0000
 */
