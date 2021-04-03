import UIKit
import Foundation

/*
1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
2. Описать пару его наследников trukCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
5. Создать несколько объектов каждого класса. Применить к ним различные действия.
6. Вывести значения свойств экземпляров в консоль.
 */
    

class Car {
    enum BodyType {
        case estate, coupe
    }

    enum Transmission {
        case manual, auto
    }

    enum WindowState {
        case open, close
    }

    enum DoorState {
        case open, close
    }

    enum Trailer {
        case box(Double)
        case none
    }

    enum Action {
        case load(weight: Double)
        case switchWindows(WindowState)
        case switchDoors(DoorState)
        case attachTrailer(Trailer)
    }

    let bodyworkType: BodyType
    let color: UIColor
    let transmition: Transmission
    var windows: WindowState
    var door: DoorState
    var maxLoad: Double
    var currentLoad: Double
    var name: String
    var km: Double
    
    init?(bodyworkType: BodyType, color: UIColor, transmition: Transmission, windows: WindowState, door: DoorState, name: String, km: Double) {
        self.bodyworkType = bodyworkType
        self.color = color
        self.transmition  = transmition
        self.windows = windows
        self.door = door
        self.maxLoad = 0
        self.name = name
        self.km = km
        self.currentLoad = 0
    }

    func perform(action: Action){}
}

class TruckCar: Car {
    var trailer: Trailer
    
    init?(bodyworkType: Car.BodyType, color: UIColor, transmition: Car.Transmission, windows: Car.WindowState, door: Car.DoorState, name: String, km: Double, trailer: Trailer) {
        self.trailer = trailer
        
        super.init(bodyworkType: bodyworkType, color: color, transmition: transmition, windows: windows, door: door, name: name, km: km)
        
        switch trailer {
        case .box(let maxLoad):
            self.maxLoad = maxLoad
        default:
            self.maxLoad = 0
        }
    }
    
    override func perform(action: Car.Action) {
        switch action {
        case .load(let weight):
            guard case .box(_) = self.trailer else {
                return
            }
            let freeLoad = self.maxLoad - self.currentLoad
            if weight <= freeLoad {
                self.currentLoad += weight
            } else {
                self.currentLoad = self.maxLoad
            }
        case .switchWindows(let windowsState):
            self.windows = windowsState
        case .switchDoors(let doorState):
            self.door = doorState
        case .attachTrailer(let trailerState):
            self.trailer = trailerState
            self.currentLoad = 0
            
            switch trailerState {
            case .box(let maxLoad):
                self.maxLoad = maxLoad
            default:
                self.maxLoad = 0
            }
        default:
            print("Неопознанное действие")
        }
    }
}

class SportCar: Car {
    
}

