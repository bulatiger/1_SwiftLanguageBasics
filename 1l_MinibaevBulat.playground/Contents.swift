import UIKit

// 1. Функция решения квадратного уравнения вида "ax^2 + bx + c = 0", где "a", "b" и "c" не равняются 0

func quadraticEquation(a: Double, b: Double, c: Double) -> (Double?, Double?) {
    let discriminant = pow(b, 2) - (4 * a * c)
    if discriminant > 0 {
        let x1 = (-b + sqrt(discriminant)) / (2 * a)
        let x2 = (-b - sqrt(discriminant)) / (2 * a)
        print("Уравнение имеет 2 корня: x1 = \(x1), x2 = \(x2)")
        return (x1, x2)
    } else if discriminant == 0 {
        let x = -b / (2 * a)
        print("Уравнение имеет 1 корень: x = \(x)")
        return (x, nil)
    }
    print("Уравнение не имеет корней")
    return (nil, nil)
}


// 2. Функция вычисления площади, периметра и гипотенузы прямоугольного треугольника по двум катетам

func triangle(a: Double, b: Double) -> (Double, Double, Double) {
    let area = a * b / 2
    let hypotenuse = sqrt(pow(a, 2) + pow(b, 2))
    let perimeter = a + b + hypotenuse
    print("Площадь треугольника равна \(area), периметр равен \(perimeter), гипотенуза равна \(hypotenuse)")
    return (area, perimeter, hypotenuse)
}


// 3. Функция подсчета суммы вклада в банке

func calculatingDeposit(amount: Double, percent: Double, years: Int) -> Double {
    var result = amount
    guard years > 0 else {
        print("Срок вклада не может быть меньше года")
        return amount
    }
    for i in 1...years {
        result += result * percent / 100
        print("Через \(i) год(а) сумма вклада составит \(result)")
    }
    return result
}


