import UIKit

// 1 задание

// позиция на складе
struct Item {
    var name: String
    var weight: Double
    var quantity: Int
}

// перечисление позиций на складе
enum Names {
    case Router, CabelRG6, CabelUTP, Console, FConnector
}

// перечисление ошибок
enum WarehouseError: Error {
    case outOfStock, invalidSelection, emptyBase
}

// склад
class Warehouse {
    var storage = [
        Names.Router: Item(name: "Router", weight: 0.4, quantity: 0),
        Names.CabelRG6: Item(name: "Cabel RG-6", weight: 1, quantity: 0),
        Names.CabelUTP: Item(name: "Cabel UTP", weight: 3, quantity: 0),
        Names.Console: Item(name: "Console", weight: 0.3, quantity: 0)
    ]
    
    // общий вес всех позиций на складе
    var totalWeight: Double {
        var weight: Double = 0
        for element in storage {
            weight += element.value.weight
        }
        return weight
    }
    
    // показать остаток
    func remainingStock(_ name: Names) -> (Any?, WarehouseError?){
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { return (nil, .invalidSelection) }
        return (print("Позиция '\(name)': осталось \(item.quantity) штук"), nil)
    }
    
    // показать остатки по всем позициям
    func allRemainingStock() -> (Any?, WarehouseError?){
        guard storage.count > 0 else { return (nil, .emptyBase)}
        for item in storage {
            print("Позиция '\(item.value.name)': осталось \(item.value.quantity) штук")
        }
        return (print("Операция завершена"), nil)
    }
    
    // поступление товара на склад
    func addElement(_ name: Names, _ quantity: Int) -> (Item?, WarehouseError?) {
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { return (nil, .invalidSelection) }
        // добавляем на склад
        var newItem = item
        newItem.quantity += quantity
        storage[name] = newItem
        print("Операция поступления выполнена, текущий остаток по позиции '\(name)': \(newItem.quantity) штук")
        return (newItem, nil)
    }
    
    // выдача товара со склада
    func deliveryElement(_ name: Names, _ quantity: Int) -> (Any?, WarehouseError?) {
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { return (nil, .invalidSelection)}
        //проверка: есть ли в наличии затребованное количество
        guard item.quantity >= quantity else { return (nil, .outOfStock)}
        // производим выдачу
        var newItem = item
        newItem.quantity -= quantity
        storage[name] = newItem
        
        return (print("Операция выдачи выполнена, текущий остаток по позиции '\(name)': \(newItem.quantity) штук"), nil)
    }
}

let warehouse = Warehouse()

let operation1 = warehouse.addElement(.Router, 100)
print(warehouse.totalWeight)
warehouse.remainingStock(.Router)
let operation3 = warehouse.remainingStock(.FConnector)
let operation2 = warehouse.addElement(.FConnector, 1000)
//warehouse.allRemainingStock()
warehouse.deliveryElement(.Console, 5)
warehouse.deliveryElement(.Router, 10)

if let error = operation3.1 {
    print("Произошла ошибка \(error)")
}





// 2 задание

print("\nВТОРОЕ ЗАДАНИЕ")

// склад
class Warehouse2 {
    var storage = [
        Names.Router: Item(name: "Router", weight: 0.4, quantity: 0),
        Names.CabelRG6: Item(name: "Cabel RG-6", weight: 1, quantity: 0),
        Names.CabelUTP: Item(name: "Cabel UTP", weight: 3, quantity: 0),
        Names.Console: Item(name: "Console", weight: 0.3, quantity: 0)
    ]
    
    // общий вес всех позиций на складе
    var totalWeight: Double {
        var weight: Double = 0
        for element in storage {
            weight += element.value.weight
        }
        return weight
    }
    
    // показать остатки
    func remainingStock(_ name: Names) throws {
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { throw WarehouseError.invalidSelection }
        return print("Позиция '\(name)': осталось \(item.quantity) штук")
    }
    
    // показать остатки по всем позициям
    func allRemainingStock() throws {
        guard storage.count > 0 else { throw WarehouseError.emptyBase }
        for item in storage {
            print("Позиция '\(item.value.name)': осталось \(item.value.quantity) штук")
        }
        return print("Операция завершена")
    }
    
    // поступление товара на склад
    func addElement(_ name: Names, _ quantity: Int) throws {
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { throw WarehouseError.invalidSelection }
        // добавляем на склад
        var newItem = item
        newItem.quantity += quantity
        storage[name] = newItem
        return print("Операция поступления выполнена, текущий остаток по позиции '\(name)': \(newItem.quantity) штук")
    }
    
    // выдача товара со склада
    func deliveryElement(_ name: Names, _ quantity: Int) throws {
        // проверка: заведена ли позиция на складе
        guard let item = storage[name] else { throw WarehouseError.invalidSelection }
        //проверка: есть ли в наличии затребованное количество
        guard item.quantity >= quantity else { throw WarehouseError.outOfStock}
        // производим выдачу
        var newItem = item
        newItem.quantity -= quantity
        storage[name] = newItem
        
        return print("Операция выдачи выполнена, текущий остаток по позиции '\(name)': \(newItem.quantity) штук")
    }
}

let warehouse2 = Warehouse2()

let operation4 = warehouse.addElement(.Router, 100)
print(warehouse.totalWeight)
warehouse.remainingStock(.Router)
let operation6 = warehouse.remainingStock(.FConnector)
let operation5 = warehouse.addElement(.FConnector, 1000)
//warehouse.allRemainingStock()
warehouse.deliveryElement(.Console, 5)
warehouse.deliveryElement(.Router, 10)


// обработчик ошибок
do {
    try warehouse2.allRemainingStock()
} catch WarehouseError.emptyBase {
    print("В базе нет ни одной позиции")
}

do {
    try warehouse2.addElement(.FConnector, 1001)
} catch WarehouseError.invalidSelection {
    print("Нет такой позиции на складе")
}
