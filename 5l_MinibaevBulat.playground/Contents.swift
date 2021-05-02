import UIKit

enum EngineState: String {
    case start = "Двигатель заведен!\n"
    case stop = "Двигатель заглушен!\n"
}
enum WindowsState: String {
    case open = "Окна открыты!\n"
    case close = "Окна закрыты!\n"
}



protocol Car {
    var marka: String {get}
    var year: Int {get}
    var windowsState: WindowsState {get set}
    var engineState: EngineState {get set}
 
}

extension Car {
    mutating func startStopEngine() {
        switch engineState {
        case .start:
            engineState = .stop
            print(engineState.rawValue)
        case .stop:
            engineState = .start
            print(engineState.rawValue)
        }
    }
    
    mutating func openCloseWindows(state: WindowsState) {
        self.windowsState = state
        print(windowsState.rawValue)
    }
}



class SportCar: Car {
    var marka: String
    var year: Int
    var windowsState: WindowsState
    var engineState: EngineState
    
    let maxSpeed: Int
    
    init(marka: String, year: Int, windowsState: WindowsState, engineState: EngineState, maxSpeed: Int) {
        self.marka = marka
        self.year = year
        self.windowsState = windowsState
        self.engineState = engineState
        self.maxSpeed = maxSpeed
    }
}

// Description
extension SportCar: CustomStringConvertible {
    var description: String {
        "Спортивный автомобиль марки '\(marka)' \(year) года выпуска.\nМаксимальная скорость - \(maxSpeed). \(engineState.rawValue)"
    }
}




class TunkCar: Car {
    var marka: String
    var year: Int
    var windowsState: WindowsState
    var engineState: EngineState
    
    let tunkVolume: Int
    var volumeCargo: Int
    var freeTunkVolume: Int {
        tunkVolume - volumeCargo
    }
    
    init(marka: String, year: Int, windowsState: WindowsState, engineState: EngineState, tunkVolume: Int, volumeCargo: Int) {
        self.marka = marka
        self.year = year
        self.windowsState = windowsState
        self.engineState = engineState
        self.tunkVolume = tunkVolume
        self.volumeCargo = volumeCargo
    }
}

// Description
extension TunkCar: CustomStringConvertible {
    var description: String {
        "Цистерна марки '\(marka)' \(year) года выпуска. \nМаксимальный объем груза: \(tunkVolume). \nТекущий объем груза: \(volumeCargo).\nСвободное место: \(freeTunkVolume)\n"
    }
}

// функция загрузки/разгрузки цистерны
extension TunkCar {
    enum LoadingUnloadingCargo {
        case Load(volume: Int)
        case Unload(volume: Int)
    }
    
    func loadingUnloading(cargo: LoadingUnloadingCargo) {
        switch cargo {
        case let .Load(volume):
            guard volume <= freeTunkVolume else {return print("Нет места")}
            self.volumeCargo += volume
            print("Операция выпонена!\n-загружено \(volume).\n-всего объем цистерны: \(tunkVolume)\n-свободное место: \(freeTunkVolume)\n")
        case let .Unload(volume):
            guard volume <= volumeCargo else {return print("Нет столько груза")}
            self.volumeCargo -= volume
            print("Операция выпонена!\n-выгружено \(volume).\n-всего объем цистерны: \(tunkVolume)\n-свободное место: \(freeTunkVolume)\n")
        }
    }
}

print("--------------SportCar--------------\n")

var sportCar = SportCar(marka: "Ferrary", year: 2015, windowsState: .close, engineState: .stop, maxSpeed: 380)
print(sportCar)
sportCar.openCloseWindows(state: .open)
sportCar.startStopEngine()


print("\n---------------TunkCar--------------\n")

var tunkCar = TunkCar(marka: "Volvo", year: 2010, windowsState: .open, engineState: .start, tunkVolume: 5400, volumeCargo: 0)
print(tunkCar)

tunkCar.loadingUnloading(cargo: .Load(volume: 3000))
tunkCar.startStopEngine()
tunkCar.loadingUnloading(cargo: .Unload(volume: 200))
print(tunkCar)
