import UIKit

struct ScreenSize {
    let width: CGFloat
    let height: CGFloat
}

enum AppleDevice: CustomStringConvertible {
    case iPhone17
    case iPhone17Air
    case iPhone17Pro
    case iPhone17ProMax
    case iPadAir
    case iPadPro
    case iPadMini
    
    var description: String {
        switch self {
        case .iPhone17:
            return "iPhone 17 - базовый"
        case .iPhone17Air:
            return "iPhone 17 Air - супер-тонкий"
        case .iPhone17Pro:
            return "iPhone 17 Pro - классический"
        case .iPhone17ProMax:
            return "iPhone 17 Pro Max - максимальный"
        case .iPadAir:
            return "iPad Air - универсальный"
        case .iPadPro:
            return "iPad Pro - профессиональный"
        case .iPadMini:
            return "iPad mini - компактный"
        }
    }
    
    var screenSize: ScreenSize {
        switch self {
        case .iPhone17:
            return ScreenSize(width: 1170, height: 2532)
        case .iPhone17Air:
            return ScreenSize(width: 1125, height: 2436)
        case .iPhone17Pro:
            return ScreenSize(width: 1179, height: 2556)
        case .iPhone17ProMax:
            return ScreenSize(width: 1290, height: 2796)
        case .iPadAir:
            return ScreenSize(width: 1640, height: 2360)
        case .iPadPro:
            return ScreenSize(width: 2048, height: 2732)
        case .iPadMini:
            return ScreenSize(width: 1488, height: 2266)
        }
    }
    
    var isIPad: Bool {
        switch self {
        case .iPadAir, .iPadPro, .iPadMini:
            return true
        default:
            return false
        }
    }
}

let devices: [AppleDevice] = [.iPhone17, .iPhone17Air, .iPhone17Pro, .iPhone17ProMax, .iPadAir, .iPadPro, .iPadMini]

for device in devices {
    print(device.description)
    print("Размер экрана: \(device.screenSize.width) x \(device.screenSize.height)")
    print("Это iPad: \(device.isIPad)")
    print("---")
}
