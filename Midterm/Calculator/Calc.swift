//
//  Calc.swift
//  Calculator
//
//  Created by Meghan Knoll on 3/27/15.
//  Copyright (c) 2015 Meghan Knoll. All rights reserved.
//

import Foundation

class Calc {
    var calcStack = [String]()
    var newNumber : String = ""
    var radMode : Bool = false
    var modifierState : Bool = false
    
    // Clear the calculator stack
    func clear(){
        println("action: clear")
        calcStack.removeAll(keepCapacity: false)
        newNumber = ""
    }
    
    // Add an operator to the calculator stack, and return current value
    func appendOperation(op: String) -> Double? {
        println("action: \(op)")
        
        // Add number if number exists
        if newNumber != ""{
            var result = (newNumber as NSString).doubleValue
            if checkLast() == .Num {calcStack.removeLast()}
            calcStack.append("\(result)")
            newNumber = ""
        }
        
        // if calculator was waiting for a second input, perform operation now
        if modifierState && checkLast() == .Num{
            modifierState = false
            var secondNumber = (calcStack.removeLast() as NSString).doubleValue
            var modifier = calcStack.removeLast()
            var firstNumber = (calcStack.removeLast() as NSString).doubleValue
            
            switch modifier {
                case "x^y":
                    secondNumber = pow(firstNumber,secondNumber)
                    calcStack.append("\(secondNumber)")
                case "EE":
                    secondNumber = firstNumber * pow(10,secondNumber)
                    calcStack.append("\(secondNumber)")
                case "y√x":
                    secondNumber = pow(firstNumber, 1.0/secondNumber)
                    calcStack.append("\(secondNumber)")
                default:
                    break
            }
        } else if modifierState {
            modifierState = false
        }
        
        // Push the new operation to the calc stack, and return result of the current expression
        if calcStack.count != 0 {
            switch op {
                case "x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("*")
                    return evaluateExpression(false)
                case "÷":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("/")
                    return evaluateExpression(false)
                case "+":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("+")
                    return evaluateExpression(false)
                case "-":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("-")
                    return evaluateExpression(false)
                case "+/-":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("*")
                    calcStack.append("-1.00")
                    return evaluateExpression(true)
                case "%":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    calcStack.append("/")
                    calcStack.append("100.00")
                    return evaluateExpression(true)
                case "x^2":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(lastNumber,2)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "x^3":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(lastNumber,3)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "x^y":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    modifierState = true
                    calcStack.append("x^y")
                    return (calcStack[calcStack.count - 2] as NSString).doubleValue
                case "EE":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    modifierState = true
                    calcStack.append("EE")
                    return (calcStack[calcStack.count - 2] as NSString).doubleValue
                case "10^x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(10.0,lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "e^x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(e,lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "ln":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = log(lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "log10":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = log10(lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "sin":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = radMode ? sin(lastNumber) : sin(toRadians(lastNumber))
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "cos":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = radMode ? cos(lastNumber) : cos(toRadians(lastNumber))
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "tan":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = radMode ? tan(lastNumber) : tan(toRadians(lastNumber))
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "sinh":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = sineH(lastNumber)
                    println("sinh: \(lastNumber)")
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "cosh":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = cosineH(lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "tanh":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = tangentH(lastNumber)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "x!":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    if factorial(lastNumber) == nil{
                        clear()
                        return nil
                    } else {
                        lastNumber = factorial(lastNumber)!
                        calcStack.append("\(lastNumber)")
                        return lastNumber
                    }
                case "1/x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = 1.0/lastNumber
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "2√x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(lastNumber, 1.0/2.0)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "3√x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var lastNumber = (calcStack.removeLast() as NSString).doubleValue
                    lastNumber = pow(lastNumber, 1.0/3.0)
                    calcStack.append("\(lastNumber)")
                    return lastNumber
                case "y√x":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    modifierState = true
                    calcStack.append("y√x")
                    return (calcStack[calcStack.count - 2] as NSString).doubleValue
                case "=":
                    if checkLast() == .Operation {calcStack.removeLast()}
                    var expression = evaluateExpression(true)
                    calcStack.removeAll(keepCapacity: false)
                    calcStack.append("\(expression)")
                    return expression
                default:
                    return 0.0
            }
        }
        return 0.0
    }
    
    // Return type of the last item in the calc stack
    func checkLast() -> CharacterType {
        var last = calcStack.count - 1
        
        if calcStack.isEmpty {
            return CharacterType.Empty
        } else if calcStack[last] != "0.0" &&  (calcStack[last] as NSString).doubleValue == 0.0 {
            return CharacterType.Operation
        }
        return CharacterType.Num
    }
    
    // Evaluate the current expression in calc stack
    func evaluateExpression(fullExpression: Bool) -> Double{
        var expression = ""
        let limit = fullExpression ? (calcStack.count - 1) : (calcStack.count - 2)
        
        for index in 0...limit {
            expression += calcStack[index]
        }
        
        println("raw: \(expression)")
        let expn = NSExpression(format: expression)
        println("formatted: \(expn) = \(expn.expressionValueWithObject(nil, context: nil))")
        
        return expn.expressionValueWithObject(nil, context: nil) as Double
        
    }
    
    // Add a number to the calculator stack and return the current string
    func appendNumber(num: String) -> String {
        println("number: \(num)")
        
        switch num {
            case "0":
                newNumber += (newNumber == "0") ? "" : "0"
                return newNumber
            case ".":
                newNumber += (newNumber.rangeOfString(".") != nil) ? "" : "."
                newNumber = newNumber == "." ? "0." : newNumber
                return newNumber
            case "π":
                if checkLast() == .Num {calcStack.removeLast()}
                calcStack.append("\(pi)")
                newNumber = ""
                return "\(pi)"
            case "Rand":
                if checkLast() == .Num {calcStack.removeLast()}
                var random = Double(arc4random_uniform(1000000000))/1000000000
                calcStack.append("\(random)")
                newNumber = ""
                return "\(random)"
            case "e":
                if checkLast() == .Num {calcStack.removeLast()}
                calcStack.append("\(e)")
                newNumber = ""
                return "\(e)"
            default:
                newNumber = (newNumber == "0") ? num : newNumber + num
                return newNumber
            
        }
        
       
    }

    // Handles positive, negative and fraction factorials
    func factorial(num : Double) -> Double? {
        if (num == 0.0){
            return 1.0
        }else if (num < 0.0){
            if (fmod(num, floor(num)) == 0.0){
                return nil
            }else{
                return tgamma(num + 1.0)
            }
        }
        else{
            if (fmod(num, floor(num)) == 0.0){
                return round(exp(lgamma(num + 1.0)))
            }else{
                return tgamma(num + 1.0)
            }
        }
    }
    
    // Corrects the iOS TANH function - only works for Radians
    func tangentH(num: Double) -> Double {
        return sineH(num) / cosineH(num)
    }
    
    // Corrects the iOS SINH function - only works for Radians
    func sineH(num: Double) -> Double {
        return (pow(M_E,num) - pow(M_E,(-1*num)))/2
    }
    
    // Corrects the iOS COSH function - only works for Radians
    func cosineH(num: Double) -> Double {
        return (pow(M_E,num) + pow(M_E,(-1*num)))/2
    }
    
    // Converts a degree input to radians
    func toRadians(num: Double) -> Double {
        return num * (M_PI/180)
    }
}