import UIKit

// 1
final class ViewController: UIViewController {
 
    var workItem: DispatchWorkItem?
     
    func execute() {
        let workItem = DispatchWorkItem {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.view.alpha = 0.1
            }
        }

        self.workItem = workItem
        DispatchQueue.main.async(execute: workItem) // добавлен запуск DispatchWorkItem
    }

}
 
autoreleasepool {
    let vc = ViewController()
    vc.execute()
}

// 2
class Class1 {
    var property: Int = 3
    var struct1 = Struct1()
 
    func execute() {
        /*struct1.closure = {
            self.property = 2  // self - это strong reference
        }*/
        struct1.closure = { [weak self] in  // weak self
            self?.property = 2
        }
    }
 
}
 
autoreleasepool {
    var s: Class1? = Class1()
    s?.execute()
    s = nil
}
