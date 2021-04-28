import UIKit

class Car {
    enum EngineState: String {
        case Start = "Двигатель заведен!\n"
        case Stop = "Двигатель заглушен!\n"
    }
    enum WindowsState: String {
        case Open = "Внимание! Окна открываются!\n"
        case Close = "Внимание! Окна закрываются!\n"
    }
    
    let marka: String
    let year: Int
    let trunkVolume: Int
    var engineState: EngineState {
        didSet {        // оповещаем после старта/остановки двигателя
            print(engineState.rawValue)
        }
    }
    var windowsState: WindowsState {
        willSet {   // оповещаем перед открытием/закрытием окон
            print(newValue.rawValue)
        }
    }
    
    init(marka: String, year: Int, trunkVolume: Int, engineState: EngineState, windowsState: WindowsState) {
        self.marka = marka
        self.year = year
        self.trunkVolume = trunkVolume
        self.engineState = engineState
        self.windowsState = windowsState
    }
    
    func infoCar() {}
}



class SportCar: Car {
    let maxSpeed: Int
    var km = 0 {
        didSet {
            print("Поездка завершена, пройден путь: \(km - oldValue) км")
        }
    }
    
    init(marka: String, year: Int, trunkVolume: Int, engineState: Car.EngineState, windowsState: Car.WindowsState, maxSpeed: Int) {
        self.maxSpeed = maxSpeed
        super.init(marka: marka, year: year, trunkVolume: trunkVolume, engineState: engineState, windowsState: windowsState)
    }
    
    override func infoCar() {
        print("Спортивный автомобиль марки '\(marka)' \(year) года выпуска.\nМаксимальная скорость - \(maxSpeed). \(engineState.rawValue)\n")
    }
    func odometer(add km: Int) {
        self.km += km
    }
    func openCloseWindows(state: WindowsState) {
        self.windowsState = state
    }
    func startStopEngine() {
        switch engineState {
        case .Start:
            engineState = .Stop
        case .Stop:
            engineState = .Start
        }
    }
}


class TrunkCar: Car {
    enum LoadingUnloadingCargo {
        case Load(volume: Int)
        case Unload(volume: Int)
    }
    
    var volumeCargo = 0 {
        didSet {    // оповещаем информацию о грузовом отсеке после загрузки/выгрузке
            print("Информация после выполненой операции:\n-всего груза: \(volumeCargo)\n-осталось места: \(freeTrunkVolume)\n")
        }
    }
    var freeTrunkVolume: Int {
        trunkVolume - volumeCargo
    }
    
    override func infoCar() {
        print("Грузовой автомобиль марки '\(marka)' \(year) года выпуска. \nГрузовой отсек с максимальной вместимостью \(trunkVolume):\n-загружено \(volumeCargo)\n-свободное место \(freeTrunkVolume)\n")
    }
    func loadingUnloading(cargo: LoadingUnloadingCargo) {
        switch cargo {
        case let .Load(volume):
            guard freeTrunkVolume >= volume else { return print("Не хватает места! Операция не выполнена!\n") }
            print("Загружено: \(volume)!")
            volumeCargo += volume
        case let .Unload(volume):
            guard volumeCargo >= volume else { return print("Нет столько груза! Операция не выполнена!\n") }
            print("Выгружено: \(volume)!")
            volumeCargo -= volume
        }
    }
}



print("--------------SportCar--------------\n")
var sportCar1 = SportCar(marka: "Ferrary", year: 2020, trunkVolume: 200, engineState: .Stop, windowsState: .Close, maxSpeed: 350)
sportCar1.infoCar()
sportCar1.openCloseWindows(state: .Open)
sportCar1.startStopEngine()
sportCar1.odometer(add: 320)


print("\n--------------TrunkCar--------------\n")
var trunkCar1 = TrunkCar(marka: "Volvo", year: 2015, trunkVolume: 6000, engineState: .Start, windowsState: .Open)
trunkCar1.infoCar()
trunkCar1.loadingUnloading(cargo: .Unload(volume: 1000))
trunkCar1.loadingUnloading(cargo: .Load(volume: 1300))
trunkCar1.loadingUnloading(cargo: .Load(volume: 5000))
trunkCar1.loadingUnloading(cargo: .Load(volume: 4000))
trunkCar1.loadingUnloading(cargo: .Unload(volume: 5300))
