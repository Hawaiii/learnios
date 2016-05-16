//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yi Hua on 5/15/16.
//  Copyright © 2016 Hawaiii. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
        description += String(operand)
    }
    
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "±": Operation.UnaryOperation({ -$0 }),
        "✕": Operation.BinaryOperation({ $0 * $1 }),
        "÷": Operation.BinaryOperation({ $0 / $1 }),
        "+": Operation.BinaryOperation({ $0 + $1 }),
        "-": Operation.BinaryOperation({ $0 - $1 }),
        "=": Operation.Equals
        
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double, Double) -> Double)
        case Equals
    }
    
    func performOperation (symbol: String){
        if let operation = operations[symbol]{
            switch operation{
                
            case .Constant (let value):
                accumulator = value
                description += symbol
                
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
                description = symbol + "(" + description + ")"
                
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
                description = "(" + description + ")" + symbol
                isPartialResult = true
                
            case .Equals:
                executePendingBinaryOperation()
                isPartialResult = false
            }
        }
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryOperation(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: pendingBinaryOperationInfo?
    
    private struct pendingBinaryOperationInfo {
        var binaryOperation: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get { // read-only because only has get and no set
            return accumulator
        }
    }
    
    private var description = ""
    
    var isPartialResult = false
    
    func getDescription() -> String {
        if isPartialResult {
            return description + "..."
        } else {
            return description
        }
    }
}