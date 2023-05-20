//
//  Evaluate.swift
//  MathExpressionPretty
//
//  Created by Connor Reed on 5/20/23.
//

import Foundation

class Evaluator{
    init(){
    }
    
    func evaluate(expr: Expr) -> Double{
        switch(expr.type){
        case "Binary":
            return handleBinary(expr: expr as! Expr.Binary)
        case "Unary":
            return handleUnary(expr: expr as! Expr.Unary)
        case "Literal":
            return handleLiteral(expr: expr as! Expr.Literal)
        case "Grouping":
            return handleGrouping(expr: expr as! Expr.Grouping)
        case "Call":
            return handleCall(expr: expr as! Expr.Call)
        default:
            break
        }
        return 0
    }
    
    func handleCall(expr: Expr.Call) -> Double {
        let val = evaluate(expr: expr.value)
        switch(expr.literal.value){
        case "sqrt":
            return sqrt(val)
        case "sin":
            return sin(val)
        case "cos":
            return cos(val)
        case "tan":
            return tan(val)
        default:
            break
        }
        return 0
    }
    
    func handleGrouping(expr: Expr.Grouping) -> Double{
        return evaluate(expr: expr.content)
    }

    func handleLiteral(expr: Expr.Literal) -> Double{
        if(expr.value == "PI" || expr.value == "pi"){
            return Double.pi
        }
        return Double(expr.value) ?? 0
    }
    
    func handleUnary(expr: Expr.Unary) -> Double{
        return -1 * evaluate(expr: expr.right)
    }
    
    func handleBinary(expr: Expr.Binary) -> Double{
        switch(expr.op.type){
        case .Addition:
            return evaluate(expr: expr.left) + evaluate(expr: expr.right)
        case .Subtraction:
            return evaluate(expr: expr.left) - evaluate(expr: expr.right)
        case .Multiplication:
            return evaluate(expr: expr.left) * evaluate(expr: expr.right)
        case .Division:
            return evaluate(expr: expr.left) / evaluate(expr: expr.right)
        case .Exp:
            return pow(evaluate(expr: expr.left), evaluate(expr: expr.right))
        default:
            break
        }
        return 0
    }
}
