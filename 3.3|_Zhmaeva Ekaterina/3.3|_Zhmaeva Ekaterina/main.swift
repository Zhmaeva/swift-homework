//
//  main.swift
//  3.3|_Zhmaeva Ekaterina
//
//  Created by Catherine on 15.05.2021.
//

import Foundation

// MARK: Урок 3. Комплексные типы данных

/*
 1. Описать несколько структур:
 любой легковой автомобиль SportCar
 и
 любой грузовик TrunkCar.
 2. Структуры должны содержать:
 марку авто
 год выпуска
 запущен ли двигатель
 открыты ли окна
 объем багажника/кузова
 заполненный объем багажника.
 3. Описать перечисление с возможными действиями с автомобилем:
 запустить/заглушить двигатель
 открыть/закрыть окна
 погрузить/выгрузить из кузова/багажника груз определенного объема.
 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
 5. Инициализировать несколько экземпляров структур.
 Применить к ним различные действия
 6. Вывести значения свойств экземпляров в консоль.
 */

// MARK: Sport Car

enum Action {
    enum WindowsMode: String {
        case open = "На данный момент окна открыты."
        case closed = "На данный момент окна закрыты."
    }
    
    enum EngineMode: String {
        case on = "Двигатель запущен."
        case off = "Двигатель заглушен."
    }
    
    case windows(Action.WindowsMode)
    case engine(Action.EngineMode)
    case put(putInTrunk: Double)
    case take(takeOutTrunk: Double)
}

enum FastenBelt: String {
    case lock = "Ремень пристегнут."
    case unlock = "Ремень непристегнут."
}


struct SportCar {
    private let _brand : String
    var brand: String {
        get { return self._brand }
    }
    
    private let _year: Int
    var year: Int {
        get { return self._year }
    }
    
    private var _color: String
    var colour: String {
        get { return self._color }
        set { self._color = newValue}
    }
    
    private var _engine: Action.EngineMode
    var engine: Action.EngineMode {
        get { self._engine }
    }
    
    private var _windowsState: Action.WindowsMode
    var windowsState: Action.WindowsMode {
        get { self._windowsState }
    }
    
    private let _trunkMaxVolume: Double
    var trunkMaxVolume: Double {
        get { self._trunkMaxVolume }
    }
    
    private var _currentTrunkLoad: Double
    var currentTrunkLoad: Double {
        get { self._currentTrunkLoad }
    }
    
    init(engine: Action.EngineMode,
         windowsState: Action.WindowsMode,
         trunkMaxVolume: Double) {
        self._brand = "Sport Car"
        self._year = 2021
        self._color = ""
        self._engine = engine
        self._windowsState = windowsState
        self._trunkMaxVolume = trunkMaxVolume
        self._currentTrunkLoad = 0
    }
    
    private mutating func putInTrunk(cargoVolume: Double) {
        let freeSpace = self._trunkMaxVolume - self._currentTrunkLoad
        if cargoVolume <= freeSpace {
            self._currentTrunkLoad += cargoVolume
            print("Багажник загружен на: \(String.init(format: "%0.2f", _currentTrunkLoad))л")
        } else {
            print("Ваш груз не помещается!\n" +
                    "Вы можете поместить только " +
                    "\(String.init(format: "%0.2f", freeSpace))л")
        }
    }
    
    private mutating func takeOutTrunk(cargoVolume: Double) {
        if cargoVolume > self._currentTrunkLoad {
            print("В багажнике нет нужного колличества груза\n" +
                    "В багажнике груза на \(String.init(format: "%0.2f", self._currentTrunkLoad))л")
        } else {
            self._currentTrunkLoad -= cargoVolume
            print("Багажник разгружен на \(String.init(format: "%0.2f", cargoVolume))л\n" +
                    "Текущий объём груза в багажнике \(String.init(format: "%0.2f", self._currentTrunkLoad))л")
        }
    }
    
    
    mutating func performAn(action: Action) {
        switch action {
        case.windows(let windowsMode):
            self._windowsState = windowsMode
            print(windowsMode.rawValue)
        case .engine(let engineMode):
            self._engine = engineMode
            print(engineMode.rawValue)
        case .put(let load):
            self.putInTrunk(cargoVolume: load)
        case .take(let load):
            self.takeOutTrunk(cargoVolume: load)
        }
    }
    
    func printInformation() {
        print("""
---------------------------------------
Текущие параметры нашей машины:
Марка авто: \(self._brand)
Год выпуска: \(self._year)
Цвет авто: \(self._color)
Состояние двигателя: \(self._engine)
Максимальный объем багажника: \(String.init(format: "%0.2f", self._trunkMaxVolume))л
Положение окон: \(self._windowsState)
Загруженный объем багажа: \(String.init(format: "%0.2f", self._currentTrunkLoad))л
============================================
""")
    }
}


// MARK: Truck Car

struct TruckCar {
    private var _brand : String
    private var _year: Int
    private var _color: String
    private var _trunkMaxVolume: Double
    private var _currentTrunkLoad: Double
    private var _engine: Action.EngineMode
    private var _windowsState: Action.WindowsMode
    private var _beltState: FastenBelt /* Не поняла использование наблюдателя {
        willSet {
            newValue == .unlock ? print("Для начала движения, пожалуйста пристегните ремень безопасности.") : print("Вы пристегнуты, можете начинать движение.") */

    init(engine: Action.EngineMode,
         windowsState: Action.WindowsMode,
         trunkMaxVolume: Double,
         currentTrunkLoad: Double) {
        self._brand = "Truck Car"
        self._year = 2021
        self._color = "Any"
        self._engine = engine
        self._windowsState = windowsState
        self._beltState = .unlock
        self._trunkMaxVolume = trunkMaxVolume
        self._currentTrunkLoad = currentTrunkLoad
    }

    private mutating func putInTrunk(cargoVolume: Double) {
        let freeSpace = self._trunkMaxVolume - self._currentTrunkLoad
        if cargoVolume <= freeSpace {
            self._currentTrunkLoad += cargoVolume
            print("Багажник загружен на: \(String.init(format: "%0.2f", _currentTrunkLoad))л")
        } else {
            print("Ваш груз не помещается!\n" +
                  "Вы можете поместить только " +
                  "\(String.init(format: "%0.2f", freeSpace))л")
        }
    }

    private mutating func takeOutTrunk(cargoVolume: Double) {
        if cargoVolume > self._currentTrunkLoad {
            print("В багажнике нет нужного колличества груза\n" +
                  "В багажнике груза на \(String.init(format: "%0.2f", self._currentTrunkLoad))л")
        } else {
            self._currentTrunkLoad -= cargoVolume
            print("Багажник разгружен на \(String.init(format: "%0.2f", cargoVolume))л\n" +
                  "Текущий объём груза в багажнике \(String.init(format: "%0.2f", self._currentTrunkLoad))л")
        }
    }

    mutating func performAn(action: Action) {
        switch action {
        case.windows(let windowsMode):
            self._windowsState = windowsMode
            print(windowsMode.rawValue)
        case .engine(let engineMode):
            self._engine = engineMode
            print(engineMode.rawValue)
        case .put(let load):
            self.putInTrunk(cargoVolume: load)
        case .take(let load):
            self.takeOutTrunk(cargoVolume: load)
        }
    }

    mutating func checkBelt(stateBelt: FastenBelt) {
        switch stateBelt {
        case .lock:
            self._beltState = .lock
            print(stateBelt.rawValue)
        case .unlock:
            self._beltState = .unlock
            print(stateBelt.rawValue)
        }
    }

    func printInformation() {
        print("""
    ---------------------------------------
    Текущие параметры нашей машины:
    Марка авто: \(self._brand)
    Год выпуска: \(self._year)
    Цвет авто: \(self._color)
    Состояние двигателя: \(self._engine)
    Ремень безопасности: \(self._beltState)
    Максимальный объем багажника: \(String.init(format: "%0.2f", self._trunkMaxVolume))л
    Положение окон: \(self._windowsState)
    Загруженный объем багажа: \(String.init(format: "%0.2f", self._currentTrunkLoad))л
    ============================================
""")
    }
}

// Инициализирую экземпляры структур:

var someSport1 = SportCar(engine: .on,
                          windowsState: .open,
                          trunkMaxVolume: 300)
someSport1.colour = "White"
someSport1.performAn(action: .engine(.off))
someSport1.performAn(action: .windows(.closed))
someSport1.performAn(action: .put(putInTrunk: 265.5))
someSport1.performAn(action: .take(takeOutTrunk: 280))
someSport1.performAn(action: .take(takeOutTrunk: 236))
someSport1.printInformation()

var someSport2 = SportCar(engine: .off,
                          windowsState: .closed,
                          trunkMaxVolume: 149.8)
someSport2.colour = "Pink"
someSport2.performAn(action: .put(putInTrunk: 100))
someSport2.performAn(action: .take(takeOutTrunk: 78.9))
someSport2.printInformation()

var someTruck1 = TruckCar(engine: .off,
                          windowsState: .closed,
                          trunkMaxVolume: 500,
                          currentTrunkLoad: 10)
someTruck1.performAn(action: .engine(.off))
someTruck1.performAn(action: .take(takeOutTrunk: 69))
someTruck1.performAn(action: .put(putInTrunk: 650))
someTruck1.performAn(action: .put(putInTrunk: 458.89))
someTruck1.checkBelt(stateBelt: .lock)
someTruck1.printInformation()
