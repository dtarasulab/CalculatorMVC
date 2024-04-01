//
//  CalculatorModel.swift
//  Calculator Layout iOS13
//
//  Created by user251120 on 3/30/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorModel {
    
    var currentNum = 0.0
    var previousNum = 0.0
    var operation = ""
    var function = ""
    
    mutating func performOperation(with newNumber: Double) -> Double {
        switch operation {
        case "":
            return newNumber
        case "+":
            currentNum += previousNum
        case "-":
            currentNum = previousNum - currentNum
        case "×":
            currentNum *= previousNum
        case "÷":
            currentNum = previousNum / currentNum
        default:
            break
        }
        return currentNum
    }
    
    mutating func performFunction(with newNumber: Double) -> Double {
        switch function {
        case "%":
            currentNum /= 100
        case "+/-":
            currentNum *= -1
        case "x²":
            currentNum *= currentNum
        case "√x":
            currentNum = sqrt(currentNum)
        case "1/x":
            currentNum = 1 / currentNum
        case "ln(x)":
            currentNum = log(currentNum)
        default:
            break
        }
        return currentNum
    }
    
    mutating func setOperation(_ newOperation: String) {
        operation = newOperation
        previousNum = currentNum
    }
    
    mutating func setFunction(_ newFunction: String) {
        function = newFunction
    }
    
    mutating func reset() {
        currentNum = 0
        previousNum = 0
        operation = ""
    }
}
