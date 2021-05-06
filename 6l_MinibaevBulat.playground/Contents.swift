import UIKit

struct Queue<T: Comparable> {
    private var elements = [T]()
    
    mutating func enqueue(element: T) {
        elements.append(element)
    }
    mutating func dequeue() ->T? {
        guard (!elements.isEmpty) else {return nil}
        return elements.removeFirst()
    }
    mutating func filter() {
        elements.sort {$0 > $1}
    }
    // выводим запрашиваемое количество элементов
    subscript(index: Int) -> [T]? {
        guard (index > 0) && (index <= elements.count) && (!elements.isEmpty) else {return nil}
        return Array(elements[0...index-1])
    }
}

var intQueue = Queue<Int>()
intQueue.dequeue()
intQueue[2]
intQueue.enqueue(element: 1)
intQueue.enqueue(element: 2)
intQueue.enqueue(element: 3)
intQueue.enqueue(element: 4)
intQueue[3]
print(intQueue[3])
print(intQueue[0])
intQueue.filter()
print(intQueue[3])


print("------------------------")
var stringQueue = Queue<String>()
stringQueue.enqueue(element: "one")
stringQueue.enqueue(element: "two")
stringQueue.enqueue(element: "three")
stringQueue.enqueue(element: "four")
stringQueue.enqueue(element: "five")
stringQueue[3]
print(stringQueue[3])
print(stringQueue[0])
stringQueue.filter()
print(stringQueue[3])

