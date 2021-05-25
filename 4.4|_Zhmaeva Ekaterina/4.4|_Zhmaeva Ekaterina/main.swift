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

enum EngineState {
    case engineOn
    case engineOff
}

enum DoorsState {
    case open
    case closed
}

enum FastenBelt: String {                 // Ремень безопасности для спорткар
    case lock = "Ремень пристегнут."
    case unlock = "Ремень непристегнут."
}

enum Trailer {                        // Прицеп для грузовика: прицеплен/отцеплен
    case hitched(Double)
    case unhitched
}

// MARK: Супер класс

class Car {
    
    let brandCar: String
    let productionCar: Int
    var maxVolumeTrunkCar: Double
    var currentLoadTrunkCar: Double
    var engineCar: EngineState
    var doorsStateCar: DoorsState
    
    init(brand: String,
         production: Int,
         maxVolumeTrunk: Double,
         currentLoad: Double,
         engine: EngineState,
         doors: DoorsState) {
        self.brandCar = brand
        self.productionCar = production
        self.maxVolumeTrunkCar = maxVolumeTrunk
        self.currentLoadTrunkCar = currentLoad
        self.engineCar = engine
        self.doorsStateCar = doors
    }
    
    // Общие пустые методы для переопределения
    
    func actionAnEngine(to: EngineState) {}
    func actionAnDoors(to: DoorsState) {}
    
    func putInTrunk(cargoVolume: Double) {
        let freeSpace = self.maxVolumeTrunkCar - self.currentLoadTrunkCar
        if cargoVolume <= freeSpace {
            self.currentLoadTrunkCar += cargoVolume
            print("Багажник загружен на: \(String.init(format: "%0.2f", currentLoadTrunkCar))л")
        } else {
            print("Ваш груз не помещается!\n" +
                    "Вы можете поместить только " +
                    "\(String.init(format: "%0.2f", freeSpace))л")
        }
    }
    
    func takeOutTrunk(cargoVolume: Double) {
        if cargoVolume > self.currentLoadTrunkCar {
            print("В багажнике нет нужного колличества груза\n" +
                    "В багажнике груза на \(String.init(format: "%0.2f", self.currentLoadTrunkCar))л")
        } else {
            self.currentLoadTrunkCar -= cargoVolume
            print("Багажник разгружен на \(String.init(format: "%0.2f", cargoVolume))л\n" +
                    "Текущий объём груза в багажнике \(String.init(format: "%0.2f", self.currentLoadTrunkCar))л")
        }
    }
    
    func printInformation() {
        print("""
       Текущие параметры нашей машины:
       Марка авто: \(self.brandCar)
       Год выпуска: \(self.productionCar)
       Максимальный объем багажника: \(String.init(format: "%0.2f", self.maxVolumeTrunkCar))л
       Загруженный объем багажа: \(String.init(format: "%0.2f", self.currentLoadTrunkCar))л
       Состояние двигателя: \(self.engineCar)
       Состояние дверей: \(self.doorsStateCar)
       ============================================
       """)
    }
}

// MARK: Наследник спорткар

class SportCar: Car {
    
    var beltState: FastenBelt
    
    init(brand: String,
         production: Int,
         maxVolumeTrunk: Double,
         currentLoad: Double,
         engine: EngineState,
         doors: DoorsState,
         belt: FastenBelt) {
        self.beltState = belt
        
        super.init(brand: brand,
                   production: production,
                   maxVolumeTrunk: maxVolumeTrunk,
                   currentLoad: currentLoad,
                   engine: engine,
                   doors: doors)
    }
    
    func checkBelt(stateBelt: FastenBelt) {
        switch stateBelt {
        case .lock:
            self.beltState = .lock
            print(stateBelt.rawValue)
        case .unlock:
            self.beltState = .unlock
            print(stateBelt.rawValue)
        }
    }
    
    override func actionAnDoors(to: DoorsState) {
        doorsStateCar = to
    }
    
    override func actionAnEngine(to: EngineState) {
        engineCar = to
    }
}

// MARK: Наследник траккар

class TruckCar: Car {
    
    var trailer: Trailer
    
    init(brand: String,
         production: Int,
         maxVolumeTrunk: Double,
         currentLoad: Double,
         engine: EngineState,
         doors: DoorsState,
         trailer: Trailer) {
        self.trailer = trailer
        
        super.init(brand: brand,
                   production: production,
                   maxVolumeTrunk: maxVolumeTrunk,
                   currentLoad: currentLoad,
                   engine: engine,
                   doors: doors)
    }
    
    func isTrailer(attach: Trailer) {
        switch attach {
        case .unhitched:
            print("Прицеп не найден")
        case .hitched(let maxLoadTrailer):
            self.maxVolumeTrunkCar += maxLoadTrailer
            print("Обнаружен прицеп.\n" +
                    "Теперь максимальный объем багажника составляет \(maxVolumeTrunkCar)л")
        }
    }
    
    override func actionAnDoors(to: DoorsState) {
        doorsStateCar = to
    }
    
    override func actionAnEngine(to: EngineState) {
        engineCar = to
    }
}

var sport1 = SportCar(brand: "SPORT CAR",
                      production: 2021,
                      maxVolumeTrunk: 170,
                      currentLoad: 0,
                      engine: .engineOff,
                      doors: .closed,
                      belt: .unlock)
sport1.actionAnDoors(to: .open)
sport1.actionAnEngine(to: .engineOn)
sport1.checkBelt(stateBelt: .lock)
sport1.putInTrunk(cargoVolume: 165)
sport1.printInformation()

var truck1 = TruckCar(brand: "TRUCK CAR",
                      production: 2020,
                      maxVolumeTrunk: 400,
                      currentLoad: 0,
                      engine: .engineOff,
                      doors: .closed,
                      trailer: .unhitched)
truck1.actionAnDoors(to: .open)
truck1.actionAnEngine(to: .engineOn)
truck1.putInTrunk(cargoVolume: 350)
truck1.isTrailer(attach: .hitched(200))
truck1.printInformation()
