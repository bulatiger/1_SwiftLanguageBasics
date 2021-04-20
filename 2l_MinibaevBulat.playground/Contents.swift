import UIKit

// 1. функция определения числа на четность
func isEvenNumber(_ num: Int) -> Bool {
    return (num % 2 == 0)
}



// 2. функция определения делимости числа на 3
func isNumberDivisibleByThree(_ num: Int) -> Bool {
    return (num % 3 == 0)
}



// 3. Возрастающий массив из 100 чисел
var array = [Int](1...100)



// 4. Удаляем из массива все четные числа и числа, которые не делятся на 3, используя функции из первых заданий
for item in array where isEvenNumber(item) || !isNumberDivisibleByThree(item) {
    array.remove(at: array.firstIndex(of: item)!)
}



// 5. Функция создания массива из чисел Фибоначчи
func fibonacciArray(count: Int) -> [Double] {
    // функция добавления следующего числа в массив
    func addNumberFibonacci(to array: inout [Double]) {
        switch array.count {
        case 0:
            array.append(0)
        case 1, 2:
            array.append(1)
        default:
            array.append(array[array.count - 1] + array[array.count - 2])
        }
    }
    // создаем массив и добавлем требуемое количество чисел Фибоначчи
    var fibonacciArray = [Double]()
    while fibonacciArray.count < count {
        addNumberFibonacci(to: &fibonacciArray)
    }
    return fibonacciArray
}



// 6. Функция создания массива из натуральных чисел
func primeNumbersArray(count: Int) -> [Int] {
    // функция определения на простое число
    func isPrimeNumber(_ num: Int) -> Bool {
        // пытаемся делить наше число на все числа больше 1 и меньше нашего
        guard (num > 1) else { return false }
        for i in (2..<num) where (num % i == 0) {
            return false
        }
        return true
    }
    // Создаем массив и добавляем требуемое количество простых чисел
    var primeNumbersArray = [Int]()
    var i = 1
    while primeNumbersArray.count < count {
        if isPrimeNumber(i) {
            primeNumbersArray.append(i)
        }
        i += 1
    }
    return primeNumbersArray
}


// 6.2 Также сделал по методу, который в методичке
var primeNumbers = [Int](2...100)
var p = 2
// Функция фильтрации массива
func sortPrimeNumbers(_ array: inout [Int]) {
    for i in stride(from: 2 * p, through: array.last!, by: p) {
        if let index = array.firstIndex(of: i) {
            array.remove(at: index)
        }
    }
    for item in array where item > p {
        p = item
        sortPrimeNumbers(&array)
    }
}

sortPrimeNumbers(&primeNumbers)
print(primeNumbers)


// когда значение "p" пытаюсь внутрь функции засунуть, то очень долго обрабатывает если "n" больше 50, не пойму почему, когда выставил n=100 думал что зависло (закомментировал пример ниже). Хотя в верхнем примере почти тоже самое, но хоть 1000 выставляй, все быстро отрабатывает

/*
var primeNumbers = [Int](2...40)
// Функция фильтрации массива
func sortPrimeNumbers(_ array: inout [Int], p: Int = 2) {
    for i in stride(from: 2 * p, through: array.last!, by: p) {
        if let index = array.firstIndex(of: i) {
            array.remove(at: index)
        }
    }
    for item in array where item > p {
        sortPrimeNumbers(&array, p: item)
    }
}

sortPrimeNumbers(&primeNumbers)

print(primeNumbers)
*/


