//
//  main.swift
//  4.4|_Zhmaeva Ekaterina
//
//  Created by Catherine on 21.05.2021.
//

import Foundation

// MARK: Урок 4. Введение в ООП — объектно-ориентированное программирование

/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */

class Car {
    enum engineState {
        case engineOn, engineOff
    }
    
    enum doorsState {
        case open, closed
    }
    
    let makeCar: String
    let productionCar: Int
    let maxVolumeTrunkCar: Double
    var currentLoadTrunkCar: Double
    let engineCar: engineState
    let doorsStateCar: doorsState
    
    init(make: String,
         production: Int,
         maxVolumeTrunk: Double,
         currentLoad: Double,
         engine: engineState,
         doors: doorsState) {
        self.makeCar = make
        self.productionCar = production
        self.maxVolumeTrunkCar = maxVolumeTrunk
        self.currentLoadTrunkCar = 0
        self.engineCar = .engineOff
        self.doorsStateCar = .closed
    }
    
    func perform() -> () {
        
    }
}

class SportCar: Car {
    enum FastenBelt: String {
        case lock = "Ремень пристегнут."
        case unlock = "Ремень непристегнут."
    }
    
    
}

class TruckCar: Car {
    enum trailer {
        case hitched
        case unhitched
    }
    
    
}
