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
    enum BodyType: CustomStringConvertible {
        case estate, coupe
        
        var description: String {
            get {
                switch self {
                case .coupe:
                    return "Купе"
                case .estate:
                    return "Универсал"
                }
            }
        }
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
    
    enum FoldingRoof {
        case open, close
    }

    enum Action {
        case load(weight: Double)
        case switchWindows(WindowState)
        case switchDoors(DoorState)
        case attachTrailer(Trailer)
        case switchRoof(FoldingRoof)
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
    
    init(bodyworkType: BodyType, color: UIColor, transmition: Transmission, windows: WindowState, door: DoorState, name: String, km: Double) {
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

class TruckCar: Car, CustomStringConvertible {
    var description: String {
        get {
            return "Название: \(self.name); \nЦвет:  \(self.color); \nТрансмиссия:  \(self.transmition); \nТип кузова: \(self.bodyworkType); \nСтатус окон: \(self.windows); \nСтатус дверей: \(self.door); \nМаксимальная загрузка: \(self.maxLoad); \nТекущая загрузка: \(self.currentLoad) "
        }
    }
    private var _trailer: Trailer = .none
    var trailer: Trailer {
        get {
            return self._trailer
        }
        set {
            switch newValue {
            case .box(let maxLoad):
                self.maxLoad = maxLoad
            default:
                self.maxLoad = 0
            }
            
            self.currentLoad = 0;
            self._trailer = newValue
        }
    }
    
    init(bodyworkType: Car.BodyType, color: UIColor, transmition: Car.Transmission, windows: Car.WindowState, door: Car.DoorState, name: String, km: Double, trailer: Trailer) {
        
        super.init(bodyworkType: bodyworkType, color: color, transmition: transmition, windows: windows, door: door, name: name, km: km)
        self.trailer = trailer
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
        default:
            print("Неопознанное действие")
        }
    }
}

class SportCar: Car, CustomStringConvertible {
    var description: String {
        get {
            return "Название: \(self.name); \nЦвет:  \(self.color); \nТрансмиссия:  \(self.transmition); \nТип кузова: \(self.bodyworkType); \nСтатус окон: \(self.windows); \nСтатус дверей: \(self.door); \nСтатус крыши: \(self.roof); \nМаксимальная загрузка: \(self.maxLoad); \nТекущая загрузка: \(self.currentLoad)"
        }
    }
    
    var roof: FoldingRoof
   
    init(bodyworkType: Car.BodyType, color: UIColor, transmition: Car.Transmission, windows: Car.WindowState, door: Car.DoorState, name: String, km: Double, roof: FoldingRoof, maxLoad: Double) {
        self.roof = roof
        
        super.init(bodyworkType: bodyworkType, color: color, transmition: transmition, windows: windows, door: door, name: name, km: km)
        self.maxLoad = maxLoad
    }
    override func perform(action: Car.Action) {
        switch action {
        case .switchRoof(let roofState):
            self.roof = roofState
        case .switchWindows(let windowsState):
            self.windows = windowsState
        case .switchDoors(let doorState):
            self.door = doorState
        case.load(let weight):
            let freeLoad = self.maxLoad - self.currentLoad
            if weight <= freeLoad {
                self.currentLoad += weight
            } else {
                self.currentLoad = self.maxLoad
            }
        default:
            print("Неопознанное действие")
        }
    }
}

var truckCar1 = TruckCar(bodyworkType: .estate, color: .darkGray, transmition: .manual, windows: .close, door: .close, name: "Грузовик", km: 500, trailer: .box(100))

print(truckCar1)
print("\n \n---------------------------------")

truckCar1.perform(action: .load(weight: 50))
truckCar1.perform(action: .switchWindows(.open))
truckCar1.perform(action: .switchDoors(.open))
truckCar1.perform(action: .switchRoof(.open))

print(truckCar1)
print("\n \n---------------------------------")

truckCar1.perform(action: .attachTrailer(.none))
print(truckCar1)
print("\n \n---------------------------------")

var sportCar1 = SportCar(bodyworkType: .coupe, color: .red, transmition: .auto, windows: .open, door: .open, name: "Спортивная машина", km: 800, roof: .open, maxLoad: 30)

print(sportCar1)
print("\n \n---------------------------------")

sportCar1.perform(action: .attachTrailer(.box(57)))
sportCar1.perform(action: .load(weight: 50))
sportCar1.perform(action: .switchDoors(.close))
sportCar1.perform(action: .switchRoof(.close))
sportCar1.perform(action: .switchWindows(.close))

print(sportCar1)
print("\n \n---------------------------------")
