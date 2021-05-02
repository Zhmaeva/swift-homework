import UIKit
import Foundation


//Задание 1| Решить квадратное уравнение ax^2 + bx + c = 0.

func solveQuadraticEquation(a: Int, b: Int, c: Int) {
    let d = pow(Double(b), 2) - 4 * Double(a) * Double(c)
    print("Решим квадратное уравнение: \n\(a)x^2 + \(b)x + \(c) = 0\n")
    if d == 0 {
        let x1 = Int((Double(-b) + sqrt(d)) / (2 * Double(a)))
        print("Корень x1 = \(x1)")
    } else if d > 0 {
        let x1 = Int((Double(-b) + sqrt(d)) / (2 * Double(a)))
        let x2 = Int((Double(-b) - sqrt(d)) / (2 * Double(a)))
        print("Получаем два корня:" +
                "\nКорень x1 = \(x1)" +
                "\nКорень x2 = \(x2)")
    } else {
        print("У данного уравнения нет корней")
    }
}

solveQuadraticEquation(a: 4, b: 67, c: 8)
print("----------------------------------------\n")


//Задание 2| Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

func solveTreangle(length: Double, width: Double) {
    var hipotenuse = sqrt(pow(length, 2)+(pow(width, 2)))
    hipotenuse = round((hipotenuse * 100) / 100)
    var area = ((length * width) / 2)
    area = round((area * 100) / 100)
    var perimeter = (length + width + hipotenuse)
    perimeter = round((perimeter * 100) / 100)
    
    print("""
    Катет трегольника а = \(length)
    Катет треугольника b = \(width)
    Гипотенуза треугольника = \(hipotenuse)
    Площадь треугольника = \(area)
    Периметр треугольника = \(perimeter)
""")
}

solveTreangle(length: 7, width: 9)

print("----------------------------------------\n")

/*
 Задание 3|
 Пользователь вводит сумму вклада в банк и годовой процент.
 Найти сумму вклада через 5 лет.
 */

func сalculationOfIncome(depositAmount: Double, percent: Double, time: Int) {
    var amount = depositAmount
    for _ in 1...time {
        amount += (amount/100) * percent
    }
    
    print("""
    Сумма вклада \(String.init(format: "%0.0f", depositAmount)) рублей
    Процентная ставка \(String.init(format: "%0.0f", percent)) %
    Через \(time) лет сумма вклада составляет: \(String.init(format: "%0.2f",amount)) рублей
""")
}

сalculationOfIncome(depositAmount: 50000, percent: 3, time: 5)

