//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yi Hua on 5/15/16.
//  Copyright © 2016 Hawaiii. All rights reserved.
//

import Foundation

func multiply(op1: Double,op2: Double) -> Double{
    return op1 * op2
}

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double){
        accumulator = operand
    }
    
    
    var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryOperation(sqrt),
        "✕": Operation.BinaryOperation(multiply),
        // TODO
        "=": Operation.Equals
        
    ]
    
    enum Operation {
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
//                pending!.firstOperand = accumulator
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = pendingBinaryOperationInfo(binaryOperation: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
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
    
    struct pendingBinaryOperationInfo {
        var binaryOperation: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double{
        get { // read-only because only has get and no set
            return accumulator
        }
    }
}