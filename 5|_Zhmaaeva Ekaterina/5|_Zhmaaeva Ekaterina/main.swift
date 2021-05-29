import Foundation


// MARK: - Урок 5. ООП: требование к классам, протоколы, расширения, полиморфизм, композиция

/*
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 */

// MARK: - Создаем перечесления

enum EngineState: String {
    case engineOn = "Запущен"
    case engineOff = "Заглушен"
}

enum DoorsState: String {
    case open = "Открыты"
    case closed = "Закрыты"
}

enum FastenBelt: String {                 // Ремень безопасности для спорткар
    case lock = "Пристегнут"
    case unlock = "Непристегнут"
}

enum Trailer: CustomStringConvertible {
    // Прицеп для грузовика: прицеплен/отцеплен
    case hitched(Double)
    case unhitched
    
    var description: String {
        get {
            switch self {
            case.unhitched:
                return "Отцеплен"
            case .hitched(let value):
                return "Объём прицепа \(value)"
            }
        }
    }
}


// MARK: - Создаем протокол Car

protocol CarProtocol: AnyObject {
    
    var brandCar: String { get }
    var productionCar: Int { get }
    var engineCar: EngineState { get set }
    var doorsStateCar: DoorsState { get set}
    var maxVolumeTrunkCar: Double { get set }
    var currentLoadTrunkCar: Double { get set }
    
    
    func actionAnEngine(to: EngineState)
    func actionAnDoors(to: DoorsState)
    func putInTrunk(cargoVolume: Double)
    func takeOutTrunk(cargoVolume: Double)
}

// MARK: - Создаем расширение для протоколов с реализацией методов

extension CarProtocol {
    
    func actionAnEngine(to: EngineState) {
        engineCar = to
    }
    
    func actionAnDoors(to: DoorsState) {
        doorsStateCar = to
    }
    
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
}


// MARK: - Спорткар

class SportCar: CarProtocol {
    
    var beltState: FastenBelt
    var brandCar: String
    var productionCar: Int
    var engineCar: EngineState
    var doorsStateCar: DoorsState
    var maxVolumeTrunkCar: Double
    var currentLoadTrunkCar: Double
    
    init(beltState: FastenBelt, brandCar: String, productionCar: Int, engineCar: EngineState, doorsStateCar: DoorsState, maxVolumeTrunkCar: Double, currentLoadTrunkCar: Double) {
        self.beltState = beltState
        self.brandCar = brandCar
        self.productionCar = productionCar
        self.engineCar = engineCar
        self.doorsStateCar = doorsStateCar
        self.maxVolumeTrunkCar = maxVolumeTrunkCar
        self.currentLoadTrunkCar = currentLoadTrunkCar
    }
    
    func checkBelt(to: FastenBelt) {
        beltState = to
    }
}


extension SportCar: CustomStringConvertible {
    var description: String {
        return """
       \nТекущие параметры нашей машины:
       Марка авто: \(self.brandCar)
       Год выпуска: \(self.productionCar)
       Максимальный объем багажника: \(String.init(format: "%0.2f", self.maxVolumeTrunkCar))л
       Загруженный объем багажа: \(String.init(format: "%0.2f", self.currentLoadTrunkCar))л
       Состояние двигателя: \(self.engineCar.rawValue)
       Состояние дверей: \(self.doorsStateCar.rawValue)
       Состояние ремня безопасности: \(self.beltState.rawValue)
       ============================================
       """
    }
}

// MARK: - Класс траккар

class TruckCar: CarProtocol {
    
    var trailer: Trailer;
    var brandCar: String
    var productionCar: Int
    var engineCar: EngineState
    var doorsStateCar: DoorsState
    var maxVolumeTrunkCar: Double
    var currentLoadTrunkCar: Double
    
    init(brand: String, production: Int, engine: EngineState, doors: DoorsState, maxVolumeTrunk: Double, currentLoad: Double, trailer: Trailer) {
        self.brandCar = brand
        self.productionCar = production
        self.engineCar = engine
        self.doorsStateCar = doors
        self.maxVolumeTrunkCar = maxVolumeTrunk
        self.currentLoadTrunkCar = currentLoad
        self.trailer = trailer
        
        self.hasTrailer(attach: trailer)
    }
    
    private func attachTrailer(maxLoadTrailer: Double) {
        switch self.trailer {
        case .unhitched:
            self.maxVolumeTrunkCar += maxLoadTrailer
        case .hitched(let currentTrailerLoad):
            self.currentLoadTrunkCar = 0
            self.maxVolumeTrunkCar = self.maxVolumeTrunkCar - currentTrailerLoad + currentTrailerLoad // убираем текущий прицеп и добавляем новый
        }
        
        self.trailer = .hitched(maxLoadTrailer)
    }
    
    private func deattachTrailer() {
        if case .hitched(let maxLoadTrailer) = self.trailer {
            self.maxVolumeTrunkCar -= maxLoadTrailer;
            self.trailer = .unhitched
        }
    }
    
    func hasTrailer(attach: Trailer) {
        switch attach {
        case .unhitched:
            self.deattachTrailer()
            print("Прицеп не найден")
        case .hitched(let maxLoadTrailer):
            self.attachTrailer(maxLoadTrailer: maxLoadTrailer)
            print("Обнаружен прицеп.\n" +
                    "Теперь максимальный объем багажника составляет \(maxVolumeTrunkCar)л")
        }
    }
}

extension TruckCar: CustomStringConvertible {
    var description: String {
        get {
            return """
       \nТекущие параметры нашей машины:
       Марка авто: \(self.brandCar)
       Год выпуска: \(self.productionCar)
       Максимальный объем багажника: \(String.init(format: "%0.2f", self.maxVolumeTrunkCar))л
       Загруженный объем багажа: \(String.init(format: "%0.2f", self.currentLoadTrunkCar))л
       Состояние двигателя: \(self.engineCar.rawValue)
       Состояние дверей: \(self.doorsStateCar.rawValue)
       Прицеп: \(self.trailer)
       ============================================
       """
        }
    }
}

let someSportCar = SportCar(beltState: .unlock,
                            brandCar: "Спортивный автомобиль",
                            productionCar: 2020,
                            engineCar: .engineOff,
                            doorsStateCar: .closed,
                            maxVolumeTrunkCar: 220,
                            currentLoadTrunkCar: 0)
someSportCar.actionAnDoors(to: .open)
someSportCar.actionAnEngine(to: .engineOff)
someSportCar.checkBelt(to: .lock)
someSportCar.putInTrunk(cargoVolume: 139.90)
someSportCar.takeOutTrunk(cargoVolume: 98)

print(someSportCar)


let someTruckCar = TruckCar(brand: "Грузовой автомобиль",
                            production: 2021,
                            engine: .engineOn,
                            doors: .open,
                            maxVolumeTrunk: 500,
                            currentLoad: 0,
                            trailer: .unhitched)
someTruckCar.actionAnDoors(to: .closed)
someTruckCar.putInTrunk(cargoVolume: 600)
someTruckCar.hasTrailer(attach: .hitched(177))
someTruckCar.putInTrunk(cargoVolume: 600)
someTruckCar.takeOutTrunk(cargoVolume: 454)

print(someTruckCar)
