//
//  main.swift
//  6|_Zhmaeva Ekaterina
//
//  Created by Catherine on 29.05.2021.
//

import Foundation

//MARK: - Урок 6. Продвинутое ООП

/*
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 */

//MARK: - Создаю несколько классов


class Menu {
    
    enum CategoryOfMenu: String {
        case mainСourse = "Основное блюдо"
        case drinks = "Напитки"
    }
    
    let name: String
    var price: Double
    let category: CategoryOfMenu
    
    init(category: CategoryOfMenu, name: String, price: Double) {
        self.category = category
        self.name = name
        self.price = price
    }
}

extension Menu: CustomStringConvertible {
    var description: String {
        return(
"""
Раздел меню: \(category.rawValue), название: \(name), цена: \(price)
----------------------------------------------------------\n
"""
        )
    }
}


class Peoples {
    
    enum Gender: String {
        case woman = "Женщина"
        case man = "Мужчина"
    }
    
    let name: String
    let age: Int
    var gender: Gender
    
    init(gender: Gender, name: String, age: Int) {
        self.gender = gender
        self.name = name
        self.age = age
    }
}

extension Peoples: CustomStringConvertible {
    var description: String {
        return(
"""
Пол: \(gender.rawValue), имя: \(name), возраст: \(age)
----------------------------------------------------------\n
"""
        )
    }
}

//MARK: - Создаю тип коллекции «очередь» (queue) c использованием дженерика

struct Queue<SomeType> {
    
    private var elements: [SomeType] = []
    
    mutating func push(_ element: SomeType) {      // добавляем элемент в очередь
        elements.append(element)
    }
    
    mutating func pop() -> SomeType? {             // извлекаем элемент из очереди
        guard elements.count > 0 else { return nil }

        return elements.removeFirst()
    }

    
    func contains(_ predicate: (SomeType) -> Bool) -> Bool {
        return self.elements.contains(where: predicate)
    }

    
    func getAll() -> [SomeType] {
        return self.elements
    }

    
    subscript(index: Int) -> SomeType? {
        get {
            guard index >= 0 && index < self.elements.count else {
                return nil
            }

            return self.elements[index]
        }
    }
}

var orderQueue = Queue<Menu>()
orderQueue.push(Menu(category: .mainСourse, name: "Fish&Chips", price: 350))
orderQueue.push(Menu(category: .mainСourse, name: "Pizza", price: 550))
orderQueue.push(Menu(category: .drinks, name: "Beer", price: 400))
orderQueue.push(Menu(category: .drinks, name: "Coca Cola", price: 500))

orderQueue[3]?.price = 150    //если есть price по этому индексу меняем на 150

let hasBeer = orderQueue.contains() { $0.price == 400 }     //есть ли пиво?

var sum = 0.0                       //считаем сумму заказа
for item in orderQueue.getAll() {
    sum += item.price
}

print("Общая сумма заказа \(sum) рублей")
print(hasBeer)
print(orderQueue)


var peoplesQueue = Queue<Peoples>()
peoplesQueue.push(Peoples(gender: .man, name: "Дмитрий", age: 27))
peoplesQueue.push(Peoples(gender: .man, name: "Роман", age: 26))
peoplesQueue.push(Peoples(gender: .woman, name: "Анна", age: 30))
peoplesQueue.push(Peoples(gender: .man, name: "Станислав", age: 35))

let hasAge = peoplesQueue.contains() { $0.age == 50 }

print(hasAge)
print(peoplesQueue)
