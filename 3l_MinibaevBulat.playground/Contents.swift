import UIKit

enum EngineState: String {
    case Start = "Двигатель заведен"
    case Stop = "Двигатель заглушен"
}

enum WindowsState: String {
    case Open = "Внимание! Окна открываются"
    case Close = "Внимание! Окна закрываются"
}


struct SportCar {
    let marka: String
    let year: Int
    let trunkVolume: Int
    let maxSpeed: Int
    private var engineState: EngineState {
        didSet {        // оповещаем после старта/остановки двигателя
            print(engineState.rawValue)
        }
    }
    private var windowsState: WindowsState {
        willSet {   // оповещаем перед открытием/закрытием окон
            print(newValue.rawValue)
        }
    }
    mutating func openCloseWindows(_ state: WindowsState) {
        windowsState = state   //
    }
    mutating func startStopEngine() {  // меняем состояние на противоположное
        switch engineState {
        case .Start:
            engineState = .Stop
        case .Stop:
            engineState = .Start
        }
    }
    func infoCar() {
        print("Спортивный автомобиль марки '\(marka)' \(year) года выпуска.\nМаксимальная скорость - \(maxSpeed). \(engineState.rawValue).\n")
    }
    init (marka: String, year: Int, trunkVolume: Int, maxSpeed: Int, engineState: EngineState, windowsState: WindowsState) {
        self.marka = marka
        self.year = year
        self.trunkVolume = trunkVolume
        self.maxSpeed = maxSpeed
        self.engineState = engineState
        self.windowsState = windowsState
    }
}


print("--------------SportCar--------------\n")
var sportCar1 = SportCar(marka: "Ferrary", year: 2020, trunkVolume: 200, maxSpeed: 350, engineState: .Stop, windowsState: .Close)
sportCar1.infoCar()
sportCar1.openCloseWindows(.Open)
sportCar1.startStopEngine()




struct TrunkCar {
    enum LoadingUnloadingCargo {
        case Load(volume: Int)
        case Unload(volume: Int)
    }
    let marka: String
    let year: Int
    let trunkVolume: Int
    var engineState: EngineState
    var windowsState: WindowsState
    var volumeCargo: Int {
        didSet {    // оповещаем информацию о грузовом отсеке после загрузки/выгрузке
            print("Информация после выполненой операции:\n-всего груза: \(volumeCargo)\n-осталось места: \(freeTrunkVolume)\n")
        }
    }
    var freeTrunkVolume: Int {
            trunkVolume - volumeCargo
    }
    func infoCar() {
        print("Грузовой автомобиль марки '\(marka)' \(year) года выпуска. \nГрузовой отсек с максимальной вместимостью \(trunkVolume):\n-загружено \(volumeCargo)\n-свободное место \(freeTrunkVolume)\n")
    }
    mutating func loadingUnloadingCargo(cargo: LoadingUnloadingCargo) {
        switch cargo {
        case let .Load(volume):
            guard volume <= freeTrunkVolume else { return print("Не хватает места! Операция не выполнена!\n")}
            print("Загружено: \(volume)!")
            volumeCargo += volume
        case let .Unload(volume):
            guard volume <= volumeCargo else { return print("Нет столько груза! Операция не выполнена!\n")}
            print("Выгружено: \(volume)!")
            volumeCargo -= volume
        }
    }
}


print("\n--------------TrunkCar--------------\n")
var trunkCar1 = TrunkCar(marka: "Volvo", year: 2019, trunkVolume: 5000, engineState: .Start, windowsState: .Open, volumeCargo: 0)
trunkCar1.infoCar()
trunkCar1.loadingUnloadingCargo(cargo: .Unload(volume: 100))
trunkCar1.loadingUnloadingCargo(cargo: .Load(volume: 2200))
trunkCar1.loadingUnloadingCargo(cargo: .Unload(volume: 300))
trunkCar1.infoCar()
