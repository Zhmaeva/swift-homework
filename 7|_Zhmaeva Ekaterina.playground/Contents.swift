import UIKit
import Foundation

//MARK: - Урок 7. Управление ошибками в приложениях.

/*
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
*/

enum ResultErrors: Error {
    case notInMenu
    case notEnoughMoney
}

struct Dishes {
    var count: Int
    var price: Int
}


class Restaurant {
    
    var wallet = 0
    
    var dishes = [
        "HotDog": Dishes(count: 1, price: 300),
        "Fried potatoes": Dishes(count: 3, price: 150),
        "Juice": Dishes(count: 0, price: 90)
    ]
    
    func getTheDish(withName: String) throws {     //Получаем блюдо, генерируем ошибки
        guard var dish = dishes[withName] else {
            throw ResultErrors.notInMenu           //есть ли такое блюдо?
        }
        
        guard dish.count > 0 else {
            throw ResultErrors.notInMenu           //проверяем количественное наличие
        }
        
        guard dish.price <= wallet else {         //достаточно ли денег?
            throw ResultErrors.notEnoughMoney
        }
        
        wallet -= dish.price            //если пройдены все проверки, выполняется этот блок
        dish.count -= 1
        dishes[withName] = dish
        print("You bought the dish \(withName).")
    }
}

let resraurant = Restaurant()
resraurant.wallet = 1000
try? resraurant.getTheDish(withName: "Dish3")
try! resraurant.getTheDish(withName: "Fried potatoes")
resraurant.wallet
resraurant.dishes

do {
    try resraurant.getTheDish(withName: "CocaCola")
} catch ResultErrors.notInMenu {
    print("This dish is not on the menu.")
} catch ResultErrors.notEnoughMoney {
    print("There's no money in your wallet.")
}
