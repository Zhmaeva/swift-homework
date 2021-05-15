import UIKit
import Foundation

//1. Написать функцию, которая определяет, четное число или нет.

func checkEvenNumber(number: Int) {
    if number % 2 == 0 {
        print("Число \(number) чётное")
    } else {
        print("Число \(number) не чётное")
    }
}

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func checkDivisionNumberBy3(number: Int) {
    if number % 3 == 0 {
        print("Число \(number) делится на 3 без остатка")
    } else {
        print("Число \(number) не делится на 3 без остатка")
    }
}

//3. Создать возрастающий массив из 100 чисел.

var someInts: [Int] = []

for i in 1...100 {
    someInts.append(i)
}

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

print(someInts.filter {$0 % 2 != 0 && $0 % 3 == 0})

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов. Числа Фибоначчи определяются соотношениями F0 = 0, F1 = 1, Fn = Fn-1 + Fn-2.

func fibonacci(_ n: Int) -> [Int] {
    var arrayFibonacci = [Int]()
    if n == 0 {
        let f1 = 0
        arrayFibonacci.append(f1)
    } else if n == 1 {
        let f1 = 0
        let f2 = 1
        arrayFibonacci.append(f1)
        arrayFibonacci.append(f2)
    } else {
        let f1 = 0
        let f2 = 1
        arrayFibonacci.append(f1)
        arrayFibonacci.append(f2)
        var fib = 2
        while fib < n + 2 {
            let fib1 = (arrayFibonacci[fib - 1]) + (arrayFibonacci[fib - 2])
            arrayFibonacci.append(fib1)
            fib += 1
        }
    }
    return arrayFibonacci
}

///* 6* Заполнить массив элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n (пусть будет 100), следуя методу Эратосфена, нужно выполнить следующие шаги:
// a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
// b. Пусть переменная p изначально равна двум — первому простому числу.
// c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p.
// d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
// e. Повторять шаги c и d, пока возможно.
// */

func calculatePrimeNumbers(n: Int) -> [Int] {
    var arrayNumbers = [Int](0...n) //создаем массив от 0...n
    arrayNumbers[1] = 0
    var p = 2 // пусть переменная p равна 2, первому простому числу
    var i = 2 // индекс шага
    
    while p * p <= n { // найти числа от 2^p до n
        if arrayNumbers[p] == 0 {
            p += 1
            i = p
            continue
        }
        while i * p <= n {
            arrayNumbers[i * p] = 0
            i += 1
        }
        p += 1
        i = p
    }
    
    let primeNumbers = arrayNumbers.filter{$0 != 0}
    return primeNumbers
}

   let prime = calculatePrimeNumbers(n: 100)
print(prime)

// 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97

