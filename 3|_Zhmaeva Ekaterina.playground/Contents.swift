import Cocoa


//1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
//2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
//3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

enum EngineState {
    case started
    case stopped
}

enum WindowsState {
    case open
    case closed
}

enum Capacity {
    case put(Double)
    case get(Double)
}

struct SportCar {
    let mark: String
    let issueYear: Int
    let bodyCapacity: Double
    private var engineState: EngineState
    private var windowsState: WindowsState
    private var filledBodyCapacity: Double
    
    init(mark: String, issueYear: Int, bodyCapacity: Double) {
        self.mark = mark
        self.issueYear = issueYear
        self.bodyCapacity = bodyCapacity
        
        self.engineState = .stopped
        self.windowsState = .closed
        self.filledBodyCapacity = 0
    }
    mutating func setWindowsState(state: WindowsState) {
        self.windowsState = state
    }
    
    mutating func setEngineState(state: EngineState) {
        self.engineState = state
    }
    
    mutating func interactWithCarBody(operation: Capacity) {
        switch operation {
        case .get(let capacity):
            if capacity >= self.filledBodyCapacity {
                self.filledBodyCapacity = 0
            } else {
                self.filledBodyCapacity -= capacity
            }
        case .put(let capacity):
            let emptyCapacity = self.bodyCapacity - self.filledBodyCapacity
            
            if capacity >= emptyCapacity {
                self.filledBodyCapacity = self.bodyCapacity
            } else {
                self.filledBodyCapacity += capacity
            }
        }
    }
}


struct TrunkCar {
    let mark: String
    let issueYear: Int
    let trunkCapacity: Double
    private var engineState: EngineState
    private var windowsState: WindowsState
    private var filledTrunkCapacity: Double
    
    init(mark: String, issueYear: Int, trunkCapacity: Double) {
        self.mark = mark
        self.issueYear = issueYear
        self.trunkCapacity = trunkCapacity
        
        self.engineState = .stopped
        self.windowsState = .closed
        self.filledTrunkCapacity = 0
    }
    mutating func setWindowsState(state: WindowsState) {
        self.windowsState = state
    }
    
    mutating func setEngineState(state: EngineState) {
        self.engineState = state
    }
    
    mutating func interactWithTrunk(operation: Capacity) {
        switch operation {
        case .get(let capacity):
            if capacity >= self.filledTrunkCapacity {
                self.filledTrunkCapacity = 0
            } else {
                self.filledTrunkCapacity -= capacity
            }
        case .put(let capacity):
            let emptyCapacity = self.trunkCapacity - self.filledTrunkCapacity
            
            if capacity >= emptyCapacity {
                self.filledTrunkCapacity = self.trunkCapacity
            } else {
                self.filledTrunkCapacity += capacity
            }
        }
    }
}


var mySportCar = SportCar(mark: "Ferrari", issueYear: 2021, bodyCapacity: 100)

mySportCar.setEngineState(state: .started)
mySportCar.setWindowsState(state: .open)
mySportCar.interactWithCarBody(operation: .put(90))
mySportCar.interactWithCarBody(operation: .put(50))

print(mySportCar)

mySportCar.interactWithCarBody(operation: .get(70))
print(mySportCar)


var myTrunkCar = TrunkCar(mark: "Kamaz", issueYear: 2020, trunkCapacity: 10000)

myTrunkCar.setEngineState(state: .started)
myTrunkCar.setWindowsState(state: .open)
myTrunkCar.interactWithTrunk(operation: .put(4500))
myTrunkCar.interactWithTrunk(operation: .put(5000))

print(myTrunkCar)

myTrunkCar.interactWithTrunk(operation: .get(1170))
print(myTrunkCar)
