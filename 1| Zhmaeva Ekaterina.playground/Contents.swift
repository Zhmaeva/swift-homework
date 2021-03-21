import Cocoa
import Darwin.C.math

/*
 Задание 1|
 Решить квадратное уравнение ax^2 + bx + c = 0
 где a, b, c некоторые числа, х неизвестное
*/

var a: Double = 5
var b: Double = 18
var c: Double = 0

print(a, "x^2 +", b, "x +", c, "= 0")
var x1: Double = 0
var x2: Double = 0

let D: Double = pow(b, 2) - 4 * a * c

if (D < 0) {
    print("У уравнения нет корней")
}

if (D == 0) {
    x1 = (-b + sqrt(D)) / (2 * a)
    print("x1 =", x1)
}

if (D > 0) {
    x1 = (-b + sqrt(D)) / (2 * a)
    x2 = (-b - sqrt(D)) / (2 * a)
    print("x1 =", x1, "\nx2 =", x2)
}

/*
 Задание 2|
 Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.
*/

var length: Double = 8
var widht: Double = 6
var hipotenuse: Double = sqrt(pow(length, 2)+(pow(widht, 2)))
var area: Double = ((length * widht) / 2)
var perimeter: Double = (length + widht + hipotenuse)

print("\n\n")
print("Катет трегольника а = ", length)
print("Катет треугольника b = ", widht)
print("Гипотенуза треугольника = ", hipotenuse)
print("Площадь треугольника = ", area)
print("Периметр треугольника = ", perimeter)

/*
 Задание 3|
 Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.
 */
print("\n\n")
var amount: Double = 100000
print("Сумма вклада", amount)
var percent: Double = 8
print("Процентная ставка", percent)
let coefficient = percent / 100

var year1 = amount + (amount * coefficient)
var year2 = year1 + (year1 * coefficient)
var year3 = year2 + (year2 * coefficient)
var year4 = year3 + (year3 * coefficient)
var year5 = year4 + (year4 * coefficient)

print("Изменение размера вклада по годам: \n",
"1 год: ", year1, " рублей\n",
"2 год: ", year2, " рублей\n",
"3 год: ", year3, " рублей\n",
"4 год: ", year4, " рублей\n",
"5 год: ", year5, " рублей\n")
