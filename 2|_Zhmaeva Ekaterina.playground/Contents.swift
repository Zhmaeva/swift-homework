import Cocoa
import Darwin.C.math

//1. Написать функцию, которая определяет, четное число или нет.

let randomInt = Int.random(in: 1..<10000)

if (randomInt % 2) == 0 {
    print("Число", randomInt, "четное")
} else {
    print("Число", randomInt, "нечетное")
}

print("------------------------------", "\n")

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

if (randomInt % 3) == 0 {
    print("Число", randomInt, "делится на 3 без остатка")
} else  {
    print("Число", randomInt, "не делится на 3 без остатка")
}

//или так:
//var divide3 = ((randomInt) % 3) == 0 ? "делится на 3" : "не делится на 3"

print("------------------------------", "\n")

//3. Создать возрастающий массив из 100 чисел.
var indexArray = Array(1...100)
    print("Массив из 100 ", indexArray)

print("------------------------------", "\n")

//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

for value in indexArray {
    if (value % 2) == 0 {
    indexArray.remove(at: indexArray.firstIndex(of: value)!)
    }
}
    print("Массив из нечетных чисел", indexArray)

print("------------------------------", "\n")

for value in indexArray {
    if (value % 3) != 0 {
    indexArray.remove(at: indexArray.firstIndex(of: value)!)
    }
}
    print("Массив из нечетных чисел делящихся на 3", indexArray)

print("------------------------------", "\n")

//5. Написать функцию, которая добавляет в массив новое число Фибоначчи F0 = 0, F1 = 1, Fn = Fn=Fn-1 + Fn-2

func fibonacci(_ n: Int) -> [Int] {
    var arrayFibonacci = [Int]()
    if n == 1 {
        let f0 = 0
        arrayFibonacci.append(f0)
    } else if n == 2 {
        let f1 = 1
        let f0 = 0
        arrayFibonacci.append(f0)
        arrayFibonacci.append(f1)
    } else {
        let f1 = 1
        let f0 = 0
        arrayFibonacci.append(f0)
        arrayFibonacci.append(f1)
        var fib = 2
        while fib < n + 2 {
            let fibN = (arrayFibonacci[fib - 1]) + (arrayFibonacci[fib - 2])
            arrayFibonacci.append(fibN)
            fib += 1
        }
    }
    return arrayFibonacci
}

print("Числа Фибоначчи", fibonacci(50))
print("------------------------------", "\n")

/*6. Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
b. Пусть переменная p изначально равна двум — первому простому числу.
c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
e. Повторять шаги c и d, пока возможно*/
 
func getPrimeNumbers(n: Int) -> Array<Int> {
    var numbers = Array(0...n)
    numbers[1] = 0
    
    var step = 2;
    
    var index = 2
    
    while step*step <= n {
        if numbers[step] == 0 {
            step+=1;
            index = step
            continue
        }

        while index * step <= n {
            numbers[index * step] = 0

            index+=1
        }
        step+=1;
        index = step
    }
    
    let prime = numbers.filter{ $0 != 0}
    
    return prime
}

// 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97

let primeNumbers = getPrimeNumbers(n: 100);

print(primeNumbers)
